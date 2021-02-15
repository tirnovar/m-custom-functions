let
    output =
        (tbl as table, columnToCumulation as text, categoryColumn as text, dateColumn as text, tableCategoryColumn as text, tableDateColumn as date) as number =>
            let
                getTable =
                    Table.Buffer(
                        Table.RenameColumns(
                            tbl,
                            {
                                {
                                    columnToCumulation,
                                    "cumul"
                                },
                                {
                                    categoryColumn,
                                    "category"
                                },
                                {
                                    dateColumn,
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
        Documentation.Description = " Trasform full table into one JSON as Text ",
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