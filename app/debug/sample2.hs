
  fileContents <- readFile "./app/Main.hs"
  let ast = parseModule fileContents

    let z =
          ParseOk
            ( Module
                ( SrcSpanInfo
                    { srcInfoSpan = SrcSpan "<unknown>.hs" 1 1 10 1,
                      srcInfoPoints = [SrcSpan "<unknown>.hs" 1 1 1 1, SrcSpan "<unknown>.hs" 1 1 1 1, SrcSpan "<unknown>.hs" 3 1 3 1, SrcSpan "<unknown>.hs" 5 1 5 1, SrcSpan "<unknown>.hs" 6 1 6 1, SrcSpan "<unknown>.hs" 10 1 10 1, SrcSpan "<unknown>.hs" 10 1 10 1]
                    }
                )
                ( Just
                    ( ModuleHead
                        ( SrcSpanInfo {srcInfoSpan = SrcSpan "<unknown>.hs" 1 1 1 25, srcInfoPoints = [SrcSpan "<unknown>.hs" 1 1 1 7, SrcSpan "<unknown>.hs" 1 20 1 25]}
                        )
                        (ModuleName (SrcSpanInfo {srcInfoSpan = SrcSpan "<unknown>.hs" 1 8 1 12, srcInfoPoints = []}) "Main")
                        Nothing
                        ( Just
                            ( ExportSpecList
                                (SrcSpanInfo {srcInfoSpan = SrcSpan "<unknown>.hs" 1 13 1 19, srcInfoPoints = [SrcSpan "<unknown>.hs" 1 13 1 14, SrcSpan "<unknown>.hs" 1 18 1 19]})
                                [EVar (SrcSpanInfo {srcInfoSpan = SrcSpan "<unknown>.hs" 1 14 1 18, srcInfoPoints = []}) (UnQual (SrcSpanInfo {srcInfoSpan = SrcSpan "<unknown>.hs" 1 14 1 18, srcInfoPoints = []}) (Ident (SrcSpanInfo {srcInfoSpan = SrcSpan "<unknown>.hs" 1 14 1 18, srcInfoPoints = []}) "main"))]
                            )
                        )
                    )
                )
                []
                [ImportDecl {
                  importAnn = SrcSpanInfo {srcInfoSpan = SrcSpan "<unknown>.hs" 3 1 3 43, srcInfoPoints = [SrcSpan "<unknown>.hs" 3 1 3 7]},
                  importModule = ModuleName (SrcSpanInfo {srcInfoSpan = SrcSpan "<unknown>.hs" 3 8 3 29, srcInfoPoints = []}) "Language.Haskell.Exts", importQualified = False, importSrc = False, importSafe = False, importPkg = Nothing, importAs = Nothing, importSpecs = Just (ImportSpecList (SrcSpanInfo {srcInfoSpan = SrcSpan "<unknown>.hs" 3 30 3 43, srcInfoPoints = [SrcSpan "<unknown>.hs" 3 30 3 31, SrcSpan "<unknown>.hs" 3 42 3 43]}) False [IVar (SrcSpanInfo {srcInfoSpan = SrcSpan "<unknown>.hs" 3 31 3 42, srcInfoPoints = []}) (Ident (SrcSpanInfo {srcInfoSpan = SrcSpan "<unknown>.hs" 3 31 3 42, srcInfoPoints = []}) "parseModule")])}]
                [TypeSig (SrcSpanInfo {srcInfoSpan = SrcSpan "<unknown>.hs" 5 1 5 14, srcInfoPoints = [SrcSpan "<unknown>.hs" 5 6 5 8]}) [Ident (SrcSpanInfo {srcInfoSpan = SrcSpan "<unknown>.hs" 5 1 5 5, srcInfoPoints = []}) "main"] (TyApp (SrcSpanInfo {srcInfoSpan = SrcSpan "<unknown>.hs" 5 9 5 14, srcInfoPoints = []}) (TyCon (SrcSpanInfo {srcInfoSpan = SrcSpan "<unknown>.hs" 5 9 5 11, srcInfoPoints = []}) (UnQual (SrcSpanInfo {srcInfoSpan = SrcSpan "<unknown>.hs" 5 9 5 11, srcInfoPoints = []}) (Ident (SrcSpanInfo {srcInfoSpan = SrcSpan "<unknown>.hs" 5 9 5 11, srcInfoPoints = []}) "IO"))) (TyCon (SrcSpanInfo {srcInfoSpan = SrcSpan "<unknown>.hs" 5 12 5 14, srcInfoPoints = [SrcSpan "<unknown>.hs" 5 12 5 13, SrcSpan "<unknown>.hs" 5 13 5 14]}) (Special (SrcSpanInfo {srcInfoSpan = SrcSpan "<unknown>.hs" 5 12 5 14, srcInfoPoints = [SrcSpan "<unknown>.hs" 5 12 5 13, SrcSpan "<unknown>.hs" 5 13 5 14]}) (UnitCon (SrcSpanInfo {srcInfoSpan = SrcSpan "<unknown>.hs" 5 12 5 14, srcInfoPoints = [SrcSpan "<unknown>.hs" 5 12 5 13, SrcSpan "<unknown>.hs" 5 13 5 14]}))))), PatBind (SrcSpanInfo {srcInfoSpan = SrcSpan "<unknown>.hs" 6 1 9 12, srcInfoPoints = []}) (PVar (SrcSpanInfo {srcInfoSpan = SrcSpan "<unknown>.hs" 6 1 6 5, srcInfoPoints = []}) (Ident (SrcSpanInfo {srcInfoSpan = SrcSpan "<unknown>.hs" 6 1 6 5, srcInfoPoints = []}) "main")) (UnGuardedRhs (SrcSpanInfo {srcInfoSpan = SrcSpan "<unknown>.hs" 6 6 9 12, srcInfoPoints = [SrcSpan "<unknown>.hs" 6 6 6 7]}) (Do (SrcSpanInfo {srcInfoSpan = SrcSpan "<unknown>.hs" 6 8 9 12, srcInfoPoints = [SrcSpan "<unknown>.hs" 6 8 6 10, SrcSpan "<unknown>.hs" 7 3 7 3, SrcSpan "<unknown>.hs" 8 3 8 3, SrcSpan "<unknown>.hs" 9 3 9 3, SrcSpan "<unknown>.hs" 10 1 10 0]}) [Generator (SrcSpanInfo {srcInfoSpan = SrcSpan "<unknown>.hs" 7 3 7 43, srcInfoPoints = [SrcSpan "<unknown>.hs" 7 16 7 18]}) (PVar (SrcSpanInfo {srcInfoSpan = SrcSpan "<unknown>.hs" 7 3 7 15, srcInfoPoints = []}) (Ident (SrcSpanInfo {srcInfoSpan = SrcSpan "<unknown>.hs" 7 3 7 15, srcInfoPoints = []}) "fileContents")) (App (SrcSpanInfo {srcInfoSpan = SrcSpan "<unknown>.hs" 7 19 7 43, srcInfoPoints = []}) (Var (SrcSpanInfo {srcInfoSpan = SrcSpan "<unknown>.hs" 7 19 7 27, srcInfoPoints = []}) (UnQual (SrcSpanInfo {srcInfoSpan = SrcSpan "<unknown>.hs" 7 19 7 27, srcInfoPoints = []}) (Ident (SrcSpanInfo {srcInfoSpan = SrcSpan "<unknown>.hs" 7 19 7 27, srcInfoPoints = []}) "readFile"))) (Lit (SrcSpanInfo {srcInfoSpan = SrcSpan "<unknown>.hs" 7 28 7 43, srcInfoPoints = []}) (String (SrcSpanInfo {srcInfoSpan = SrcSpan "<unknown>.hs" 7 28 7 43, srcInfoPoints = []}) "./app/Main.hs" "./app/Main.hs"))), LetStmt (SrcSpanInfo {srcInfoSpan = SrcSpan "<unknown>.hs" 8 3 8 37, srcInfoPoints = [SrcSpan "<unknown>.hs" 8 3 8 6]}) (BDecls (SrcSpanInfo {srcInfoSpan = SrcSpan "<unknown>.hs" 8 7 8 37, srcInfoPoints = [SrcSpan "<unknown>.hs" 8 7 8 7, SrcSpan "<unknown>.hs" 9 3 9 0]}) [PatBind (SrcSpanInfo {srcInfoSpan = SrcSpan "<unknown>.hs" 8 7 8 37, srcInfoPoints = []}) (PVar (SrcSpanInfo {srcInfoSpan = SrcSpan "<unknown>.hs" 8 7 8 10, srcInfoPoints = []}) (Ident (SrcSpanInfo {srcInfoSpan = SrcSpan "<unknown>.hs" 8 7 8 10, srcInfoPoints = []}) "ast")) (UnGuardedRhs (SrcSpanInfo {srcInfoSpan = SrcSpan "<unknown>.hs" 8 11 8 37, srcInfoPoints = [SrcSpan "<unknown>.hs" 8 11 8 12]}) (App (SrcSpanInfo {srcInfoSpan = SrcSpan "<unknown>.hs" 8 13 8 37, srcInfoPoints = []}) (Var (SrcSpanInfo {srcInfoSpan = SrcSpan "<unknown>.hs" 8 13 8 24, srcInfoPoints = []}) (UnQual (SrcSpanInfo {srcInfoSpan = SrcSpan "<unknown>.hs" 8 13 8 24, srcInfoPoints = []}) (Ident (SrcSpanInfo {srcInfoSpan = SrcSpan "<unknown>.hs" 8 13 8 24, srcInfoPoints = []}) "parseModule"))) (Var (SrcSpanInfo {srcInfoSpan = SrcSpan "<unknown>.hs" 8 25 8 37, srcInfoPoints = []}) (UnQual (SrcSpanInfo {srcInfoSpan = SrcSpan "<unknown>.hs" 8 25 8 37, srcInfoPoints = []}) (Ident (SrcSpanInfo {srcInfoSpan = SrcSpan "<unknown>.hs" 8 25 8 37, srcInfoPoints = []}) "fileContents"))))) Nothing]), Qualifier (SrcSpanInfo {srcInfoSpan = SrcSpan "<unknown>.hs" 9 3 9 12, srcInfoPoints = []}) (App (SrcSpanInfo {srcInfoSpan = SrcSpan "<unknown>.hs" 9 3 9 12, srcInfoPoints = []}) (Var (SrcSpanInfo {srcInfoSpan = SrcSpan "<unknown>.hs" 9 3 9 8, srcInfoPoints = []}) (UnQual (SrcSpanInfo {srcInfoSpan = SrcSpan "<unknown>.hs" 9 3 9 8, srcInfoPoints = []}) (Ident (SrcSpanInfo {srcInfoSpan = SrcSpan "<unknown>.hs" 9 3 9 8, srcInfoPoints = []}) "print"))) (Var (SrcSpanInfo {srcInfoSpan = SrcSpan "<unknown>.hs" 9 9 9 12, srcInfoPoints = []}) (UnQual (SrcSpanInfo {srcInfoSpan = SrcSpan "<unknown>.hs" 9 9 9 12, srcInfoPoints = []}) (Ident (SrcSpanInfo {srcInfoSpan = SrcSpan "<unknown>.hs" 9 9 9 12, srcInfoPoints = []}) "ast"))))])) Nothing]
            )

  print ast