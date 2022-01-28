let
    output =
        (generatedToken as text) =>
            let
                apiCall =
                    Json.Document(
                        Web.Contents(
                            "https://api.powerbi.com/v1.0/myorg",
                            [
                                RelativePath = "admin/capacities",
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
                        id = text,
                        displayName = text,
                        admins = list,
                        sku = text,
                        state = text,
                        region = text,
                        capacityUserAccessRight = text,
                        tenantKeyId = text
                    ],
                    List.Transform(
                        apiCall[value],
                        each
                            {
                                _[id]?,
                                _[displayName]?,
                                _[admins]?,
                                _[sku]?,
                                _[state]?,
                                _[region]?,
                                _[capacityUserAccessRight]?,
                                _[tenantKeyId]?
                            }
                    )
                ),
    documentation = [
        Documentation.Name = " get-Capacities.pq ",
        Documentation.Description = " Get all capacities in tenant ",
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