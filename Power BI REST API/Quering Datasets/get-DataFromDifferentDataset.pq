let
    output =
        (generatedToken as text, datasetId as text, tableName as text, optional daxQuery as text) =>
            let
                daxQueryForCall =
                    if daxQuery = null then
                        "VALUES( " & tableName & " )"
                    else
                        daxQuery,
                apiCall =
                    Json.Document(
                        Web.Contents(
                            "https://api.powerbi.com/v1.0/myorg/datasets",
                            [
                                RelativePath = datasetId & "/executeQueries",
                                Headers = [
                                    #"Content-Type" = "application/json",
                                    Authorization = generatedToken
                                ],
                                Content =
                                    Text.ToBinary(
                                        "
                                    {
                                        ""queries"":[
                                            {
                                                ""query"": ""EVALUATE "
                                        & daxQueryForCall
                                        & """ 
                                            }
                                        ],
                                        ""serializerSettings"":{
                                            ""includeNulls"": false
                                        }
                                    }
                                    "
                                    )
                            ]
                        )
                    ),
                response =
                    let
                        initSource = apiCall[results]?{0}?[tables]?{0}?[rows]?,
                        namesOfColumns = List.Buffer(Record.FieldNames(initSource{0})),
                        correctedColumnsNames =
                            List.Transform(
                                namesOfColumns,
                                each Text.BetweenDelimiters(_, "[", "]")
                            ),
                        tableCreator =
                            Table.FromList(
                                initSource,
                                Record.FieldValues,
                                correctedColumnsNames
                            )
                    in
                        tableCreator
            in
                response,
    documentation = [
        Documentation.Name = " get-DataFromDifferentDataset.pq ",
        Documentation.Description = " Get data from different dataset stored in Power BI Service ",
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