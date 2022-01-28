let
    output =
        (generatedToken as text, scanId as text) =>
            let
                apiCall =
                    Json.Document(
                        Web.Contents(
                            "https://api.powerbi.com/v1.0/myorg",
                            [
                                RelativePath = "admin/workspaces/scanStatus/" & scanId,
                                Headers = [
                                    #"Content-Type" = "application/json",
                                    Authorization = generatedToken
                                ]
                            ]
                        )
                    )
            in
                Table.FromRecords(
                    {apiCall},
                    type table [
                        id = text,
                        createdDateTime = datetime,
                        status = text
                    ]
                ),
    documentation = [
        Documentation.Name = " get-ScanStatus.pq ",
        Documentation.Description = " Get status of called scan by functon get-getInfo ",
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