{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE TemplateHaskell #-}

module GTD.Resolution.State where

import Control.Lens (makeLenses)
import qualified Data.Cache.LRU as LRU
import qualified Data.Map.Strict as Map
import GHC.Generics (Generic)
import GTD.Cabal.Get as Cabal (GetCache (..))
import GTD.Cabal.Types (ModuleNameS, PackageNameS)
import qualified GTD.Cabal.Types as Cabal
import GTD.Haskell.Declaration (Declarations)
import GTD.Haskell.Module (HsModuleP)

data Package = Package
  { _cabalPackage :: Cabal.PackageWithResolvedDependencies,
    _modules :: Map.Map ModuleNameS HsModuleP,
    _exports :: Map.Map ModuleNameS HsModuleP
  }
  deriving (Show, Generic)

$(makeLenses ''Package)

---

data Context = Context
  { _ccFindAt :: Map.Map FilePath [Cabal.PackageWithUnresolvedDependencies],
    _ccFull :: Map.Map Cabal.PackageKey Cabal.PackageWithResolvedDependencies,
    _ccGet :: Cabal.GetCache,
    _cExports :: LRU.LRU Cabal.PackageKey (Map.Map ModuleNameS HsModuleP),
    _cResolution :: LRU.LRU FilePath (Maybe (Map.Map ModuleNameS Declarations)),
    _cLocalPackages :: Map.Map (PackageNameS, Maybe String) (Map.Map Cabal.Version Cabal.PackageWithUnresolvedDependencies)
  }
  deriving (Show, Generic)

$(makeLenses ''Context)

emptyContext :: Context
emptyContext = Context mempty mempty (Cabal.GetCache mempty False) (LRU.newLRU Nothing) (LRU.newLRU $ Just 4) mempty
