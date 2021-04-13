let
    output =
        (client as text, secret as text) as text =>
            let
                urlW = "https://login.storyous.com/api/auth/authorize",
                header = [
                    #"Content-Type" = "application/x-www-form-urlencoded"
                ],
                secretW = secret,
                clientW = client,
                content =
                    "client_id="
                    & clientW
                    & "&client_secret="
                    & secretW
                    & "&grant_type=client_credentials",
                call =
                    Json.Document(
                        Web.Contents(
                            urlW,
                            [
                                Headers = header,
                                Content = Text.ToBinary(content)
                            ]
                        )
                    ),
                Bearer =
                    Record.Field(call, "token_type")
                    & " "
                    & Record.Field(call, "access_token")
            in
                Bearer,
    documentation = [
        Documentation.Name = " get-StoryousDataOfMarketPlaceBillsByAPI.pq ",
        Documentation.Description = " Getting Storious API Key for next functions as get-StoryousDataOfMarketPlaceBillsByAPI.pq ",
        Documentation.Source = "https://www.jaknapowerbi.cz",
        Documentation.Version = " 1.0 ",
        Documentation.Author = " Štěpán Rešl ",
        Documentation.Examples = {
            [
                Description = " Input: clientID, clientSecret ",
                Code = "",
                Result = ""
            ]
        }
    ]
in
    Value.ReplaceType(
        output,
        Value.ReplaceMetadata(
            Value.Type(output),
            documentation
        )
    )