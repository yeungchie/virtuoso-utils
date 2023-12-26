;--------------------------
; Program  : virtuoso-utils(ycConvertTextDisplayToLabel.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

procedure(ycConvertTextDisplayToLabel(fig "d")
    let((label figGroup parent)
        when(label = ycCopyTextDisplayToLabel(fig fig~>cellView)
            when(figGroup = fig~>figGroup
                unless(dbAddFigToFigGroup(figGroup label)
                    ycWarn("failed to add label(%A) to figGroup(%A)" label~>theLabel figGroup~>name)
                )
            )
            when(parent = fig~>parent
                unless(leAttachFig(label parent)
                    ycWarn("failed to attach label(%A) to parent(%A)" label~>theLabel parent~>objType)
                )
            )
            dbDeleteObject(fig)
            label
        )
    )
)

; END