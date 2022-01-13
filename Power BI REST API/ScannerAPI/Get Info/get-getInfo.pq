let
    output =
        (generatedToken as text, workspaces as text) =>
            let
                apiCall =
                    Json.Document(
                        Web.Contents(
                            "https://api.powerbi.com/v1.0/myorg/",
                            [
                                RelativePath = "admin/workspaces/getInfo",
                                Headers = [
                                    #"Content-Type" = "application/json",
                                    Authorization = generatedToken
                                ],
                                Content =
                                    Text.ToBinary(
                                        "{ ""workspaces"": [ """
                                        & workspaces
                                        & """]}"
                                    )
                            ]
                        )
                    )
            in
                apiCall[id]?,
    documentation = [
        Documentation.Name = " get-getInfo.pq ",
        Documentation.Description = " Call for INPUTED ID of Workspaces getInfo API function. ",
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