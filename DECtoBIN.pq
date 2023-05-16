let
    output = (input as number) =>
        (if input <= 1 then Text.From(input) else "1")
            & Text.Reverse(
                Text.Combine(
                    List.Generate(
                        () => [result = null, actual = input],
                        each [actual] >= 1,
                        each [
                            result = Text.From(Number.Mod([actual], 2)),
                            actual = Number.RoundDown([actual] / 2)
                        ],
                        each [result]
                    )
                )
            )
in
    output
