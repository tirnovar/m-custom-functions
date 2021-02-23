let
    output =
        (fromNumber as number, maxCountOfDigits as number, fromStart as logical) as list =>
            let
                m_nmb = maxCountOfDigits,
                dcounter = Number.From(Text.Length(Text.From(fromNumber))),
                dif = m_nmb - dcounter,
                enmb =
                    if fromStart = true then
                        if dif = 0 then
                            Number.From(
                                Text.ReplaceRange(
                                    Text.From(fromNumber),
                                    0,
                                    1,
                                    "9"
                                )
                            )
                        else
                            Number.From(
                                Text.PadStart(
                                    Text.From(fromNumber),
                                    dif,
                                    "9"
                                )
                            )
                    else if dif = 0 then
                        Number.From(
                            Text.ReplaceRange(
                                Text.From(fromNumber),
                                m_nmb - 1,
                                1,
                                "9"
                            )
                        )
                    else
                        Number.From(
                            Text.PadEnd(
                                Text.From(fromNumber),
                                dif,
                                "9"
                            )
                        ),
                out =
                    List.Generate(
                        () => enmb,
                        each _ >= fromNumber,
                        each _ - 1
                    )
            in
                out,
    documentation = [
        Documentation.Name = " get-RangeOfNumbers.pq ",
        Documentation.Description = " Return list of numbers between start number and latest number that can be created by inputed count of digits. If you use true and fromStart variable then numbers will be added to the start otherwise it will be to the end. ",
        Documentation.Source = "https://www.jaknapowerbi.cz . ",
        Documentation.Version = " 1.0 ",
        Documentation.Author = " Štěpán Rešl ",
        Documentation.Examples = {
            [
                Description = " Input: 4444, 4, false ",
                Result = "{4444, 4445, 4446, 4447, 4448, 4449}"
            ]
        }
    ]
in
    Value.ReplaceType(
        output,
        Value.ReplaceMetadata(
            Value.Type(output),
            documentation
        )
    )