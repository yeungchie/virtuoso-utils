;--------------------------------
; Program  : virtuoso-utils(ycCreateSchPin.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------------

procedure(ycCreateSchPin(cvId direction pinName origin \@optional orient("R0") "dStlt")
    prog((lcv master dir pin)
        unless(cvId~>cellViewType == "schematic"
            ycWarn("cell view type should be a schematic - %A" cvId~>cellViewType)
            return()
        )
        case(lowerCase(lsprintf("%s" direction))
            ("in"
                lcv = list("basic" "ipin" "symbol")
                dir  = "input"
            )
            ("out"
                lcv = list("basic" "opin" "symbol")
                dir  = "output"
            )
            ("inout"
                lcv = list("basic" "iopin" "symbolr")
                dir  = "inputOutput"
            )
            (t
                ycError("argument #2 should be either /in|out|inout/i - %A" direction)
            )
        )
        
        unless(master = apply('dbOpenCellViewByType lcv)
            return()
        )

        unless(pin = schCreatePin(cvId master pinName dir nil origin orient)
            return()
        )

        return(pin)
    )
)

; END