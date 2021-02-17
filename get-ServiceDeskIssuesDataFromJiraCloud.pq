let
    output =
        (url as text) as table =>
            let
                jiraUrl = url,
                totalCounter =
                    Json.Document(
                        Web.Contents(
                            jiraUrl
                            & "/rest/api/3/search?maxResults=500"
                        )
                    )
                        [total],
                tbl =
                    #table(
                        type table [
                            pageCounter = Int64.Type,
                            jiraExport = list
                        ],
                        List.Transform(
                            {1..Number.RoundUp(totalCounter / 100)},
                            each
                                {
                                    _,
                                    Record.Field(
                                        Json.Document(
                                            Web.Contents(
                                                jiraUrl
                                                & "/rest/api/3/search?startAt="
                                                & Text.From(((_ - 1) * 100))
                                                & "&maxResults=99"
                                            )
                                        ),
                                        "issues"
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
        Documentation.Author = " Štěpán Rešl ",
        Documentation.Examples = {
            [
                Description = " Input: https://domain.atlassian.net ",
                Code = "",
                Result = "[1,2,3][table,table,table]"
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