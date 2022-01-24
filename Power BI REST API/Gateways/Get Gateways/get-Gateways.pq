let
    output =
        (userToken as text) =>
            let
                apiCall =
                    Json.Document(
                        Web.Contents(
                            "https://api.powerbi.com/v2.0/myorg",
                            [
                                RelativePath = "gatewayclusters?$expand=permissions,memberGateways&$skip=0",
                                Headers = [
                                    #"Content-Type" = "application/json",
                                    Authorization = userToken
                                ]
                            ]
                        )
                    )
            in
                #table(
                    type table [
                        id = text,
                        name = text,
                        #"type" = text,
                        loadBalacingSettings = list,
                        options = record,
                        staticCapabilitis = text,
                        permissions = list,
                        memberGateways = list,
                        datasources = list,
                        maxPermission = record
                    ],
                    List.Transform(
                        apiCall[value],
                        each
                            {
                                _[id]?,
                                _[name]?,
                                _[#"type"]?,
                                _[loadBalacingSettings]?,
                                _[options]?,
                                _[staticCapabilitis]?,
                                _[permissions]?,
                                _[memberGateways]?,
                                _[datasources]?,
                                _[maxPermission]?
                            }
                    )
                ),
    documentation = [
        Documentation.Name = " get-Gateways.pq ",
        Documentation.Description = " Get all data gateways in tenant ",
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