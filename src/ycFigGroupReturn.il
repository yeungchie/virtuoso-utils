;--------------------------------
; Program  : virtuoso-utils(ycFigGroupReturn.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------------

procedure(ycFigGroupReturn(winId level "wx")
    let((comp hier group env)
        comp leGetEditFigGroup(winId) && 1 || 0
        when((comp == 1) && (level < length(ycGetHierMemFigGroup(winId))+comp)
            hier = ycGetHierMemFigGroup(winId)
            env = envGetVal("layout" "groupReturnMode")
            envSetVal("layout" "groupReturnMode" 'cyclic "GroupOnly")
            leReturnToLevel(winId)
            envSetVal("layout" "groupReturnMode" 'cyclic env)
            group = nth(level-1 hier)
            when(group && group~>objType == "figGroup"
                leSetEditFigGroup(group winId)
            )
        )
        comp = leGetEditFigGroup(winId) && 1 || 0
        length(ycGetHierMemFigGroup(winId))+comp
    )
)

; END