let
    output =
        (AzureADTenantID as text, AzureApplicationClientSecret as text, AzureApplicationClientID as text, Token as text) =>
            let
                token_uri =
                    "https://login.windows.net/"
                    & AzureADTenantID
                    & "/oauth2/v2.0/token",
                tokenResponse =
                    Json.Document(
                        Web.Contents(
                            token_uri,
                            [
                                Content =
                                    Text.ToBinary(
                                        Uri.BuildQueryString(
                                            [
                                                client_id = AzureApplicationClientID,
                                                scope = "https://analysis.windows.net/powerbi/api/.default",
                                                grant_type = "refresh_token",
                                                client_secret = AzureApplicationClientSecret,
                                                refresh_token = Token,
                                                redicrect_uri = "http://localhost:8080"
                                            ]
                                        )
                                    ),
                                Headers = [
                                    Accept = "application/json"
                                ],
                                ManualStatusHandling = {
                                    400
                                }
                            ]
                        )
                    ),
                token_result =
                    tokenResponse[token_type]
                    & " "
                    & tokenResponse[access_token]
            in
                token_result,
    documentation = [
        Documentation.Name = " get-UserToken.pq ",
        Documentation.Description = " Get User Token by exchanging the refresh token ",
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