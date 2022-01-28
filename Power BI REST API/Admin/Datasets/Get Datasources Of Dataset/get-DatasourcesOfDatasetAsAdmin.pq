let
    output =
        (generatedToken as text, datasetId as text) =>
            let
                apiCall =
                    Json.Document(
                        Web.Contents(
                            "https://api.powerbi.com/v1.0/myorg",
                            [
                                RelativePath = "admin/datasets/" & datasetId & "/datasources",
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
                        datasourceType = text,
                        connectionDetails_account = text,
                        connectionDetails_domain = text,
                        connectionDetails_path = text,
                        connectionDetails_kind = text,
                        connectionDetails_url = text,
                        gatewayId = text
                    ],
                    List.Transform(
                        apiCall[value],
                        each
                            {
                                _[datasourceType]?,
                                _[connectionDetails]?[account]?,
                                _[connectionDetails]?[domain]?,
                                _[connectionDetails]?[path]?,
                                _[connectionDetails]?[kind]?,
                                _[connectionDetails]?[url]?,
                                _[gatewayId]?
                            }
                    )
                ),
    documentation = [
        Documentation.Name = " get-DatasourcesOfDatasetAsAdmin.pq ",
        Documentation.Description = " Get all datasources of dataset ",
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