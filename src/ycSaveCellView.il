;--------------------------
; Program  : virtuoso-utils(ycSaveCellView.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

procedure(ycSaveCellView(cvId "d")
    if(cvId~>mode == "r"
    then
        ycWarn("Attempt to save a read-only design.")
    else
        while(cvId~>modifiedButNotSaved
            dbSave(cvId)
        )
        t
    )
)

; END