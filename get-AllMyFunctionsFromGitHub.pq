let
    output =
        () as table =>
            let
                out = Web.Contents("https://github.com/tirnovar/m-custom-functions"),
                #"Extracted Table From Html" =
                    Html.Table(
                        out,
                        {
                            {
                                "Method",
                                "TD:nth-child(1)"
                            },
                            {
                                "Name",
                                "TD:nth-child(2)"
                            },
                            {
                                "Detail",
                                "TD:nth-child(3)"
                            },
                            {
                                "Language",
                                "TD:nth-child(4)"
                            },
                            {
                                "Url",
                                "TD:nth-child(2) > A:nth-child(1):nth-last-child(1)",
                                each [Attributes][href]?
                            }
                        },
                        [RowSelector = "TBODY TR"]
                    ),
                #"Replaced Value" =
                    Table.ReplaceValue(
                        #"Extracted Table From Html",
                        "github.com",
                        "raw.githubusercontent.com",
                        Replacer.ReplaceText,
                        {"Url"}
                    ),
                #"Replaced Value1" =
                    Table.ReplaceValue(
                        #"Replaced Value",
                        "/blob",
                        "",
                        Replacer.ReplaceText,
                        {"Url"}
                    ),
                #"Added Custom" =
                    Table.AddColumn(
                        #"Replaced Value1",
                        "Function",
                        each
                            Expression.Evaluate(
                                Text.FromBinary(Binary.Buffer(Web.Contents([Url]))),
                                #shared
                            )
                    )
            in
                #"Added Custom",
            documentation = [
        Documentation.Name = " get-AllMyFunctionsFromGitHub.pq ",
        Documentation.Description = " Add all functions from tirnovar repository m-custom-function into your Power BI ",
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