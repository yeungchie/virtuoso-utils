;--------------------------
; Program  : virtuoso-utils(ycSetPhysicalBindingByName.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

procedure(ycSetPhysicalBindingByName(cvId \@key logicLib logicCell physLib physCell physView("layout") "dttttt")
    let((config)
        unless(member(cvId~>cellViewType list("schematic" "maskLayout"))
            ycError("requires schematic or maskLayout cellview type - %A" cvId~>cellViewType)
        )
        config = if(ddGetObj(cvId~>libName cvId~>cellName "physConfig")
            cphOpenConfig(cvId~>libName cvId~>cellName "physConfig" "a")
            cphCreatePhysConfig(
                cvId~>libName
                cvId~>cellName
                "physConfig"
                cvId~>libName
                cvId~>cellName
                "schematic"
                ?libList    buildString(list(cvId~>libName physLib))
                ?switchList "physConfig schematic symbol"
                ?stopList   "layout abstract"
                ?cstList    "constraint"
            )
        )
        cphSetCellPhysicalBinding(config logicLib logicCell physLib physCell physView)
        cphSaveConfig(config)
        cphChangeEditMode(config "r")
    )
)

; END