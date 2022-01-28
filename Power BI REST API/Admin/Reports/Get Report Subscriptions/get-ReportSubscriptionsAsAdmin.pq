let
    output =
        (generatedToken as text, reportId as text) =>
            let
                apiCall =
                    Json.Document(
                        Web.Contents(
                            "https://api.powerbi.com/v1.0/myorg",
                            [
                                RelativePath = "admin/reports/" & reportId & "/subscriptions",
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
                        title = text,
                        artifactId = text,
                        artifactDislayName = text,
                        subArtifactDisplayName = text,
                        artifactType = text,
                        isEnabled = logical,
                        frequency = text,
                        startDate = datetime,
                        endDate = datetime,
                        linkToContent = logical,
                        previewImage = logical,
                        attachmentFormat = text,
                        users = list
                    ],
                    List.Transform(
                        apiCall[value],
                        each
                            {
                                _[id]?,
                                _[tite]?,
                                _[artifactId]?,
                                _[artifactDislayName]?,
                                _[subArtifactDisplayName]?,
                                _[artifactType]?,
                                _[isEnabled]?,
                                _[frequency]?,
                                _[startDate]?,
                                _[endDate]?,
                                _[linkToContent]?,
                                _[previewImage]?,
                                _[attachmentFormat]?,
                                _[users]?
                            }
                    )
                ),
    documentation = [
        Documentation.Name = " get-ReportSubscriptonsAsAdmin.pq ",
        Documentation.Description = " Get all subscriptions to report ",
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