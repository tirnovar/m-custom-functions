let
    output =
        (tbl as table, columnToCumulationName as text, categoryColumnName as text, dateColumnName as text, tableCategoryColumn as text, tableDateColumn as date) as number =>
            let
                getTable =
                    Table.Buffer(
                        Table.RenameColumns(
                            tbl,
                            {
                                {
                                    columnToCumulationName,
                                    "cumul"
                                },
                                {
                                    categoryColumnName,
                                    "category"
                                },
                                {
                                    dateColumnName,
                                    "dateKey"
                                }
                            }
                        )
                    ),
                calculator =
                    List.Sum(
                        List.Transform(
                            List.Select(
                                Table.ToRecords(getTable),
                                each
                                    _[category]
                                    = tableCategoryColumn
                                    and _[dateKey]
                                    <= tableDateColumn
                            ),
                            each _[cumul]
                        )
                    )
            in
                calculator,
    documentation = [
        Documentation.Name = " get-CumulatedValueByCategoryAndPreviousDates.pq ",
        Documentation.Description = " Return cumulated summary by specific category and previous dates. This function required Table, String names of columns: {Cumulation, Category, Date}, and Columns thats will be used as Category and DateKey",
        Documentation.Source = "https://www.jaknapowerbi.cz . ",
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