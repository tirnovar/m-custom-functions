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
                                    9
                                )
                            )
                        else
                            Number.From(
                                Text.Repeat("9", Text.From(dif))
                                & Text.From(fromNumber)
                            )
                    else if dif = 0 then
                        Number.From(
                            Text.ReplaceRange(
                                Text.From(fromNumber),
                                m_nmb - 1,
                                1,
                                9
                            )
                        )
                    else
                        Number.From(
                            Text.From(fromNumber)
                            & Text.Repeat("9", Text.From(dif))
                        ),
                out =
                    List.Generate(
                        () => enmb,
                        each _ > fromNumber,
                        each _ - 1
                    )
            in
                out,
    documentation = [
        Documentation.Name = " get-RangeOfNumbers.pq ",
        Documentation.Description = " Trasform full table into one JSON as Text ",
        Documentation.Source = "https://www.jaknapowerbi.cz . ",
        Documentation.Version = " 1.0 ",
        Documentation.Author = " Štěpán Rešl "
    ]
in
    Value.ReplaceType(
        output,
        Value.ReplaceMetadata(
            Value.Type(output),
            documentation
        )
    )