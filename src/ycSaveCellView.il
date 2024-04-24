;--------------------------
; Program  : virtuoso-utils(ycSaveCellView.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

procedure(ycSaveCellView(cvId "d")
    cond(
        (cvId~>objType != "cellView"
            ycError("argument #1 should be a cellView object - %A" cvId)
        )
        (cvId~>mode == "r"
            ycWarn("Attempt to save a read-only design.")
        )
        (t
            while(cvId~>modifiedButNotSaved
                dbSave(cvId)
            )
            t
        )
    )
)

; END