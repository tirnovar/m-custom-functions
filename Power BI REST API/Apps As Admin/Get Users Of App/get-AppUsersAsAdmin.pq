let
    output =
        (generatedToken as text,AppId as text) =>
            let
                apiCall =
                    Json.Document(
                        Web.Contents(
                            "https://api.powerbi.com/v1.0/myorg/admin",
                            [
                                RelativePath = "apps/" & AppId & "/users",
                                Headers = [
                                    #"Content-Type" = "application/json",
                                    Authorization = generatedToken
                                ]
                            ]
                        )
                    )
            in
                #table(
                    type table [displayName=text, emailAddress=text, appUserAccessRight=text, identifier=text, principalType=text],
                    List.Transform(apiCall[value], each
                        {
                            _[displayName]?,
                            _[emailAddress]?,
                            _[appUserAccessRight]?,
                            _[identifier]?,
                            _[pricipalType]?
                        })
                ),
    documentation = [
        Documentation.Name = " get-BearerToken.pq ",
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