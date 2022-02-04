let
    output =
        (generatedToken as text, datasetId as text) =>
            let
                apiCall =
                    Json.Document(
                        Web.Contents(
                            "https://api.powerbi.com/v1.0/myorg",
                            [
                                RelativePath =
                                    "admin/datasets/"
                                    & datasetId
                                    & "/refreshes",
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
                        requestId = text,
                        id = text,
                        refreshType = text,
                        startTime = datetime,
                        endTime = datetime,
                        status = text,
                        refreshInSeconds = number
                    ],
                    List.Transform(
                        apiCall[value],
                        each
                            let
                                stTime = DateTime.From(_[startTime]?),
                                enTime = DateTime.From(_[endTime]?),
                                durationOfRefresh =
                                    if stTime = null or enTime = null then
                                        null
                                    else
                                        Duration.TotalSeconds(enTime - stTime)
                            in
                                {
                                    _[requestId]?,
                                    _[id]?,
                                    _[refreshType]?,
                                    stTime,
                                    enTime,
                                    _[status]?,
                                    durationOfRefresh
                                }
                    )
                ),
    documentation = [
        Documentation.Name = " get-DatasetRefreshHistory.pq ",
        Documentation.Description = " Get the refresh history of a dataset ",
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