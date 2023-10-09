{-# LANGUAGE BlockArguments #-}
{-# LANGUAGE ConstraintKinds #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}

module GTD.Server.Cpphs where

import Control.Monad.Except (MonadError (..))
import Data.Aeson (FromJSON, ToJSON)
import GHC.Generics (Generic)
import GTD.Haskell.Cpphs (haskellApplyCppHs)
import GTD.Server.Definition (cabalPackage)
import GTD.State (MS)
import GTD.Utils (storeIOExceptionToMonadError, updateStatus)
import Text.Printf (printf)

data CpphsRequest = CpphsRequest
  { _workDir :: FilePath,
    _file :: FilePath
  }
  deriving (Show, Generic)

data CpphsResponse = CpphsResponse
  { _content :: Maybe String,
    _err :: Maybe String
  }
  deriving (Show, Generic)

instance FromJSON CpphsRequest

instance ToJSON CpphsRequest

instance FromJSON CpphsResponse

instance ToJSON CpphsResponse

cpphs ::
  CpphsRequest ->
  (MS m, MonadError String m) => m CpphsResponse
cpphs (CpphsRequest {_workDir = wd, _file = rf}) = do
  updateStatus $ printf "executing `cpphs` for %s..." rf
  _ <- cabalPackage wd rf
  content <- storeIOExceptionToMonadError $ readFile rf
  r <- haskellApplyCppHs rf content
  updateStatus ""
  return $ CpphsResponse (Just r) Nothing
