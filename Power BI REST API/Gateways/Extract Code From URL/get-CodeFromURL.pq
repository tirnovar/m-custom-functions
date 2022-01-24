let
    output =
        (resultUrl as text) as text =>
            let
                extractor =
                    Text.BetweenDelimiters(
                        resultUrl,
                        "=",
                        "&"
                    )
            in
                extractor,
    documentation = [
        Documentation.Name = " get-CodeFromURL.pq ",
        Documentation.Description = " Get the code from the URL ",
        Documentation.Source = "https://www.jaknapowerbi.cz",
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