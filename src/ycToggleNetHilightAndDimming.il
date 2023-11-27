;--------------------------------
; Program  : virtuoso-utils(ycToggleNetHilightAndDimming.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------------

procedure(ycToggleNetHilightAndDimming()
    let((sym menu bool)
        sym = 'schViewMenu
        when(boundp(sym) && (menu = eval(sym)) && hiIsMenu(menu)
            bool = !apply('and
                foreach(mapcar x '(NetHighlights Dimming)
                    get(menu x)~>checked
                )
            )
            foreach(x '(NetHighlights Dimming)
                get(menu x)~>checked = bool
            )
            bool
        )
    )
)

; END