let
    output =
        (generatedToken as text) =>
            let
                apiCall =
                    Json.Document(
                        Web.Contents(
                            "https://graph.microsoft.com/beta",
                            [
                                RelativePath = "informationProtection/policy/labels",
                                Headers = [
                                    #"Content-Type" = "application/json",
                                    #"User-Agent"="testuserPrincipal",
                                    Authorization = generatedToken
                                ]
                            ]
                        )
                    )
            in

                #table(
                    type table [
                        id = text,
                        name = text,
                        description = text,
                        color = text,
                        sensitivity = text,
                        tooltip = text,
                        parentId = text
                        ],
                    List.Transform(apiCall[value], each
                        {
                            _[id]?,
                            _[name]?,
                            _[description]?,
                            _[color]?,
                            _[sensitivity]?,
                            _[tooltip]?,
                            _[parent]?[id]?
                        })
                ),
    documentation = [
        Documentation.Name = " get-InformationProtectionLabels.pq ",
        Documentation.Description = " Get All Information Protection Labels  ",
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