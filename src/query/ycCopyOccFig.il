;--------------------------------
; Program  : virtuoso-utils(ycCopyOccFig.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------------

procedure(ycCopyOccFig(occ cvId \@optional transform(list(0:0 "R0")) "gdl")
    let((fig tsf)
        fig = ycGetOccFig(occ)
        tsf = ycGetOccTransform(occ)
        dbCopyFig(fig cvId dbConcatTransform(tsf transform))
    )
)

; END