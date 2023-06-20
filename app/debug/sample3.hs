
-- let yy =
--       PackageDescription
--         { specVersion = CabalSpecV2_2,
--           package = PackageIdentifier {pkgName = PackageName "filepath", pkgVersion = mkVersion [1, 4, 100, 3]},
--           licenseRaw = Left (License (ELicense (ELicenseId BSD_3_Clause) Nothing)),
--           licenseFiles = [SymbolicPath "LICENSE"],
--           copyright = "Neil Mitchell 2005-2020, Julain Ospald 2021-2022",
--           maintainer = "Julian Ospald <hasufell@posteo.de>",
--           author = "Neil Mitchell <ndmitchell@gmail.com>",
--           stability = "",
--           testedWith = [(GHC, UnionVersionRanges (ThisVersion (mkVersion [8, 0, 2])) (UnionVersionRanges (ThisVersion (mkVersion [8, 2, 2])) (UnionVersionRanges (ThisVersion (mkVersion [8, 4, 4])) (UnionVersionRanges (ThisVersion (mkVersion [8, 6, 5])) (UnionVersionRanges (ThisVersion (mkVersion [8, 8, 4])) (UnionVersionRanges (ThisVersion (mkVersion [8, 10, 7])) (UnionVersionRanges (ThisVersion (mkVersion [9, 0, 2])) (ThisVersion (mkVersion [9, 2, 3])))))))))],
--           homepage = "https://github.com/haskell/filepath/blob/master/README.md",
--           pkgUrl = "",
--           bugReports = "https://github.com/haskell/filepath/issues",
--           sourceRepos = [SourceRepo {repoKind = RepoHead, repoType = Just (KnownRepoType Git), repoLocation = Just "https://github.com/haskell/filepath", repoModule = Nothing, repoBranch = Nothing, repoTag = Nothing, repoSubdir = Nothing}],
--           synopsis = "Library for manipulating FilePaths in a cross platform way.",
--           description = "This package provides functionality for manipulating @FilePath@ values, and is shipped with <https://www.haskell.org/ghc/ GHC>. It provides two variants for filepaths:\n\n1. legacy filepaths: @type FilePath = String@\n\n2. operating system abstracted filepaths (@OsPath@): internally unpinned @ShortByteString@ (platform-dependent encoding)\n\nIt is recommended to use @OsPath@ when possible, because it is more correct.\n\nFor each variant there are three main modules:\n\n* \"System.FilePath.Posix\" / \"System.OsPath.Posix\" manipulates POSIX\\/Linux style @FilePath@ values (with @\\/@ as the path separator).\n\n* \"System.FilePath.Windows\" / \"System.OsPath.Windows\" manipulates Windows style @FilePath@ values (with either @\\\\@ or @\\/@ as the path separator, and deals with drives).\n\n* \"System.FilePath\" / \"System.OsPath\" for dealing with current platform-specific filepaths\n\n\"System.OsString\" is like \"System.OsPath\", but more general purpose. Refer to the documentation of\nthose modules for more information.\n\nAn introduction into the new API can be found in this\n<https://hasufell.github.io/posts/2022-06-29-fixing-haskell-filepaths.html blog post>.\nCode examples for the new API can be found <https://github.com/hasufell/filepath-examples here>.",
--           category = "System",
--           customFieldsPD = [],
--           buildTypeRaw = Just Simple,
--           setupBuildInfo = Nothing,
--           library =
--             Just
--               ( Library
--                   { libName = LMainLibName,
--                     exposedModules = [
--                       ModuleName "System.FilePath",
--                       ModuleName "System.FilePath.Posix",
--                       ModuleName "System.FilePath.Windows", ModuleName "System.OsPath", ModuleName "System.OsPath.Data.ByteString.Short", ModuleName "System.OsPath.Data.ByteString.Short.Internal", ModuleName "System.OsPath.Data.ByteString.Short.Word16", ModuleName "System.OsPath.Encoding", ModuleName "System.OsPath.Encoding.Internal", ModuleName "System.OsPath.Internal", ModuleName "System.OsPath.Posix", ModuleName "System.OsPath.Posix.Internal", ModuleName "System.OsPath.Types", ModuleName "System.OsPath.Windows", ModuleName "System.OsPath.Windows.Internal", ModuleName "System.OsString", ModuleName "System.OsString.Internal", ModuleName "System.OsString.Internal.Types", ModuleName "System.OsString.Posix", ModuleName "System.OsString.Windows"
--                       ],
--                     reexportedModules = [],
--                     signatures = [],
--                     libExposed = True,
--                     libVisibility = LibraryVisibilityPublic,
--                     libBuildInfo =
--                       BuildInfo
--                         { buildable = True,
--                           buildTools = [],
--                           buildToolDepends = [ExeDependency (PackageName "cpphs") (UnqualComponentName "cpphs") (OrLaterVersion (mkVersion [0]))],
--                           cppOptions = [],
--                           asmOptions = [],
--                           cmmOptions = [],
--                           ccOptions = [],
--                           cxxOptions = [],
--                           ldOptions = [],
--                           hsc2hsOptions = [],
--                           pkgconfigDepends = [],
--                           frameworks = [],
--                           extraFrameworkDirs = [],
--                           asmSources = [],
--                           cmmSources = [],
--                           cSources = [],
--                           cxxSources = [],
--                           jsSources = [],
--                           hsSourceDirs = [SymbolicPath "."],
--                           otherModules = [],
--                           virtualModules = [],
--                           autogenModules = [],
--                           defaultLanguage = Just Haskell2010,
--                           otherLanguages = [],
--                           defaultExtensions = [],
--                           otherExtensions = [EnableExtension CPP, EnableExtension PatternGuards, EnableExtension Safe],
--                           oldExtensions = [],
--                           extraLibs = [],
--                           extraLibsStatic = [],
--                           extraGHCiLibs = [],
--                           extraBundledLibs = [],
--                           extraLibFlavours = [],
--                           extraDynLibFlavours = [],
--                           extraLibDirs = [],
--                           extraLibDirsStatic = [],
--                           includeDirs = [],
--                           includes = [],
--                           autogenIncludes = [],
--                           installIncludes = [],
--                           options = PerCompilerFlavor ["-Wall", "-pgmPcpphs", "-optP--cpp"] [],
--                           profOptions = PerCompilerFlavor [] [],
--                           sharedOptions = PerCompilerFlavor [] [],
--                           staticOptions = PerCompilerFlavor [] [],
--                           customFieldsBI = [],
--                           targetBuildDepends = [Dependency (PackageName "base") (IntersectVersionRanges (OrLaterVersion (mkVersion [4, 9])) (EarlierVersion (mkVersion [4, 19]))) (fromNonEmpty (LMainLibName :| [])), Dependency (PackageName "bytestring") (OrLaterVersion (mkVersion [0, 11, 3, 0])) (fromNonEmpty (LMainLibName :| [])), Dependency (PackageName "deepseq") (OrLaterVersion (mkVersion [0])) (fromNonEmpty (LMainLibName :| [])), Dependency (PackageName "exceptions") (OrLaterVersion (mkVersion [0])) (fromNonEmpty (LMainLibName :| [])), Dependency (PackageName "template-haskell") (OrLaterVersion (mkVersion [0])) (fromNonEmpty (LMainLibName :| []))],
--                           mixins = []
--                         }
--                   }
--               ),
--           subLibraries = [],
--           executables = [],
--           foreignLibs = [],
--           testSuites = [TestSuite {testName = UnqualComponentName "abstract-filepath", testInterface = TestSuiteExeV10 (mkVersion [1, 0]) "Test.hs", testBuildInfo = BuildInfo {buildable = True, buildTools = [], buildToolDepends = [], cppOptions = [], asmOptions = [], cmmOptions = [], ccOptions = [], cxxOptions = [], ldOptions = [], hsc2hsOptions = [], pkgconfigDepends = [], frameworks = [], extraFrameworkDirs = [], asmSources = [], cmmSources = [], cSources = [], cxxSources = [], jsSources = [], hsSourceDirs = [SymbolicPath "tests", SymbolicPath "tests/abstract-filepath"], otherModules = [ModuleName "Arbitrary", ModuleName "EncodingSpec", ModuleName "OsPathSpec", ModuleName "TestUtil"], virtualModules = [], autogenModules = [], defaultLanguage = Just Haskell2010, otherLanguages = [], defaultExtensions = [], otherExtensions = [], oldExtensions = [], extraLibs = [], extraLibsStatic = [], extraGHCiLibs = [], extraBundledLibs = [], extraLibFlavours = [], extraDynLibFlavours = [], extraLibDirs = [], extraLibDirsStatic = [], includeDirs = [], includes = [], autogenIncludes = [], installIncludes = [], options = PerCompilerFlavor ["-Wall"] [], profOptions = PerCompilerFlavor [] [], sharedOptions = PerCompilerFlavor [] [], staticOptions = PerCompilerFlavor [] [], customFieldsBI = [], targetBuildDepends = [Dependency (PackageName "base") (OrLaterVersion (mkVersion [0])) (fromNonEmpty (LMainLibName :| [])), Dependency (PackageName "bytestring") (OrLaterVersion (mkVersion [0, 11, 3, 0])) (fromNonEmpty (LMainLibName :| [])), Dependency (PackageName "checkers") (MajorBoundVersion (mkVersion [0, 5, 6])) (fromNonEmpty (LMainLibName :| [])), Dependency (PackageName "deepseq") (OrLaterVersion (mkVersion [0])) (fromNonEmpty (LMainLibName :| [])), Dependency (PackageName "filepath") (OrLaterVersion (mkVersion [0])) (fromNonEmpty (LMainLibName :| [])), Dependency (PackageName "QuickCheck") (IntersectVersionRanges (OrLaterVersion (mkVersion [2, 7])) (EarlierVersion (mkVersion [2, 15]))) (fromNonEmpty (LMainLibName :| []))], mixins = []}, testCodeGenerators = []}, TestSuite {testName = UnqualComponentName "bytestring-tests", testInterface = TestSuiteExeV10 (mkVersion [1, 0]) "Main.hs", testBuildInfo = BuildInfo {buildable = True, buildTools = [], buildToolDepends = [], cppOptions = [], asmOptions = [], cmmOptions = [], ccOptions = [], cxxOptions = [], ldOptions = [], hsc2hsOptions = [], pkgconfigDepends = [], frameworks = [], extraFrameworkDirs = [], asmSources = [], cmmSources = [], cSources = [], cxxSources = [], jsSources = [], hsSourceDirs = [SymbolicPath "tests", SymbolicPath "tests/bytestring-tests"], otherModules = [ModuleName "Properties.ShortByteString", ModuleName "Properties.ShortByteString.Word16", ModuleName "TestUtil"], virtualModules = [], autogenModules = [], defaultLanguage = Just Haskell2010, otherLanguages = [], defaultExtensions = [], otherExtensions = [], oldExtensions = [], extraLibs = [], extraLibsStatic = [], extraGHCiLibs = [], extraBundledLibs = [], extraLibFlavours = [], extraDynLibFlavours = [], extraLibDirs = [], extraLibDirsStatic = [], includeDirs = [], includes = [], autogenIncludes = [], installIncludes = [], options = PerCompilerFlavor ["-Wall"] [], profOptions = PerCompilerFlavor [] [], sharedOptions = PerCompilerFlavor [] [], staticOptions = PerCompilerFlavor [] [], customFieldsBI = [], targetBuildDepends = [Dependency (PackageName "base") (OrLaterVersion (mkVersion [0])) (fromNonEmpty (LMainLibName :| [])), Dependency (PackageName "bytestring") (OrLaterVersion (mkVersion [0, 11, 3, 0])) (fromNonEmpty (LMainLibName :| [])), Dependency (PackageName "filepath") (OrLaterVersion (mkVersion [0])) (fromNonEmpty (LMainLibName :| [])), Dependency (PackageName "QuickCheck") (IntersectVersionRanges (OrLaterVersion (mkVersion [2, 7])) (EarlierVersion (mkVersion [2, 15]))) (fromNonEmpty (LMainLibName :| []))], mixins = []}, testCodeGenerators = []}, TestSuite {testName = UnqualComponentName "filepath-equivalent-tests", testInterface = TestSuiteExeV10 (mkVersion [1, 0]) "TestEquiv.hs", testBuildInfo = BuildInfo {buildable = True, buildTools = [], buildToolDepends = [], cppOptions = [], asmOptions = [], cmmOptions = [], ccOptions = [], cxxOptions = [], ldOptions = [], hsc2hsOptions = [], pkgconfigDepends = [], frameworks = [], extraFrameworkDirs = [], asmSources = [], cmmSources = [], cSources = [], cxxSources = [], jsSources = [], hsSourceDirs = [SymbolicPath "tests", SymbolicPath "tests/filepath-equivalent-tests"], otherModules = [ModuleName "Legacy.System.FilePath", ModuleName "Legacy.System.FilePath.Posix", ModuleName "Legacy.System.FilePath.Windows", ModuleName "TestUtil"], virtualModules = [], autogenModules = [], defaultLanguage = Just Haskell2010, otherLanguages = [], defaultExtensions = [], otherExtensions = [], oldExtensions = [], extraLibs = [], extraLibsStatic = [], extraGHCiLibs = [], extraBundledLibs = [], extraLibFlavours = [], extraDynLibFlavours = [], extraLibDirs = [], extraLibDirsStatic = [], includeDirs = [], includes = [], autogenIncludes = [], installIncludes = [], options = PerCompilerFlavor ["-Wall"] [], profOptions = PerCompilerFlavor [] [], sharedOptions = PerCompilerFlavor [] [], staticOptions = PerCompilerFlavor [] [], customFieldsBI = [], targetBuildDepends = [Dependency (PackageName "base") (OrLaterVersion (mkVersion [0])) (fromNonEmpty (LMainLibName :| [])), Dependency (PackageName "bytestring") (OrLaterVersion (mkVersion [0, 11, 3, 0])) (fromNonEmpty (LMainLibName :| [])), Dependency (PackageName "filepath") (OrLaterVersion (mkVersion [0])) (fromNonEmpty (LMainLibName :| [])), Dependency (PackageName "QuickCheck") (IntersectVersionRanges (OrLaterVersion (mkVersion [2, 7])) (EarlierVersion (mkVersion [2, 15]))) (fromNonEmpty (LMainLibName :| []))], mixins = []}, testCodeGenerators = []}, TestSuite {testName = UnqualComponentName "filepath-tests", testInterface = TestSuiteExeV10 (mkVersion [1, 0]) "Test.hs", testBuildInfo = BuildInfo {buildable = True, buildTools = [], buildToolDepends = [], cppOptions = [], asmOptions = [], cmmOptions = [], ccOptions = [], cxxOptions = [], ldOptions = [], hsc2hsOptions = [], pkgconfigDepends = [], frameworks = [], extraFrameworkDirs = [], asmSources = [], cmmSources = [], cSources = [], cxxSources = [], jsSources = [], hsSourceDirs = [SymbolicPath "tests", SymbolicPath "tests/filepath-tests"], otherModules = [ModuleName "TestGen", ModuleName "TestUtil"], virtualModules = [], autogenModules = [], defaultLanguage = Just Haskell2010, otherLanguages = [], defaultExtensions = [], otherExtensions = [], oldExtensions = [], extraLibs = [], extraLibsStatic = [], extraGHCiLibs = [], extraBundledLibs = [], extraLibFlavours = [], extraDynLibFlavours = [], extraLibDirs = [], extraLibDirsStatic = [], includeDirs = [], includes = [], autogenIncludes = [], installIncludes = [], options = PerCompilerFlavor ["-Wall"] [], profOptions = PerCompilerFlavor [] [], sharedOptions = PerCompilerFlavor [] [], staticOptions = PerCompilerFlavor [] [], customFieldsBI = [], targetBuildDepends = [Dependency (PackageName "base") (OrLaterVersion (mkVersion [0])) (fromNonEmpty (LMainLibName :| [])), Dependency (PackageName "bytestring") (OrLaterVersion (mkVersion [0, 11, 3, 0])) (fromNonEmpty (LMainLibName :| [])), Dependency (PackageName "filepath") (OrLaterVersion (mkVersion [0])) (fromNonEmpty (LMainLibName :| [])), Dependency (PackageName "QuickCheck") (IntersectVersionRanges (OrLaterVersion (mkVersion [2, 7])) (EarlierVersion (mkVersion [2, 15]))) (fromNonEmpty (LMainLibName :| []))], mixins = []}, testCodeGenerators = []}],
--           benchmarks = [Benchmark {benchmarkName = UnqualComponentName "bench-filepath", benchmarkInterface = BenchmarkExeV10 (mkVersion [1, 0]) "BenchFilePath.hs", benchmarkBuildInfo = BuildInfo {buildable = True, buildTools = [], buildToolDepends = [], cppOptions = [], asmOptions = [], cmmOptions = [], ccOptions = [], cxxOptions = [], ldOptions = [], hsc2hsOptions = [], pkgconfigDepends = [], frameworks = [], extraFrameworkDirs = [], asmSources = [], cmmSources = [], cSources = [], cxxSources = [], jsSources = [], hsSourceDirs = [SymbolicPath "bench"], otherModules = [ModuleName "TastyBench"], virtualModules = [], autogenModules = [], defaultLanguage = Just Haskell2010, otherLanguages = [], defaultExtensions = [], otherExtensions = [], oldExtensions = [], extraLibs = [], extraLibsStatic = [], extraGHCiLibs = [], extraBundledLibs = [], extraLibFlavours = [], extraDynLibFlavours = [], extraLibDirs = [], extraLibDirsStatic = [], includeDirs = [], includes = [], autogenIncludes = [], installIncludes = [], options = PerCompilerFlavor ["-Wall", "-with-rtsopts=-A32m --nonmoving-gc", "-with-rtsopts=-A32m"] [], profOptions = PerCompilerFlavor [] [], sharedOptions = PerCompilerFlavor [] [], staticOptions = PerCompilerFlavor [] [], customFieldsBI = [], targetBuildDepends = [Dependency (PackageName "base") (OrLaterVersion (mkVersion [0])) (fromNonEmpty (LMainLibName :| [])), Dependency (PackageName "bytestring") (OrLaterVersion (mkVersion [0, 11, 3, 0])) (fromNonEmpty (LMainLibName :| [])), Dependency (PackageName "deepseq") (OrLaterVersion (mkVersion [0])) (fromNonEmpty (LMainLibName :| [])), Dependency (PackageName "filepath") (OrLaterVersion (mkVersion [0])) (fromNonEmpty (LMainLibName :| []))], mixins = []}}],
--           dataFiles = [],
--           dataDir = ".",
--           extraSrcFiles = ["Generate.hs", "Makefile", "System/FilePath/Internal.hs", "System/OsPath/Common.hs", "System/OsString/Common.hs", "tests/bytestring-tests/Properties/Common.hs"],
--           extraTmpFiles = [],
--           extraDocFiles = ["changelog.md", "HACKING.md", "README.md"]
--         }