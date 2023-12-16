;--------------------------------
; Program  : virtuoso-utils(ycShapeQuery.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------------

procedure(ycShapeQuery(cvId \@optional lpp bBox grep startLevel(0) stopLevel(dbGetMaxHierDepth()-1) "dllgxx")
    prog((layerName layerNamep purpose purposep techlpps lpps shapeHierPaths)
        unless(cvId~>objType == "cellView"
            ycError("Invalid cellView - %A" cvId~>objType)
        )
        bBox = bBox || cvId~>bBox
        unless(isBBox(bBox)
            ycError("Invalid bBox - %A" bBox)
        )

        when(lpp && forall(x lpp pairp(x))
            foreach(x lpp
                let((hierPaths)
                    when(hierPaths = ycShapeQuery(cvId x bBox grep startLevel stopLevel)
                        shapeHierPaths = append(hierPaths shapeHierPaths)
                    )
                )
            )
            return(shapeHierPaths)
        )

        ; layerName
        layerName = car(lpp)
        cond(
            (!layerName
                layerNamep = nil
            )
            (stringp(layerName) && !blankstrp(layerName)
                layerNamep = t
            )
            (t
                ycError("Invalid lpp format - %A" lpp)
            )
        )
        
        ; purpose
        purpose = cadr(lpp)
        cond(
            (!purpose
                purposep = nil
            )
            (stringp(purpose) && !blankstrp(purpose)
                purposep = t
            )
            (t
                ycError("Invalid lpp format - %A" lpp)
            )
        )

        foreach(lp techGetTechFile(cvId)~>lps
            when(lp~>valid
                techlpps = cons(list(lp~>name lp~>purpose) techlpps)    ; 有效层
            )
        )

        ; 一层 lpp 都不指定代表全都要
        unless(layerNamep || purposep
            foreach(lp cvId~>lpps
                let((lpp)
                    lpp = list(lp~>layerName lp~>purpose)
                    when(member(lpp techlpps)
                        ; 只查找当前 cv 中的有效层
                        lpps = cons(lpp lpps)
                    )
                ); let
            )
            go(Query)
        )

        ; 同时指定了 layerName 和 purpose 且不使用正则匹配
        when(layerNamep && purposep && !grep
            let((lpp)
                lpp = list(layerName purpose)
                unless(member(lpp techlpps)
                    ycWarn("Invalid layer/purpose - %A" lpp)
                    return()
                )
                lpps = list(lpp)
            ); let
            go(Query)
        )

        ; 指定不明确的 lpp
        foreach(lp cvId~>lpps
            let((lpp)
                lpp = list(lp~>layerName lp~>purpose)
                when(member(lpp techlpps)
                    && if(layerNamep apply(if(grep 'pcreMatchp 'equal) list(layerName  car(lpp))) t)
                    && if(purposep   apply(if(grep 'pcreMatchp 'equal) list(purpose   cadr(lpp))) t)
                    lpps = cons(lpp lpps)
                )
            ); let
        )

        Query
        foreach(lpp lpps
            let((hierPaths)
                when(hierPaths = dbShapeQuery(cvId lpp bBox startLevel stopLevel)
                    shapeHierPaths = append(shapeHierPaths hierPaths)
                )
            )
        )

        return(shapeHierPaths)
    )
); ycShapeQuery
