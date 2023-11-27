;--------------------------
; Program  : virtuoso-utils(ycGetSortedSelectByLine.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

procedure(ycGetSortedSelectByLine(\@optional winId(hiGetCurrentWindow()) "w")
    let((selFigs line appendFigs)
        selFigs = geGetSelSet(winId)
        line = foreach(mapcar x enterLine(?wantPoints 2)
            geWindowToEditPoint(winId x)
        )
        appendFigs = ycFlattenList(geGetSortedSelectByLine(winId line))
        geDeselectFigs(geGetSelSet(winId))
        geSelectFigs(ycUnique(append(selFigs appendFigs)))
        geGetSelSet(winId)
    )
)

; END