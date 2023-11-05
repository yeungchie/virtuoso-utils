;--------------------------
; Program  : virtuoso-utils(ycGenLabelFromFig.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

procedure(ycGenLabelFromFig(fig \@key labelLpp labelText boundaryPoints "dggl")
    prog((netName lpp cvId grid zoomScale eps b bLines fLines center labels)
        unless(labelText
            unless(netName = fig~>net~>name
                ycWarn("can not found net name - %A" fig)
                return()
            )
            labelText = netName
        )
        lpp = labelLpp || fig~>lpp
        cvId = fig~>cellView
        grid = techGetMfgGridResolution(techGetTechFile(cvId))
        zoomScale = 0.8
        eps = 1.0e2
        unless(fLines = ycPointsToLines(ycGetFigPoints(fig))
            ycWarn("can not get points - %A" fig)
            return()
        )
        center = centerBox(fig~>bBox)

        when((b = car(dbBoundaryQuery(cvId fig~>bBox 0 0))) && (boundaryPoints = b~>points)
            bLines = ycPointsToLines(boundaryPoints)
            foreach(fl fLines
                foreach(bl bLines
                    let((butted pt ori just size)
                        when(butted = ycGetLineButted(bl fl)
                            pt = ycSnapPointToGrid(centerBox(butted) grid)
                            case(car(ycGetLineOri(butted))
                                ("H"
                                    ori = "R90"
                                    just = if(yCoord(pt) < yCoord(center)
                                        "centerLeft"
                                        "centerRight"
                                    )
                                )
                                ("V"
                                    ori = "R0"
                                    just = if(xCoord(pt) < xCoord(center)
                                        "centerLeft"
                                        "centerRight"
                                    )
                                )
                                (t
                                    ori = "R0"
                                    just = "centerCenter"
                                )
                            )
                            size = fix2(ycGetLineLength(butted)*zoomScale*eps)/eps
                            labels = cons(
                                dbCreateLabel(cvId lpp pt labelText just ori "stick" size)
                                labels
                            )
                        )
                    )
                ); foreach bl
            ); foreach fl
        )

        unless(labels
            let((size pt)
                case(fig~>objType
                    ("rect"
                        pt = centerBox(fig~>bBox)
                        size = apply('min ycGetBBoxSize(fig~>bBox))
                    )
                    ("path"
                        pt = if((fig~>bPoints == 2) centerBox(fig~>bBox) car(fig~>points))
                        size = fig~>width
                    )
                    ("pathSeg"
                        pt = centerBox(fig~>bBox)
                        size = fig~>width
                    )
                    (t
                        pt = car(fig~>points)
                        size = apply('min ycGetBBoxSize(fig~>bBox))
                    )
                )
                pt = ycSnapPointToGrid(pt grid)
                size = fix2(size*zoomScale*eps)/eps
                labels = list(
                    dbCreateLabel(cvId lpp pt labelText "centerCenter" "R0" "stick" size)
                )
            )
        )
        return(labels)
    )
)

; END