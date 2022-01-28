let
    output =
        (generatedToken as text, scanId as text) =>
            let
                apiCall =
                    Json.Document(
                        Web.Contents(
                            "https://api.powerbi.com/v1.0/myorg",
                            [
                                RelativePath = "admin/workspaces/scanResult/" & scanId,
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
                        name = text,
                        #"type" = text,
                        state = text,
                        isOnDedicatedCapacity = text,
                        capacityId = text,
                        reports = list,
                        dashboards = list,
                        datasets = list,
                        dataflows = list
                    ],
                    List.Transform(
                        apiCall[workspaces],
                        each
                            {
                                _[id]?,
                                _[name]?,
                                _[#"type"]?,
                                _[state]?,
                                _[isOnDedicatedCapacity]?,
                                _[capacityId]?,
                                _[reports]?,
                                _[dashboards]?,
                                _[datasets]?,
                                _[dataflows]?
                            }
                    )
                ),
    documentation = [
        Documentation.Name = " get-ScanResult.pq ",
        Documentation.Description = " This Call should be called only if status of scan is "" Successful "" if you wanna be sure, then use function get-ScanStatusAndResults ",
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