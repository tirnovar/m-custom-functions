let
    output =
        (generatedToken as text) =>
            let
                apiCall =
                    Json.Document(
                        Web.Contents(
                            "https://api.powerbi.com/v1.0/myorg/admin",
                            [
                                RelativePath = "dataflows",
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
                        objectId = text,
                        name = text,
                        description = text,
                        workspaceId = text,
                        modelUrl = text,
                        configuredBy = text,
                        users = list,
                        modifiedBy = text,
                        modifiedDateTime = datetime
                    ],
                    List.Transform(
                        apiCall[value],
                        each
                            {
                                _[objectId]?,
                                _[name]?,
                                _[description]?,
                                _[workspaceId]?,
                                _[modelUrl]?,
                                _[configuredBy]?,
                                _[users]?,
                                _[modifiedBy]?,
                                _[modifiedDateTime]?
                            }
                    )
                ),
    documentation = [
        Documentation.Name = " get-DatalowsAsAdmin.pq ",
        Documentation.Description = " Get all dataflows as admin ",
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