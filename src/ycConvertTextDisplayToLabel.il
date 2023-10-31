;--------------------------
; Program  : virtuoso-utils(ycConvertTextDisplayToLabel.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

procedure(ycConvertTextDisplayToLabel(fig "d")
    prog((cvId label figGroup)
        cvId = fig~>cellView
        when(cvId~>mode == "r"
            warn("failed to edit a read-only design.")
            return()
        )
        unless(fig~>objType == "textDisplay"
            warn("argument #1 should be textDisplay dbobject - %A" fig~>objType)
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
            warn("failed to create a new label.")
            return()
        )
        when(figGroup = fig~>figGroup
            unless(dbAddFigToFigGroup(figGroup label)
                warn("failed to add label to figGroup - %A" figGroup)
            )
        )
        dbDeleteObject(fig)
        return(label)
    )
)

; END