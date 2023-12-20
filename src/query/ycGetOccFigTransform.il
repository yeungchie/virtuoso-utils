;--------------------------------
; Program  : virtuoso-utils(ycGetOccFigTransform.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------------

procedure(ycGetOccFigTransform(occ "g")
    occ && dbGetHierPathTransform(
        if(listp(occ)
            append1(occ nil)
            list(occ nil)
        )
    )
)

; END