let
    output =
        (url as text) as table =>
            let
                jiraUrl = url,
                //https://domain.atlassian.net
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
                            jiraExport = table
                        ],
                        List.Transform(
                            {1..Number.RoundUp(totalCounter / 100)},
                            each
                                {
                                    _,
                                    Json.Document(
                                        Web.Contents(
                                            jiraUrl
                                            & "/rest/api/3/search?startAt="
                                            & Text.From(((_ - 1) * 100))
                                            & "&maxResults=99"
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