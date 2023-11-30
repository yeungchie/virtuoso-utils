;--------------------------------
; Program  : virtuoso-utils(ycIsOcc.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------------

procedure(ycIsOcc(occ "g")
    when(occ
        if(listp(occ)
        then
            occ = reverse(occ)
            if(dbIsId(car(occ))
            then
                t
            else
                forall(x cdr(occ)
                    if(listp(x)
                    then
                        and(
                            dbIsId(car(x))
                            member(x~>objType list("inst" "mosaic"))
                            forall(y cdr(x) fixp(y))
                        )
                    else
                        dbIsId(x) && member(x~>objType list("inst" "mosaic"))
                    )
                )
            )
        else
            dbIsId(occ)
        )
    )
)

; END