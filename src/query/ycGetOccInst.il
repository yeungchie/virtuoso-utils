;--------------------------------
; Program  : virtuoso-utils(ycGetOccInst.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------------

procedure(ycGetOccInst(occ "g")
    let((ref)
        when(listp(occ)
            ref = cadr(reverse(occ))
            when(listp(ref)
                ref = car(ref)
            )
        )
        ref
    )
)

; END