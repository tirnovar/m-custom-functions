let
    output =
        (startingYear as number, endingYear as number) as table =>
            let
                startYear = Text.From(startingYear),
                endYear = Text.From(endingYear),
                firstCall =
                    let
                        get =
                            Csv.Document(
                                Web.Contents(
                                    "https://www.cnb.cz",
                                    [
                                        RelativePath = "cs/financni-trhy/devizovy-trh/kurzy-devizoveho-trhu/kurzy-devizoveho-trhu/rok.txt",
                                        Query = [
                                            rok = endYear
                                        ]
                                    ]
                                ),
                                [
                                    Delimiter = "|",
                                    Encoding = 65001,
                                    QuoteStyle = QuoteStyle.None
                                ]
                            ),
                        names =
                            Table.PromoteHeaders(
                                get,
                                [PromoteAllScalars = true]
                            )
                    in
                        names,
                columnNames = Table.ColumnNames(firstCall),
                tbl =
                    #table(
                        type table [
                            Year = Int64.Type,
                            Kurzy = table
                        ],
                        List.Transform(
                            {startingYear..endingYear},
                            each
                                {
                                    _,
                                    let
                                        get =
                                            Csv.Document(
                                                Web.Contents(
                                                    "https://www.cnb.cz",
                                                    [
                                                        RelativePath = "cs/financni-trhy/devizovy-trh/kurzy-devizoveho-trhu/kurzy-devizoveho-trhu/rok.txt",
                                                        Query = [
                                                            rok = Text.From(_)
                                                        ]
                                                    ]
                                                ),
                                                [
                                                    Delimiter = "|",
                                                    Encoding = 65001,
                                                    QuoteStyle = QuoteStyle.None
                                                ]
                                            ),
                                        names =
                                            Table.PromoteHeaders(
                                                get,
                                                [PromoteAllScalars = true]
                                            )
                                    in
                                        names
                                }
                        )
                    ),
                out =
                    Table.ExpandTableColumn(
                        tbl,
                        "Kurzy",
                        columnNames,
                        columnNames
                    )
            in
                out,
    documentation = [
        Documentation.Name = " get-ExchangeRatesOfCZK.pq ",
        Documentation.Description = " Returns Table of Exchange rate of all currencies from ČNB to CZK ",
        Documentation.Source = " https://www.jaknapowerbi.cz ",
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