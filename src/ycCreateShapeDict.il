;--------------------------
; Program  : virtuoso-utils(ycCreateShapeDict.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

procedure(ycCreateShapeDict(shapes \@key attr('lpp) label "lSg")
    let((dict)
        dict = makeTable("ShapeDict" nil)
        foreach(x shapes
            prog((key)
                case(x~>objType
                    (("label" "textDisplay")
                        label || return()
                    )
                )
                key = get(x attr)
                dict[key] = cons(x dict[key])
            )
        )
        dict
    )
)

; END
