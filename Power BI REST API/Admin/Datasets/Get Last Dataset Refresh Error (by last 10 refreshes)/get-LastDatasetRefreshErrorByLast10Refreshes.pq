let
    output =
        (generatedToken as text, datasetId as text) =>
            let
                apiCall =
                    Json.Document(
                        Web.Contents(
                            "https://api.powerbi.com/v1.0/myorg/admin",
                            [
                                RelativePath = "datasets/" & datasetId & "/refreshes",
                                Query = [
                                    #"$top" = "10"
                                ],
                                Headers = [
                                    #"Content-Type" = "application/json",
                                    Authorization = generatedToken
                                ]
                            ]
                        )
                    ),
                filter =
                    let
                        skip =
                            List.Buffer(
                                List.Skip(
                                    apiCall[value],
                                    each _[status]? <> "Failed"
                                )
                            ),
                        out =
                            if skip = {} then
                                []
                            else
                                let
                                    getMaxDate =
                                        List.Accumulate(
                                            skip,
                                            [endTime = #datetime(2000, 1, 1, 0, 0, 0)],
                                            (state, current) =>
                                                if
                                                    DateTime.From(state[endTime])
                                                    > DateTime.From(current[endTime])
                                                then
                                                    state
                                                else
                                                    current
                                        )
                                in
                                    getMaxDate
                    in
                        out
            in
                #table(
                    type table [
                        requestId = text,
                        id = text,
                        refreshType = text,
                        startTime = datetime,
                        endTime = datetime,
                        status = text
                    ],
                    List.Transform(
                        {filter},
                        each
                            {
                                _[requestId]?,
                                _[id]?,
                                _[refreshType]?,
                                _[startTime]?,
                                _[endTime]?,
                                _[status]?
                            }
                    )
                ),
    documentation = [
        Documentation.Name = " get-LastDatasetRefreshErrorByLast10Refreshes.pq ",
        Documentation.Description = " Get the newest Error on refresh dataset by last 10 refreshes ",
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