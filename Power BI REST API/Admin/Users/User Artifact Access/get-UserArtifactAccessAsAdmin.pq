let
    output =
        (generatedToken as text, identifier as text) =>
            let
                callingPath =
                    "https://api.powerbi.com/v1.0/myorg/admin/users/"
                    & identifier
                    & "/artifactAccess",
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
                            each [result][ArtifactAccessEntities]?
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
                            artifactId = text,
                            displayName = text,
                            artifactType = text,
                            accessRight = text
                        ],
                        List.Transform(
                            List.RemoveNulls(expandList[nestedList]),
                            each
                                {
                                    _[artifactId]?,
                                    _[displayName]?,
                                    _[artifactType]?,
                                    _[accessRight]?
                                }
                        )
                    )
            in
                resultTable,
    documentation = [
        Documentation.Name = " get-UserArtifactAccessAsAdmin.pq ",
        Documentation.Description = " Get access rights for a user as an admin ",
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