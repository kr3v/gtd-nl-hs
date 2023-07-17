{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE BlockArguments #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeOperators #-}

module Main where

import Control.Concurrent (MVar, newMVar, putMVar, takeMVar, modifyMVar_, readMVar, threadDelay, forkIO)
import Control.Lens (makeLenses, (<+=), (^.))
import Control.Monad.Cont (MonadIO (..))
import Control.Monad.Except (runExceptT)
import Control.Monad.Logger (runFileLoggingT, runStdoutLoggingT, filterLogger, LogLevel (LevelDebug))
import Control.Monad.Reader (ReaderT (runReaderT))
import Control.Monad.State (StateT (runStateT), execStateT)
import Control.Monad.State.Lazy (evalStateT)
import Data.Proxy (Proxy (..))
import GHC.TypeLits (KnownSymbol)
import GTD.Configuration (GTDConfiguration (_logs), prepareConstants, root)
import GTD.Resolution.State (Context, emptyContext)
import GTD.Server (DefinitionRequest (..), DefinitionResponse (..), definition)
import GTD.Utils (logDebugNSS, peekM, ultraZoom)
import Network.Socket (Family (AF_INET), SockAddr (SockAddrInet), SocketType (Stream), bind, defaultProtocol, listen, socket, socketPort, tupleToHostAddress, withSocketsDo)
import Network.Wai.Handler.Warp (defaultSettings, runSettingsSocket)
import Servant (Header, Headers, JSON, Post, ReqBody, addHeader, type (:<|>) (..), type (:>))
import Servant.Server (Handler, serve)
import System.Directory (getCurrentDirectory, setCurrentDirectory)
import System.FilePath ((</>))
import System.Posix (getProcessID, exitImmediately)
import Text.Printf (printf)
import GTD.Resolution.State.Caching.Cabal (cabalCacheGet)
import System.Exit (ExitCode (..))

data ServerState = ServerState
  { _context :: Context,
    _reqId :: Int
  }

$(makeLenses ''ServerState)

emptyServerState :: ServerState
emptyServerState = ServerState {_context = emptyContext, _reqId = 0}

-- two methods:
-- definition - to obtain a source span for a given word
-- ping - to check if the server is alive
type API =
  "definition"
    :> ReqBody '[JSON] DefinitionRequest
    :> Post '[JSON] (Headers '[Header "X-Request-ID" String] DefinitionResponse)
    :<|> "ping"
      :> Post '[JSON] String

api :: Proxy API
api = Proxy

type AppM = StateT (MVar ServerState) IO

type ServerStateC = MVar ServerState

nt :: ServerStateC -> AppM a -> Handler a
nt s x = liftIO (evalStateT x s)

definitionH ::
  KnownSymbol h =>
  GTDConfiguration ->
  MVar ServerState ->
  DefinitionRequest ->
  Handler (Headers '[Header h String] DefinitionResponse)
definitionH c m req = do
  s <- liftIO $ takeMVar m
  (r, s') <- flip runStateT s $ do
    rq <- reqId <+= 1
    let reqId = printf "%06d" rq
    let logP = _logs c </> (reqId ++ ".log")
    liftIO $ putStrLn $ "Got request with ID:" ++ show reqId

    let peekF r = logDebugNSS "definition" $ printf "%s@%s -> %s" (word req) (file req) (show r)
    r' <- ultraZoom context $ runFileLoggingT logP $ filterLogger (\_ l -> l /= LevelDebug) $ peekM peekF $ runReaderT (runExceptT $ definition req) c
    case r' of
      Left e -> return $ addHeader reqId DefinitionResponse {srcSpan = Nothing, err = Just e}
      Right r -> return $ addHeader reqId r
  liftIO $ putMVar m s'
  return r

pingH :: MVar ServerState -> Handler String
pingH m = do
  liftIO $ modifyMVar_ m $ \s -> return s {_reqId = _reqId s + 1}
  return "pong"

selfKiller :: MVar ServerState -> IO ()
selfKiller m = do
  s1 <- _reqId <$> readMVar m
  threadDelay $ 60 * 1000 * 1000
  m' <- takeMVar m
  let s2 = _reqId m'
  if s1 == s2
    then do
      putStrLn "No requests for 60 seconds, exiting _now_"
      exitImmediately ExitSuccess
    else do
      putMVar m m'
      selfKiller m

main :: IO ()
main = withSocketsDo $ do
  let addr = SockAddrInet 0 (tupleToHostAddress (127, 0, 0, 1))
  sock <- socket AF_INET Stream defaultProtocol
  bind sock addr
  listen sock 5
  port <- socketPort sock
  printf "port=%s\n" (show port)

  constants <- prepareConstants
  setCurrentDirectory (constants ^. root)
  getCurrentDirectory >>= print
  print constants

  pid <- getProcessID

  writeFile (constants ^. root </> "pid") (show pid)
  writeFile (constants ^. root </> "port") (show port)

  s <- newMVar =<< runReaderT (runStdoutLoggingT $ execStateT (ultraZoom context cabalCacheGet) emptyServerState) constants
  _ <- forkIO $ selfKiller s
  runSettingsSocket defaultSettings sock $ serve api (definitionH constants s :<|> pingH s)
