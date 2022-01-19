let
    output =
        (generatedToken as text, workspaceId as text) =>
            let
                apiCall =
                    Json.Document(
                        Web.Contents(
                            "https://api.powerbi.com/v1.0/myorg/admin",
                            [
                                RelativePath = "groups/" & workspaceId & "/reports",
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
                        reportType = text,
                        name = text,
                        webUrl = text,
                        embedUrl = text,
                        datasetId = text,
                        createdDateTime = datetime,
                        modifiedDateTime = datetime,
                        modifiedBy = text
                    ],
                    List.Transform(
                        apiCall[value],
                        each
                            {
                                _[id]?,
                                _[reportType]?,
                                _[name]?,
                                _[webUrl]?,
                                _[embedUrl]?,
                                _[datasetId]?,
                                _[createdDateTime]?,
                                _[createdDateTime]?,
                                _[modifiedBy]?
                            }
                    )
                ),
    documentation = [
        Documentation.Name = " get-ReportsInGroupAsAdmin.pq ",
        Documentation.Description = " Get all reports in group as Admin ",
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