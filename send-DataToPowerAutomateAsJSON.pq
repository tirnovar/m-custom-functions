let
    output =
        (link as text, JSONcontent as text) as text =>
            let
                URL = link,
                headers = [
                    #"Content-Type" = "application/json"
                ],
                send = {
                    (
                        Web.Contents(
                            URL,
                            [
                                Headers = headers,
                                Content = Text.ToBinary(JSONcontent)
                            ]
                        )
                    )
                },
                tbl =
                    Table.AddColumn(
                        Table.FromList(
                            send,
                            Splitter.SplitByNothing(),
                            null,
                            null,
                            ExtraValues.Error
                        ),
                        "send",
                        each
                            if [Column1] is binary then
                                "Sent"
                            else
                                "Something happened"
                    )
            in
                tbl{0}[send],
    documentation = [
        Documentation.Name = " send-DataToPowerAutomateAsJSON.pq ",
        Documentation.Description = " Sending JSON structured data to Power Automate HTTP endpoint and returning TEXT value Send or Something happened",
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