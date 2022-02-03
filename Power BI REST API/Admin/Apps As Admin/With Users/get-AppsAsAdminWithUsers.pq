let
    output =
        (generatedToken as text, optional topApps as number) =>
            let
                topAppsCounter =
                    if topApps = null then
                        "100"
                    else
                        Text.From(topApps),
                apiCall =
                    Json.Document(
                        Web.Contents(
                            "https://api.powerbi.com/v1.0/myorg",
                            [
                                RelativePath = "admin/apps",
                                Query = [
                                    #"$top" = topAppsCounter
                                ],
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
                        name = text,
                        lastUpdate = datetime,
                        description = text,
                        publishedBy = text,
                        workspaceId = text,
                        users = table
                    ],
                    List.Transform(
                        apiCall[value],
                        each
                            {
                                _[id]?,
                                _[name]?,
                                DateTime.From(_[lastUpdate]?),
                                _[description]?,
                                _[publishedBy]?,
                                _[workspaceId]?,
                                get-AppUsersAsAdmin(generatedToken, _[id]?)
                            }
                    )
                ),
    documentation = [
        Documentation.Name = " get-AppsAsAdminWithUsers.pq ",
        Documentation.Description = " Get Apps as an Admin if you didnt input topApps count, then this call with return TOP 100 apps. ",
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