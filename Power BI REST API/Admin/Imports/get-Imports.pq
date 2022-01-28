let
    output =
        (generatedToken as text) =>
            let
                apiCall =
                    Json.Document(
                        Web.Contents(
                            "https://api.powerbi.com/v1.0/myorg",
                            [
                                RelativePath = "admin/imports",
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
                        id = text,
                        importState = text,
                        createdDateTime = datetime,
                        updatedDateTime = datetime,
                        name = text,
                        connectionType = text,
                        source = text,
                        datasets = list,
                        reports = list,
                        dataflows = list
                    ],
                    List.Transform(
                        apiCall[value],
                        each
                            {
                                _[id]?,
                                _[importState]?,
                                _[createdDateTime]?,
                                _[updatedDateTime]?,
                                _[name]?,
                                _[connectionType]?,
                                _[source]?,
                                _[datasets]?,
                                _[reports]?,
                                _[dataflows]?
                            }
                    )
                ),
    documentation = [
        Documentation.Name = " get-Imports.pq ",
        Documentation.Description = " Get all imports to tentant ",
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