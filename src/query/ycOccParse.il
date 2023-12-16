;--------------------------------
; Program  : virtuoso-utils(ycOccParse.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------------

procedure(ycOccParse(occ "g")
    if(listp(occ)
    then
        let((fig hier)
            occ = reverse(occ)
            fig = car(occ)
            foreach(x cdr(occ)
                hier = cons(x hier)
            )
            list(hier fig)
        )
    else
        list(nil occ)
    )
)

; END