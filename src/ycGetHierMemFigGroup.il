;--------------------------------
; Program  : virtuoso-utils(ycGetHierMemFigGroup.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------------

procedure(ycGetHierMemFigGroup(winId "w")
    let((fg hier)
        when(fg = leGetEditFigGroup(winId)
            while(fg = fg~>figGroup
                hier = cons(fg hier)
            )
        )
        hier
    )
)

; END