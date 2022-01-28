let
    output =
        (generatedToken as text, AppId as text) =>
            let
                apiCall =
                    Json.Document(
                        Web.Contents(
                            "https://api.powerbi.com/v1.0/myorg",
                            [
                                RelativePath = "admin/apps/" & AppId & "/users",
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
                        AppUserAccessRight = text,
                        displayName = text,
                        emailAddress = text,
                        graphId = text,
                        identifier = text,
                        principalType = text
                    ],
                    List.Transform(
                        apiCall[value],
                        each
                            {
                                _[AppUserAccessRight]?,
                                _[displayName]?,
                                _[emailAddress]?,
                                _[graphId]?,
                                _[identifier]?,
                                _[principalType]?
                            }
                    )
                ),
    documentation = [
        Documentation.Name = " get-AppUserAsAdmin.pq ",
        Documentation.Description = " Get All Users of the App ",
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