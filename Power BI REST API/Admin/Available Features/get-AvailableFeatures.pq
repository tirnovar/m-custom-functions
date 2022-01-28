let
    output =
        (generatedToken as text) =>
            let
                apiCall =
                    Json.Document(
                        Web.Contents(
                            "https://api.powerbi.com/v1.0/myorg",
                            [
                                RelativePath = "availableFeatures",
                                Headers = [
                                    #"Content-Type" = "application/json",
                                    Authorization = generatedToken
                                ]
                            ]
                        )
                    )
            in
                #table(
                    type table [
                        name = text,
                        state = text,
                        extendedState = text,
                        additionalInfo = record
                    ],
                    List.Transform(
                        apiCall[features],
                        each
                            {
                                _[name]?,
                                _[state]?,
                                _[extendedState]?,
                                _[additionalInfo]?
                            }
                    )
                ),
    documentation = [
        Documentation.Name = " get-AvailableFeatures.pq ",
        Documentation.Description = " Get all available features for a Power BI Service ",
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