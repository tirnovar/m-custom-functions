let
    output =
        (generatedToken as text, optional topCount as number) =>
            let
                originTopCounter = 5000,
                counter =
                    if
                        topCount
                        = null
                        or topCount
                        < 0
                        or topCount
                        > originTopCounter
                    then
                        originTopCounter
                    else
                        topCount,
                structure = [
                    RelativePath = "admin/groups",
                    Headers = [
                        #"Content-Type" = "application/json",
                        Authorization = generatedToken
                    ],
                    Query = [
                        #"$expand" = "users,reports,dashboards,datasets,dataflows,workbooks",
                        #"$top" = Text.From(counter)
                    ]
                ],
                apiCall =
                    Json.Document(
                        Web.Contents(
                            "https://api.powerbi.com/v1.0/myorg",
                            structure
                        )
                    )
            in
                #table(
                    type table [
                        id = text,
                        isReadOnly = logical,
                        isOnDedicatedCapacity = logical,
                        capacityId = text,
                        capacityMigrationStatus = text,
                        #"type" = text,
                        state = text,
                        name = text,
                        users = list,
                        reports = list,
                        dashboards = list,
                        datasets = list,
                        dataflows = list,
                        workbooks = list
                    ],
                    List.Transform(
                        apiCall[value],
                        each
                            {
                                _[id]?,
                                _[isReadOnly]?,
                                _[isOnDedicatedCapacity]?,
                                _[capacityId]?,
                                _[capacityMigrationStatus]?,
                                _[#"type"]?,
                                _[state]?,
                                _[name]?,
                                _[users]?,
                                _[reports]?,
                                _[dashboards]?,
                                _[datasets]?,
                                _[dataflows]?,
                                _[workbooks]?
                            }
                    )
                ),
    documentation = [
        Documentation.Name = " get-GroupsAsAdmin.pq ",
        Documentation.Description = " Get Groups in Power BI Service as Admin. (You will recieve max to 5000 groups. If you didnt input TOP number, then call will be on first 5000) ",
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