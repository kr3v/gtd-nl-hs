{-# LANGUAGE BlockArguments #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeFamilies #-}

module GTD.Cabal.Parse where

import Control.Monad (forM_, when)
import Control.Monad.Logger (LogLevel (LevelDebug), MonadLoggerIO (..))
import Control.Monad.RWS (MonadReader (..), MonadWriter (..), asks)
import Control.Monad.Trans (MonadIO (liftIO))
import Control.Monad.Trans.Control (MonadBaseControl)
import Control.Monad.Trans.Writer (execWriter, execWriterT)
import qualified Data.Aeson.Encode.Pretty as JSON (encodePretty)
import qualified Data.ByteString as BS
import qualified Data.ByteString.Lazy as BSL
import qualified Data.Set as Set
import Distribution.Package (PackageIdentifier (..), packageName, unPackageName)
import Distribution.PackageDescription (BuildInfo (..), LibraryName (..), unUnqualComponentName)
import qualified Distribution.PackageDescription as Cabal (Benchmark (..), BenchmarkInterface (..), BuildInfo (..), Dependency (..), Executable (..), Library (..), PackageDescription (..), TestSuite (..), TestSuiteInterface (..), explicitLibModules, unPackageName)
import Distribution.PackageDescription.Configuration (flattenPackageDescription)
import Distribution.PackageDescription.Parsec (parseGenericPackageDescription, runParseResult)
import Distribution.Pretty (prettyShow)
import Distribution.Utils.Path (getSymbolicPath)
import GTD.Cabal.Types (Dependency (..), Designation (Designation, _desName, _desType), DesignationType (..), Package (..), PackageModules (..), PackageWithUnresolvedDependencies, emptyPackageModules)
import GTD.Configuration (Args (_logLevel), GTDConfiguration (..))
import GTD.Resolution.Cache.Utils (binaryGet, binaryPut, pathAsFile)
import GTD.Utils (encodeWithTmp, logDebugNSS, removeIfExistsL)
import System.FilePath (dropExtension, normalise, takeDirectory, (</>))
import qualified Data.ByteString.Char8 as BSC8

---

parse :: FilePath -> FilePath -> (MonadLoggerIO m, MonadReader GTDConfiguration m, MonadBaseControl IO m) => m [PackageWithUnresolvedDependencies]
parse root p = do
  c <- asks _cache
  ll <- asks $ _logLevel . _args
  let pc = c </> pathAsFile p
  binaryGet pc >>= \case
    Just r -> return r
    Nothing -> do
      r <- __read'direct root p
      binaryPut pc r
      liftIO $ when (ll == LevelDebug) $ encodeWithTmp BSL.writeFile (pc ++ ".json") (JSON.encodePretty r)
      return r

remove :: FilePath -> (MonadLoggerIO m, MonadReader GTDConfiguration m) => m ()
remove p = do
  c <- asks _cache
  let pc = c </> pathAsFile p
  removeIfExistsL pc

__read'packageDescription :: FilePath -> (MonadLoggerIO m) => m Cabal.PackageDescription
__read'packageDescription p = do
  (warnings, epkg) <- liftIO $ runParseResult . parseGenericPackageDescription <$> BS.readFile p
  forM_ warnings (\w -> logDebugNSS "cabal read" $ "got warnings for `" ++ p ++ "`: " ++ show w)
  liftIO $ either (fail . show) (return . flattenPackageDescription) epkg

__read'direct :: FilePath -> FilePath -> (MonadLoggerIO m) => m [PackageWithUnresolvedDependencies]
__read'direct root p = do
  logDebugNSS "cabal read" p
  pd <- __read'packageDescription p

  execWriterT $ do
    -- TODO: benchmarks, test suites
    let p0 =
          Package
            { _name = unPackageName $ packageName pd,
              _version = pkgVersion $ Cabal.package pd,
              _root = normalise $ takeDirectory p,
              _path = p,
              _projectRoot = root,
              _designation = Designation {_desType = Library, _desName = Nothing},
              _modules = emptyPackageModules,
              _dependencies = []
            }
    let lh lib = tell . pure $ do
          p0
            { _designation = Designation {_desType = Library, _desName = libraryNameToDesignationName $ Cabal.libName lib},
              _modules = __exportsL lib,
              _dependencies = __depsU $ Cabal.libBuildInfo lib
            }
    forM_ (Cabal.library pd) lh
    forM_ (Cabal.subLibraries pd) lh
    forM_ (Cabal.executables pd) $ \exe ->
      tell . pure $ do
        p0
          { _designation = Designation {_desType = Executable, _desName = Just $ unUnqualComponentName $ Cabal.exeName exe},
            _modules = __exportsE exe,
            _dependencies = __depsU $ Cabal.buildInfo exe
          }
    forM_ (Cabal.testSuites pd) $
      tell . pure . \ts ->
        p0
          { _designation = Designation {_desType = TestSuite, _desName = Just $ unUnqualComponentName $ Cabal.testName ts},
            _modules = __exportsT ts,
            _dependencies = __depsU $ Cabal.testBuildInfo ts
          }

    forM_ (Cabal.benchmarks pd) $
      tell . pure . \bm ->
        p0
          { _designation = Designation {_desType = Benchmark, _desName = Just $ unUnqualComponentName $ Cabal.benchmarkName bm},
            _modules = __exportsB bm,
            _dependencies = __depsU $ Cabal.benchmarkBuildInfo bm
          }

---

-- TODO: `reexportedModules` actually
__exportsL :: Cabal.Library -> PackageModules
__exportsL lib =
  PackageModules
    { _srcDirs = getSymbolicPath <$> (hsSourceDirs . Cabal.libBuildInfo) lib,
      _exports = Set.fromList $ BSC8.pack . prettyShow <$> Cabal.exposedModules lib,
      _reExports = Set.fromList $ BSC8.pack . prettyShow <$> Cabal.reexportedModules lib,
      _allKnownModules = Set.fromList $ BSC8.pack . prettyShow <$> Cabal.explicitLibModules lib
    }

__pathAsModule :: FilePath -> BSC8.ByteString
__pathAsModule = BSC8.pack . fmap (\x -> if x == '/' then '.' else x) . dropExtension

__exportsE :: Cabal.Executable -> PackageModules
__exportsE exe = do
  let mainIs = __pathAsModule . Cabal.modulePath $ exe
  PackageModules
    { _srcDirs = getSymbolicPath <$> (hsSourceDirs . Cabal.buildInfo) exe,
      _exports = Set.singleton mainIs,
      _reExports = Set.empty,
      _allKnownModules = Set.fromList $ mainIs : (BSC8.pack . prettyShow <$> Cabal.otherModules (Cabal.buildInfo exe))
    }

__exportsT :: Cabal.TestSuite -> PackageModules
__exportsT ts = do
  PackageModules
    { _srcDirs = getSymbolicPath <$> (hsSourceDirs . Cabal.testBuildInfo) ts,
      _exports = case Cabal.testInterface ts of
        Cabal.TestSuiteExeV10 _ p -> Set.singleton $ __pathAsModule p
        Cabal.TestSuiteLibV09 _ p -> Set.singleton $ BSC8.pack . prettyShow $ p
        _ -> Set.empty,
      _reExports = Set.empty,
      _allKnownModules = Set.fromList (BSC8.pack . prettyShow <$> Cabal.otherModules (Cabal.testBuildInfo ts))
    }

__exportsB :: Cabal.Benchmark -> PackageModules
__exportsB ts = do
  PackageModules
    { _srcDirs = getSymbolicPath <$> (hsSourceDirs . Cabal.benchmarkBuildInfo) ts,
      _exports = case Cabal.benchmarkInterface ts of
        Cabal.BenchmarkExeV10 _ p -> Set.singleton $ __pathAsModule p
        _ -> Set.empty,
      _reExports = Set.empty,
      _allKnownModules = Set.fromList (BSC8.pack . prettyShow <$> Cabal.otherModules (Cabal.benchmarkBuildInfo ts))
    }

libraryNameToDesignationName :: LibraryName -> Maybe String
libraryNameToDesignationName LMainLibName = Nothing
libraryNameToDesignationName (LSubLibName n) = Just $ unUnqualComponentName n

__depsU :: BuildInfo -> [Dependency]
__depsU i = execWriter $
  forM_ (targetBuildDepends i) $ \(Cabal.Dependency p vP ns) ->
    forM_ ns \n ->
      tell $ pure $ Dependency {_dName = Cabal.unPackageName p, _dVersion = vP, _dSubname = libraryNameToDesignationName n}