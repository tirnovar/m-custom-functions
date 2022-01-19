let
    output =
        (AzureADTenantID as text, AzureApplicationClientSecret as text, AzureApplicationClientID as text) as text =>
            let
                out =
                    let
                        token_uri =
                            "https://login.windows.net/"
                            & AzureADTenantID
                            & "/oauth2/token",
                        resource = "https://graph.microsoft.com",
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
                                                        resource = resource,
                                                        grant_type = "client_credentials",
                                                        client_secret = AzureApplicationClientSecret
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
                        access_token =
                            tokenResponse[token_type]
                            & " "
                            & tokenResponse[access_token]
                    in
                        access_token
            in
                out,
    documentation = [
        Documentation.Name = " get-GraphBearerToken.pq ",
        Documentation.Description = " Getting access token from Microsoft Graph API",
        Documentation.Source = "https://www.jaknapowerbi.cz",
        Documentation.Version = " 1.0 ",
        Documentation.Author = " Štěpán Rešl ",
        Documentation.Examples = {
            [
                Description = " All Data Credentials have to be ""Anonymous"" ",
                Code = " Input: AzureADTenantID = 00000000-aaaa-bbb0-ccc2-121212121212, AzureApplicationClientID = 00000000-aaaa-bbb0-ccc2-121212121212, AzureApplicationClientSecret = PPPSssssssst1________.__. "
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