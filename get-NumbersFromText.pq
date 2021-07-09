let
    output =
        (input) as number =>
            let
                recieved = Text.Select(Text.From(input), {"0".."9"}),
                out = Number.From(recieved)
            in
                out,
    documentation = [
        Documentation.Name = " get-NumbersFromText.pq ",
        Documentation.Description = " Returns all numbers from input text source ",
        Documentation.Source = " https://www.jaknapowerbi.cz ",
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