let
    output =
        (generatedToken as text, identifier as text) =>
            let
                callingPath =
                    "https://api.powerbi.com/v1.0/myorg/admin/users/"
                    & identifier
                    & "/subscriptions",
                callInitStructure = [
                    Headers = [
                        #"Content-Type" = "application/json",
                        Authorization = generatedToken
                    ]
                ],
                apiCalling = (uri as text, structure as record) => Json.Document(Web.Contents(uri, structure)),
                generator =
                    List.Buffer(
                        List.Generate(
                            () =>
                                [
                                    result =
                                        apiCalling(
                                            callingPath,
                                            callInitStructure
                                        ),
                                    uri = result[continuationUri]?
                                ],
                            each [uri] <> null,
                            each
                                [
                                    result = apiCalling(uri, callInitStructure),
                                    uri = _[result][continuationUri]?
                                ],
                            each [result][subscriptionEntities]?
                        )
                    ),
                tbl =
                    #table(
                        type table [nestedList = list],
                        List.Transform(generator, each
                            {
                                _
                            })
                    ),
                expandList =
                    Table.ExpandListColumn(
                        tbl,
                        "nestedList"
                    ),
                resultTable =
                    #table(
                        type table [
                            id = text,
                            title = text,
                            artifactId = text,
                            artifactDislayName = text,
                            subArtifactDisplayName = text,
                            artifactType = text,
                            isEnabled = logical,
                            frequency = text,
                            startDate = datetime,
                            endDate = datetime,
                            linkToContent = logical,
                            previewImage = logical,
                            attachmentFormat = text,
                            users = list
                        ],
                        List.Transform(
                            List.RemoveNulls(expandList[nestedList]),
                            each
                                {
                                    _[id]?,
                                    _[tite]?,
                                    _[artifactId]?,
                                    _[artifactDislayName]?,
                                    _[subArtifactDisplayName]?,
                                    _[artifactType]?,
                                    _[isEnabled]?,
                                    _[frequency]?,
                                    _[startDate]?,
                                    _[endDate]?,
                                    _[linkToContent]?,
                                    _[previewImage]?,
                                    _[attachmentFormat]?,
                                    _[users]?
                                }
                        )
                    )
            in
                resultTable,
    documentation = [
        Documentation.Name = " get-UserSubscriptionsAsAdmin.pq ",
        Documentation.Description = " Get user subscriptions as an Admin ",
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