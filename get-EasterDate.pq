let
    outputEster =
        (EasterYear as number) as date =>
            let
                FirstDig = Number.RoundDown(EasterYear / 100),
                Remain19 = Number.Mod(EasterYear, 19),
                Temp1 =
                    Number.Mod(
                        Number.RoundDown((FirstDig - 15) / 2)
                        + 202
                        - 11
                        * Remain19,
                        30
                    ),
                tA =
                    Temp1
                    + 21
                    + (
                        if
                            (Temp1 = 29)
                            or ((Temp1 = 28) and (Remain19 > 10))
                        then
                            -1
                        else
                            0
                    ),
                tB = Number.Mod(tA - 19, 7),
                tCpre = Number.Mod(40 - FirstDig, 4),
                tC =
                    tCpre
                    + (
                        if tCpre = 3 then
                            1
                        else
                            0
                    )
                    + (
                        if tCpre > 1 then
                            1
                        else
                            0
                    ),
                Temp2 = Number.Mod(EasterYear, 100),
                tD =
                    Number.Mod(
                        Temp2 + Number.RoundDown(Temp2 / 4),
                        7
                    ),
                tE = Number.Mod(20 - tB - tC - tD, 7) + 1,
                d = tA + tE,
                EasterDay =
                    if d > 31 then
                        d - 31
                    else
                        d,
                EasterMonth =
                    if d > 31 then
                        4
                    else
                        3,
                Result =
                    #date(
                        EasterYear,
                        EasterMonth,
                        EasterDay
                    )
            in
                Result,
    documentation = [
        Documentation.Name = " get-EasterDate.pq ",
        Documentation.Description = " Returning Date of Easter Sunday for inputed Year. ",
        Documentation.Source = "https://www.jaknapowerbi.cz . ",
        Documentation.Version = " 1.0 ",
        Documentation.Author = " Štěpán Rešl "
    ]
in
    Value.ReplaceType(
        outputEster,
        Value.ReplaceMetadata(
            Value.Type(outputEster),
            documentation
        )
    )