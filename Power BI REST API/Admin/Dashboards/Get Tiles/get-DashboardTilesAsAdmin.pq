let
    output =
        (generatedToken as text, dashboardId as text) =>
            let
                apiCall =
                    Json.Document(
                        Web.Contents(
                            "https://api.powerbi.com/v1.0/myorg",
                            [
                                RelativePath = "admin/dashboards/" & dashboardId & "/tiles",
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
                        embedUrl = text,
                        rowSpan = text,
                        colSpan = text,
                        reportId = text,
                        datasetId = text
                    ],
                    List.Transform(
                        apiCall[value],
                        each
                            {
                                _[id]?,
                                _[embedUrl]?,
                                _[rowSpan]?,
                                _[colSpan]?,
                                _[reportId]?,
                                _[datasetId]?
                            }
                    )
                ),
    documentation = [
        Documentation.Name = " get-DashboardTilesAsAdmin.pq ",
        Documentation.Description = " Get all tiles of dashboard as Admin ",
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