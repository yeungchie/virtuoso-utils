;--------------------------
; Program  : virtuoso-utils(ycRemoveShapeRedundant.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

procedure(ycRemoveShapeRedundant(cvId "d")
    let((flag)
        foreach(shape cvId~>shapes
            let((lpp tiles redundant)
                lpp = shape~>lpp
                tiles = dbLayerTile(cvId "y0" list(shape))
                redundant = !exists(fig tiles
                    let((danglings)
                        when(
                            danglings = dbLayerAndNot(cvId "y0" list(fig)
                                setof(x dbShapeQuery(cvId lpp fig~>bBox 0 0) x != shape)
                            )
                            mapcar('dbDeleteObject danglings)
                            t
                        )
                    )
                )
                mapcar('dbDeleteObject tiles)
                when(redundant
                    dbDeleteObject(shape)
                    flag = t
                )
            )
        )
        flag
    )
)

; END