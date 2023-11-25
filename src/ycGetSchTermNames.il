;--------------------------
; Program  : virtuoso-utils(ycGetSchTermNames.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

procedure(ycGetSchTermNames(\@optional cvId(geGetEditCellView()) "d")
    prog((terms uniq names)
        unless(member(cvId~>cellViewType list("schematic" "schematicSymbol"))
            ycWarn("cell view type should be either schematic or schematicSymbol - %A" cvId~>cellViewType)
            return()
        )
        uniq = makeTable("" nil)
        foreach(term cvId~>terminals
            foreach(x dbProduceMemName(term~>net~>name)
                unless(uniq[x]
                    names = cons(x names)
                    uniq[x] = t
                )
            )
        )
        return(reverse(names))
    )
)

; END