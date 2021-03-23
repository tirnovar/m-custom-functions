let
    output =
        () =>
            let
                Source = Json.Document(Web.Contents("https://restcountries.eu/rest/v2/all")),
                tbl =
                    Table.FromList(
                        Source,
                        Splitter.SplitByNothing(),
                        null,
                        null,
                        ExtraValues.Error
                    ),
                list_of_names = Record.FieldNames(tbl[Column1]{0}),
                expand =
                    Table.ExpandRecordColumn(
                        tbl,
                        "Column1",
                        list_of_names,
                        list_of_names
                    )
            in
                expand,
    documentation = [
        Documentation.Name = " get-AllWorldCountriesWithDetails.pq ",
        Documentation.Description = " Return list of Countries in the world with details as Catipal, Phone, Area, Languages, CurrencyCode etc. ",
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