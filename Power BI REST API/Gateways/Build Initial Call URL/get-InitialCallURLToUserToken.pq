let
    output =
        (AzureADTenantID as text, AzureApplicationClientID as text) as text =>
            let
                scope = "https://analysis.windows.net/powerbi/api/.default",
                token_uri =
                    "https://login.microsoftonline.com/"
                    & AzureADTenantID
                    & "/oauth2/v2.0/authorize?client_id="
                    & AzureApplicationClientID
                    & "&response_type=code&redirect_uri=http://localhost:8080&response_mode=query&scope="
                    & scope
                    & " offline_access&state=1234",
                tokenResponse =
                    Json.Document(
                        Web.Contents(
                            token_uri,
                            [
                                Headers = [
                                    Accept = "application/json"
                                ],
                                ManualStatusHandling = {
                                    400
                                }
                            ]
                        )
                    )
            in
                token_uri,
    documentation = [
        Documentation.Name = " get-InitialCallURLToUserToken.pq ",
        Documentation.Description = " Prepare the URL to call to get the user token ",
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