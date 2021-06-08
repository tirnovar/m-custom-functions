let
    output =
        (jiraTableApiURL as text,maxResFull as text,maxRespart as text) as table =>
            let
                //https://domain.atlassian.net
                totalCounter =
                    Json.Document(
                        Web.Contents(
                            "https://domain.atlassian.net",
                            [
                                RelativePath=jiraTableApiURL,
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
                            {1..Number.RoundUp(totalCounter / maxRespart)},
                            each
                                {
                                    _,
                                    Json.Document(
                                        Web.Contents(
                                            "https://domain.atlassian.net",
                                            [
                                                RelativePath=jiraTableApiURL,
                                                Query=[
                                                    startAt=Text.From(((_ - 1) * maxRespart)),
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
        Documentation.Description = " Getting all data of issues from JIRA CLOUD. For Authentication you need to use BASIC Authorization with your JIRA Email and generate API-Token as password. Generate API-Token is possible on https://id.atlassian.com/manage-profile/security ",
        Documentation.Source = "https://www.jaknapowerbi.cz",
        Documentation.Version = " 1.0 ",
        Documentation.Author = " Štěpán Rešl ",
        Documentation.Examples = {
            [
                Description = " Before using this function you have to change https://domain.atlassion.net to your DOMAIN ",
                Code = " Input: ""rest/api/3/search"", ""1"",""100"" ",
                Result = "#table"
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