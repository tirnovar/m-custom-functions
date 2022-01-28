let
    output =
        (generatedToken as text, workspaceId as text) =>
            let
                apiCall =
                    Json.Document(
                        Web.Contents(
                            "https://api.powerbi.com/v1.0/myorg",
                            [
                                RelativePath = "admin/groups/" & workspaceId & "/dashboards",
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
                        subscriptions = list,
                        tiles = table
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
                                _[subscriptions]?,
                                getDashboardTilesAsAdmin(
                                    generatedToken,
                                    _[id]?
                                )
                            }
                    )
                ),
    documentation = [
        Documentation.Name = " get-DashboardsFromWorkspaceWithTilesAsAdmin.pq ",
        Documentation.Description = " Get all tiles of dashboard as Admin ",
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