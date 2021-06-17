let
    output =
        (token as text, Id as text) =>
            let
                header = [
                    #"Authorization" = token
                ],
                call =
                    Json.Document(
                        Web.Contents(
                            "https://api.storyous.com/merchants",
                            [
                                RelativePath = Id,
                                Headers = header
                            ]
                        )
                    ),
                tbl = Record.ToTable(call),
                trnsp =
                    Table.ExpandListColumn(
                        Table.PromoteHeaders(
                            Table.Transpose(tbl),
                            [PromoteAllScalars = true]
                        ),
                        "places"
                    ),
                placeCodes = Record.FieldNames(trnsp[places]{0}),
                expandPlaces =
                    Table.ExpandRecordColumn(
                        trnsp,
                        "places",
                        placeCodes,
                        List.Transform(
                            placeCodes,
                            each _ & ".places"
                        )
                    ),
                getBills =
                    Table.AddColumn(
                        expandPlaces,
                        "bills",
                        each
                            let
                                getBill =
                                    List.Generate(
                                        () =>
                                            [
                                                URL = [merchantId] & "-" & [placeId.places],
                                                Result =
                                                    Json.Document(
                                                        Web.Contents(
                                                            "https://api.storyous.com/bills",
                                                            [
                                                                RelativePath = URL,
                                                                Headers = header
                                                            ]
                                                        )
                                                    )
                                            ],
                                        each [URL] <> null,
                                        each
                                            [
                                                URL = [Result][nextPage],
                                                Result =
                                                    Json.Document(
                                                        Web.Contents(
                                                            "https://api.storyous.com",
                                                            [
                                                                RelativePath = URL,
                                                                Headers = header
                                                            ]
                                                        )
                                                    )
                                            ]
                                    )
                            in
                                getBill
                    ),
                expandBills =
                    Table.ExpandListColumn(
                        getBills,
                        "bills"
                    )
            in
                expandBills,
    documentation = [
        Documentation.Name = " get-StoryousDataOfMarketPlaceBillsByAPI.pq ",
        Documentation.Description = " Getting data from Storyous about Markets, Places and their bills by API. Need Previous funcions get-StoryousAPIKey.pq ",
        Documentation.Source = "https://www.jaknapowerbi.cz",
        Documentation.Version = " 1.0 ",
        Documentation.Author = " Štěpán Rešl ",
        Documentation.Examples = {
            [
                Description = " Input: #""Token"", marketID ",
                Code = "",
                Result = ""
            ]
        }
    ]
in
    Value.ReplaceType(
        output,
        Value.ReplaceMetadata(
            Value.Type(output),
            documentation
        )
    )