;--------------------------
; Program  : virtuoso-utils(ycQuickSetPhysicalBinding.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

procedure(ycQuickSetPhysicalBinding(cvId logicLibName physLibName "dtt")
    let((config map)
        unless(cvId~>cellViewType == "schematic"
            ycError("requires a schematic cellview - %A" cvId~>cellViewType)
        )
        config = if(ddGetObj(cvId~>libName cvId~>cellName "physConfig")
            cphOpenConfig(
                cvId~>libName
                cvId~>cellName
                "physConfig"
                "a"
            )
            cphCreatePhysConfig(
                cvId~>libName
                cvId~>cellName
                "physConfig"
                cvId~>libName
                cvId~>cellName
                "schematic"
                ?libList    buildString(list(cvId~>libName physLibName))
                ?switchList "physConfig schematic symbol"
                ?stopList   "layout abstract"
                ?cstList    "constraint"
            )
        )
        map = makeTable("" nil)
        foreach(x cvId~>instances
            when((x~>libName == logicLibName) && !map[x~>cellName]
                cphSetCellPhysicalBinding(
                    config
                    logicLibName
                    x~>cellName
                    physLibName
                    x~>cellName
                    "layout"
                )
                map[x~>cellName] = t
            )
        )
        cphSaveConfig(config)
        cphChangeEditMode(config "r")
    )
)

; END