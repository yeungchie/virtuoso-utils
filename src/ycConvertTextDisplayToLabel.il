;--------------------------
; Program  : virtuoso-utils(ycConvertTextDisplayToLabel.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

procedure(ycConvertTextDisplayToLabel(fig "d")
    prog((cvId label figGroup)
        cvId = fig~>cellView
        when(cvId~>mode == "r"
            ycWarn("cannot to edit read-only design.")
            return()
        )
        unless(fig~>objType == "textDisplay"
            ycWarn("argument #1 should be a textDisplay dbobject - %A" fig~>objType)
            return()
        )
        label = dbCreateLabel(
            cvId
            fig~>lpp
            fig~>xy
            fig~>owner~>name
            fig~>justify
            fig~>orient
            fig~>font
            fig~>height
        )
        unless(label
            ycWarn("failed to create a new label(%A)" fig~>owner~>name)
            return()
        )
        when(figGroup = fig~>figGroup
            unless(dbAddFigToFigGroup(figGroup label)
                ycWarn("failed to add label(%A) to figGroup(%A)" label~>theLabel figGroup~>name)
            )
        )
        dbDeleteObject(fig)
        return(label)
    )
)

; END