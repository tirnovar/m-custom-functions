let
    output =
        () as table =>
            let
                web = Web.Contents("https://docs.microsoft.com/openspecs/office_standards/ms-oe376/6c085406-a698-4e12-9d4d-c3b0ee3dbc4a"),
                getTable =
                    Html.Table(
                        web,
                        {
                            {
                                "Language Code",
                                "TABLE > TBODY > TR > :nth-child(1)"
                            },
                            {
                                "Description (informative)",
                                "TABLE > TBODY > TR > :nth-child(2)"
                            },
                            {
                                "BCP 47 Code",
                                "TABLE > TBODY > TR > :nth-child(3)"
                            }
                        },
                        [RowSelector = "TABLE > TBODY > TR"]
                    ),
                out = Table.RemoveLastN(getTable, 1)
            in
                out,
    documentation = [
        Documentation.Name = " get-TableOfLanguages.pq ",
        Documentation.Description = " Get a table with all defined languages and their short codes. ",
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