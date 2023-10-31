;--------------------------
; Program  : virtuoso-utils(ycCopyTextDisplayToLabel.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

procedure(ycCopyTextDisplayToLabel(fig cvId \@optional transform(list(0:0 "R0")) "ddl")
    prog((xy label)
        unless(cvId~>objType == "cellView"
            warn("argument #2 should be cellView dbobject - %A" cvId~>objType)
            return()
        )
        when(cvId~>mode == "r"
            warn("failed to edit a read-only design.")
            return()
        )
        unless(fig~>objType == "textDisplay"
            warn("argument #1 should be textDisplay dbobject - %A" fig~>objType)
            return()
        )
        xy = dbTransformPoint(fix~>xy transform)
        label = dbCreateLabel(
            cvId
            fig~>lpp
            xy
            fig~>owner~>name
            fig~>justify
            fig~>orient
            fig~>font
            fig~>height
        )
        unless(label
            warn("failed to copy.")
            return()
        )
        return(label)
    )
)

; END