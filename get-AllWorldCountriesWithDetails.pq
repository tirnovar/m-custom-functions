let
    output =
        () as table =>
            let
                Source =
                    Csv.Document(
                        Web.Contents("http://download.geonames.org/export/dump/countryInfo.txt"),
                        [
                            Delimiter = "	",
                            Columns = 19,
                            Encoding = 65001,
                            QuoteStyle = QuoteStyle.None
                        ]
                    ),
                #"Filtered Rows" =
                    Table.SelectRows(
                        Source,
                        each ([Column2] <> "")
                    ),
                #"Promoted Headers" =
                    Table.PromoteHeaders(
                        #"Filtered Rows",
                        [PromoteAllScalars = true]
                    ),
                #"Changed Type" =
                    Table.TransformColumnTypes(
                        #"Promoted Headers",
                        {
                            {
                                "#ISO",
                                type text
                            },
                            {
                                "ISO3",
                                type text
                            },
                            {
                                "ISO-Numeric",
                                Int64.Type
                            },
                            {
                                "fips",
                                type text
                            },
                            {
                                "Country",
                                type text
                            },
                            {
                                "Capital",
                                type text
                            },
                            {
                                "Area(in sq km)",
                                type number
                            },
                            {
                                "Population",
                                Int64.Type
                            },
                            {
                                "Continent",
                                type text
                            },
                            {
                                "tld",
                                type text
                            },
                            {
                                "CurrencyCode",
                                type text
                            },
                            {
                                "CurrencyName",
                                type text
                            },
                            {
                                "Phone",
                                type text
                            },
                            {
                                "Postal Code Format",
                                type text
                            },
                            {
                                "Postal Code Regex",
                                type text
                            },
                            {
                                "Languages",
                                type text
                            },
                            {
                                "geonameid",
                                Int64.Type
                            },
                            {
                                "neighbours",
                                type text
                            },
                            {
                                "EquivalentFipsCode",
                                type text
                            }
                        }
                    )
            in
                #"Changed Type",
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