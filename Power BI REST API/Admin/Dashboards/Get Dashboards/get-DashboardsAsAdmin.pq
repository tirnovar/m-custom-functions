let
    output =
        (generatedToken as text) =>
            let
                apiCall =
                    Json.Document(
                        Web.Contents(
                            "https://api.powerbi.com/v1.0/myorg/admin",
                            [
                                RelativePath = "dashboards",
                                Headers = [
                                    #"Content-Type" = "application/json",
                                    Authorization = generatedToken
                                ]
                            ]
                        )
                    )
            in
                #table(
                    type table [
                        id = text,
                        displayName = text,
                        isReadOnly = logical,
                        webUrl = text,
                        embedUrl = text,
                        subscriptions = list
                    ],
                    List.Transform(
                        apiCall[value],
                        each
                            {
                                _[id]?,
                                _[displayName]?,
                                _[isReadOnly]?,
                                _[webUrl]?,
                                _[embedUrl]?,
                                _[subscriptions]?
                            }
                    )
                ),
    documentation = [
        Documentation.Name = " get-DashboardsAsAdmin.pq ",
        Documentation.Description = " Get all dashboards as Admin ",
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