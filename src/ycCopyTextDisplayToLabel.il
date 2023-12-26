;--------------------------
; Program  : virtuoso-utils(ycCopyTextDisplayToLabel.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

procedure(ycCopyTextDisplayToLabel(fig cvId \@optional transform(list(0:0 "R0")) "ddl")
    prog((label)
        unless(cvId~>objType == "cellView"
            ycWarn("argument #2 should be cellView dbobject - %A" cvId~>objType)
            return()
        )
        when(cvId~>mode == "r"
            ycWarn("cannot edit read-only design.")
            return()
        )
        unless(fig~>objType == "textDisplay"
            ycWarn("argument #1 should be a textDisplay dbobject - %A" fig~>objType)
            return()
        )
        label = dbCreateLabel(
            cvId
            fig~>lpp
            dbTransformPoint(fig~>xy transform)
            get(fig~>owner fig~>text)
            fig~>justify
            fig~>orient
            fig~>font
            fig~>height
        )
        unless(label
            ycWarn("failed to create a new label(%A)" fig~>owner~>name)
            return()
        )
        return(label)
    )
)

; END