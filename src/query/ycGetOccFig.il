;--------------------------------
; Program  : virtuoso-utils(ycGetOccFig.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------------

procedure(ycGetOccFig(occ "g")
    if(listp(occ)
        car(last(occ))
        occ
    )
)

; END