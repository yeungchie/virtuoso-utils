;--------------------------------
; Program  : virtuoso-utils(ycIsOcc.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------------

procedure(ycIsOcc(occ "g")
    prog((coord)
        unless(occ
            return() ; nil
        )
        if(listp(occ)
        then
            occ = reverse(occ)
            unless(dbIsId(car(occ))
                return() ; ( ... <non-dbobject> )
            )
            unless(cdr(occ)
                return() ; ( <dbobject> )
            )
            foreach(inst cdr(occ)
                unless(inst
                    return() ; ( ... nil ... <dbobject> )
                )
                if(listp(inst)
                then
                    coord = cdr(inst)
                    inst = car(inst)
                    unless(dbIsId(inst) && inst~>objType == "mosaic"
                        return() ; ( ... ( <non-dbobject or non-mosaic> ... ) ... <dbobject> )
                    )
                    unless(fixp(xCoord(coord)) && fixp(yCoord(coord))
                        return() ; ( ... ( <mosaic> <non-fixnum> or <non-fixnum> ) ... <dbobject> )
                    )
                else
                    unless(dbIsId(inst) && inst~>objType == "inst"
                        return() ; ( ... <non-dbobject or non-inst> ... <dbobject> )
                    )
                )
            )
        else
            return(dbIsId(occ)) ; <dbobject>
        )
        return(t)
    )
)

; END