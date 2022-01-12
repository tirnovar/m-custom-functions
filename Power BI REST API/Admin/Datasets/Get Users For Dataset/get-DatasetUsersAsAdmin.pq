let
    output =
        (generatedToken as text, datasetId as text) =>
            let
                apiCall =
                    Json.Document(
                        Web.Contents(
                            "https://api.powerbi.com/v1.0/myorg/admin",
                            [
                                RelativePath = "datasets/" & datasetId & "/users",
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
                        datasetUserAccessRight = text,
                        emailAddress = text,
                        displayName = text,
                        identifier = text,
                        graphId = text,
                        principalType = text,
                        userType = text
                    ],
                    List.Transform(
                        apiCall[value],
                        each
                            {
                                _[datasetUserAccessRight]?,
                                _[emailAddress]?,
                                _[displayName]?,
                                _[identifier]?,
                                _[graphId]?,
                                _[principalType]?,
                                _[userType]?
                            }
                    )
                ),
    documentation = [
        Documentation.Name = " get-DatasetsAsAdminWithUsers.pq ",
        Documentation.Description = " Get all users that has access into inputed dataset ",
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