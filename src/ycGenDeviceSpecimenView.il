;------------------------------
; Program  : virtuoso-utils(ycGenDeviceSpecimenView.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;------------------------------

procedure(ycGenDeviceSpecimenView(libName cellName \@key viewName("schematic") techName "tttg")
    let((lib techLib cvId dev devices x y cols)
        unless(lib = ddGetObj(libName)
            ycError("invalid library name - %A" libName)
        )
        unless(techName
            techName = techGetTechFile(lib)~>libName
        )
        unless(techLib = ddGetObj(techName)
            ycError("invalid tech library name - %A" techName)
        )
        unless(cvId = dbOpenCellViewByType(libName cellName viewName "schematic" "w")
            ycError("cannot create cell view - %A/%A/%A" libName cellName viewName)
        )
        foreach(cell techLib~>cells
            foreach(view cell~>views
                when(view~>name == "symbol"
                    if(dev = dbOpenCellViewByType(techName cell~>name view~>name)
                        devices = cons(dev devices)
                        ycWarn("cannot access device cell view - %A/%A/%A" techName cell~>name view~>name)
                    )
                )
            )
        )
        x = 0
        y = 0
        cols = 0
        foreach(dev devices
            dbCreateInst(cvId dev nil x:y "R0")
            x += 5
            cols++
            when(cols == 10
                x = 0
                y += 5
                cols = 0
            )
        )
        schCheck(cvId)
        dbSave(cvId)
        dbReopen(cvId "r")
        t
    )
)

; END
