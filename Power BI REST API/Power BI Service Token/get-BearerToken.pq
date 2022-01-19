let
    output =
        (AzureADTenantID as text, AzureApplicationClientSecret as text, AzureApplicationClientID as text) as text =>
            let
                token_uri =
                    "https://login.windows.net/"
                    & AzureADTenantID
                    & "/oauth2/token",
                resource = "https://analysis.windows.net/powerbi/api",
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
                token_output =
                    tokenResponse[token_type]
                    & " "
                    & tokenResponse[access_token]
            in
                token_output,
    documentation = [
        Documentation.Name = " get-BearerToken.pq ",
        Documentation.Description = " Get Bearer Token needed for Power BI REST API calls ",
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