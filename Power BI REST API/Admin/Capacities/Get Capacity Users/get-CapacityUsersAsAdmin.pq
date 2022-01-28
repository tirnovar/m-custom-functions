let
    output =
        (generatedToken as text,capacity as text) =>
            let
                apiCall =
                    Json.Document(
                        Web.Contents(
                            "https://api.powerbi.com/v1.0/myorg",
                            [
                                RelativePath = "admin/capacities/" & capacity & "/users",
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
                        capacityUserAccessRight = text,
                        emailAddress = text,
                        displayName = text,
                        identifier = text,
                        graphId = text,
                        principalType = text,
                        userType = text
                    ],
                    List.Transform(
                        apiCall[value],
                        each
                            {
                                _[capacityUserAccessRight]?,
                                _[emailAddress]?,
                                _[displayName]?,
                                _[identifier]?,
                                _[graphId]?,
                                _[principalType]?,
                                _[userType]?
                            }
                    )
                ),
    documentation = [
        Documentation.Name = " get-getCapacityUsersAsAdmin.pq ",
        Documentation.Description = " Get all users of selected capacity. ",
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