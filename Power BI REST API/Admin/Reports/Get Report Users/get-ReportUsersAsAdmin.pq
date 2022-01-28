let
    output =
        (generatedToken as text, reportId as text) =>
            let
                apiCall =
                    Json.Document(
                        Web.Contents(
                            "https://api.powerbi.com/v1.0/myorg",
                            [
                                RelativePath = "admin/reports/" & reportId & "/users",
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
                        reportUerAccessRight = text,
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
                                _[reportUerAccessRight]?,
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
        Documentation.Name = " get-ReportUsersAsAdmin.pq ",
        Documentation.Description = " Get all users that has access into reports ",
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