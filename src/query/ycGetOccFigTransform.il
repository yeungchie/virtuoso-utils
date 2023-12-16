;--------------------------------
; Program  : virtuoso-utils(ycGetOccFigTransform.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------------

procedure(ycGetOccFigTransform(occ "g")
    dbGetHierPathTransform(append1(occ nil))
)

; END