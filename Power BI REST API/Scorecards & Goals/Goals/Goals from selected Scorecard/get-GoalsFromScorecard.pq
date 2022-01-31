let
    output =
        (generatedToken as text, workspaceId as text, scorecardId as text) =>
            let
                apiCall =
                    Json.Document(
                        Web.Contents(
                            "https://api.powerbi.com/v1.0/myorg",
                            [
                                RelativePath = "groups/" & workspaceId & "/scorecards/" & scorecardId & "/goals",
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
                        name = text,
                        scorecardId = text,
                        lastModifiedBy = text,
                        createdTime = datetime,
                        owner = text,
                        unit = text,
                        lastModifiedTime = datetime,
                        startDate = datetime,
                        completionDate = datetime,
                        valueConnection = record,
                        notesCount = text,
                        valuesFormatString = text,
                        permissions = text,
                        level = text,
                        rank = text,
                        additionalOwners = list
                    ],
                    List.Transform(
                        apiCall[value],
                        each
                            {
                                _[id]?,
                                _[name]?,
                                _[scorecardId]?,
                                _[lastModifiedBy]?,
                                _[createdTime]?,
                                _[owner]?,
                                _[unit]?,
                                _[lastModifiedTime]?,
                                _[startDate]?,
                                _[completionDate]?,
                                _[valueConnection]?,
                                _[notesCount]?,
                                _[valuesFormatString]?,
                                _[permissions]?,
                                _[level]?,
                                _[rank]?,
                                _[additionalOwners]?
                            }
                    )
                ),
    documentation = [
        Documentation.Name = " get-GoalsFromScorecard.pq ",
        Documentation.Description = " Get goals from a scorecard by its ID ",
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