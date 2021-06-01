let
    output =
        (tableName as text,maxResFull as text,maxRespart as text) as table =>
            let
                //https://domain.atlassian.net
                totalCounter =
                    Json.Document(
                        Web.Contents(
                            "https://domain.atlassian.net",
                            [
                                RelativePath=tableName,
                                Query=[maxResults=maxResFull]
                            ]
                        )
                    )
                        [total],
                tbl =
                    #table(
                        type table [
                            pageCounter = Int64.Type,
                            JIRA = record
                        ],
                        List.Transform(
                            {1..Number.RoundUp(totalCounter / 100)},
                            each
                                {
                                    _,
                                    Json.Document(
                                        Web.Contents(
                                            "https://domain.atlassian.net",
                                            [
                                                RelativePath=tableName,
                                                Query=[
                                                    startAt=Text.From(((_ - 1) * 100)),
                                                    maxResults=maxRespart
                                                    ]
                                            ]
                                        )
                                    )
                                }
                        )
                    )
            in
                tbl,
    documentation = [
        Documentation.Name = " get-ServiceDeskIssuesDataFromJiraCloud.pq ",
        Documentation.Description = " Getting all data of issues from JIRA CLOUD ",
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