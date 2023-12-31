;--------------------------------
; Program  : virtuoso-utils(ycInstQuery.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------------

procedure(ycInstQuery(cvId \@optional lcv bBox grep startLevel(0) stopLevel(dbGetMaxHierDepth()-1) "dllgxx")
    prog((instHierPaths lcvList matchedList)
        unless(cvId~>objType == "cellView"
            ycError("Invalid cellView - %A" cvId~>objType)
        )
        bBox = bBox || cvId~>bBox
        unless(isBBox(bBox)
            ycWarn("Invalid bBox - %A" bBox)
            return()
        )

        when(lcv
            cond(
                (forall(x lcv stringp(x) || !x)
                    lcvList = list(lcv)
                )
                (forall(x lcv pairp(x) && forall(y x stringp(y) || !y))
                    lcvList = lcv
                )
                (t
                    ycError("Invalid lcv - %A" lcv)
                )
            )
        )

        instHierPaths = dbInstQuery(cvId bBox startLevel stopLevel)

        unless(lcv
            return(instHierPaths)
        )

        foreach(items lcvList
            let((lib libp cell cellp view viewp)
                libp  = (lib  = nth(0 items)) && stringp(lib)  && !blankstrp(lib)   ; 判断 lib  是不是有效信息
                cellp = (cell = nth(1 items)) && stringp(cell) && !blankstrp(cell)  ; 判断 cell 是不是有效信息
                viewp = (view = nth(2 items)) && stringp(view) && !blankstrp(view)  ; 判断 view 是不是有效信息
                libp || cellp || viewp || return(instHierPaths)                     ; 都不是有效信息说明全都要，不需要筛选直接返回结果

                foreach(p instHierPaths
                    let((inst)
                        inst = if(listp(p) car(reverse(p)) p)
                        when(if(libp  apply(if(grep 'pcreMatchp 'equal) list(lib  inst~>libName )) t)
                          && if(cellp apply(if(grep 'pcreMatchp 'equal) list(cell inst~>cellName)) t)
                          && if(viewp apply(if(grep 'pcreMatchp 'equal) list(view inst~>viewName)) t)
                            matchedList = cons(p matchedList)
                        )
                    ); let
                )
            ); let
        )

        return(matchedList)
    )
)

; END