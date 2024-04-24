;--------------------------
; Program  : virtuoso-utils(ycCreateLibrary.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

procedure(ycCreateLibrary(libName \@key path techName "tgg")
    prog((libId techLib triName funcName triList config priority unregp)
        ddUpdateLibList()
        when(libId = ddGetObj(libName)
            ycWarn("there's already a library named '%s' in the library list." libName)
            return(libId)
        )
        when(path
            unless(stringp(path)
                ycError("argument for key ?path shoule be a string - %A" path)
            )
            path = simplifyFilenameUnique(path)
        )
        when(techName
            unless(stringp(techName)
                ycError("argument for key ?techName shoule be a string - %A" techName)
            )
            unless(techLib = ddGetObj(techName)
                ycWarn("argument for key ?techName shoule be a valid techLib name - %A" techName)
                return()
            )
            unless(techLib~>name == techGetTechFile(techLib)~>libName
                ycWarn("the library is not a techLib - %A" techName)
                return()
            )
        )
        triName  = "postCreateLib"
        funcName = 'SosCreateLibPostTrigCB
        triList  = ddGetTriggerList(triName)
        when(config = assv(symbolToString(funcName) triList)
            priority = caddr(config)
            unregp = ddUnregTrigger(triName funcName)
        )
        errset({
            libId = ddCreateLib(libName path||"")
            when(libId && techName
                techBindTechFile(libId techName)
            )
        } t)
        when(unregp
            apply('ddRegTrigger
                nconc(list(triName funcName) list(priority))
            )
        )
        return(libId)
    )
)

; END
