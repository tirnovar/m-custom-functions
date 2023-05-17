let
    output = (input as number) =>
        let
            out = (if input <= 1 then Text.From(input) else "1")
                & Text.Reverse(
                    Text.Combine(
                        List.Generate(
                            () => [result = null, actual = input],
                            each [actual] >= 1,
                            each
                                [
                                    result = Text.From(Number.Mod([actual], 2)),
                                    actual = Number.RoundDown([actual] / 2)
                                ],
                            each [result]
                        )
                    )
                )
        in
            out,
    documentation = [
        Documentation.Name = " get-DECtoBIN.pq ",
        Documentation.Description = " Transfer decimal number to binary number. ",
        Documentation.Source = "https://www.datameerkat.com . ",
        Documentation.Version = " 1.0 ",
        Documentation.Author = " Štěpán Rešl "
    ]
in
    Value.ReplaceType(output, Value.ReplaceMetadata(Value.Type(output), documentation))
