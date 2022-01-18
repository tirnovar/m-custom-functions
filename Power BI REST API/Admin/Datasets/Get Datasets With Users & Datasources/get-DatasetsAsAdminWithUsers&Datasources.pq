let
    output =
        (generatedToken as text) =>
            let
                apiCall =
                    Json.Document(
                        Web.Contents(
                            "https://api.powerbi.com/v1.0/myorg/admin",
                            [
                                RelativePath = "datasets",
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
                        addRowsAPIEnabled = logical,
                        configuredBy = text,
                        isRefreshable = logical,
                        isEffectiveIdentityRequired = logical,
                        isEffectiveIdentityRolesRequired = logical,
                        isOnPremGatewayRequired = logical,
                        webUrl = text,
                        targetStorageMode = text,
                        createdDate = datetime,
                        createReportEmbedURL = text,
                        qnaEmbedURL = text,
                        upstreamDatasets = list,
                        users = table,
                        datasources = table
                    ],
                    List.Transform(
                        apiCall[value],
                        each
                            {
                                _[id]?,
                                _[name]?,
                                _[addRowsAPIEnabled]?,
                                _[configuredBy]?,
                                _[isRefreshable]?,
                                _[isEffectiveIdentityRequired]?,
                                _[isEffectiveIdentityRolesRequired]?,
                                _[isOnPremGatewayRequired]?,
                                _[webUrl]?,
                                _[targetStorageMode]?,
                                _[createdDate]?,
                                _[createReportEmbedURL]?,
                                _[qnaEmbedURL]?,
                                _[upstreamDatasets]?,
                                get-DatasetUsersAsAdmin(generatedToken,_[id]),
                                get-DatasourcesOfDatasetAsAdmin(generatedToken,_[id])
                            }
                    )
                ),
    documentation = [
        Documentation.Name = " get-DatasetsAsAdminWithUsers&Datasources.pq ",
        Documentation.Description = " Get all datasets with their users and datasources. IF YOU HAVE LOT OF DATASETS THEN I AM STRONGLY NOT RECCOMENDING USING THIS FUNCTION, BECAUSE OF THE LIMITS OF THE API CALLS PER HOUR. ",
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