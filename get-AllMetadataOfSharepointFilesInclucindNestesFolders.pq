let
    output = (
        domainName as text,
        siteName as text,
        initFolder as text
    ) =>
        let
            shpUrl = "https://"
                & domainName
                & ".sharepoint.com/sites/"
                & siteName,
            sharePointCaller = SharePoint.Files(
                shpUrl,
                [
                    ApiVersion = 15
                ]
            ),
            filterOnInitFolder = Table.SelectRows(
                sharePointCaller,
                each
                    Text.Contains(
                        [
                            Folder Path
                        ],
                        initFolder
                    )
            )[
                [
                    #"Folder Path"
                ],
                [
                    Name
                ]
            ],
            delimiterCreator = Table.AddColumn(
                filterOnInitFolder,
                "caller",
                each
                    "'"
                        & Text.AfterDelimiter(
                            [
                                Folder Path
                            ],
                            "/"
                                & siteName
                                & "/"
                        )
                        & "'"
            ),
            out = Table.AddColumn(
                delimiterCreator,
                "metadata",
                each
                    let
                        call = [
                            caller
                        ],
                        nm = [
                            Name
                        ],
                        uri = shpUrl
                    in
                        Json.Document(
                            Web.Contents(
                                uri,
                                [
                                    RelativePath = "_api/web/GetFolderByServerRelativeUrl("
                                        & call
                                        & ")/Files('"
                                        & nm
                                        & "')/ListItemAllFields",
                                    Headers = [
                                        Accept = "application/json;odata=verbose",
                                        #"Content-Type" = "application/json"
                                    ]
                                ]
                            )
                        )[
                            d
                        ]
            )
        in
            out,
        documentation = [
        Documentation.Name = " get-AllMetadataOfSharepointFilesInclucindNestesFolders.pq ",
        Documentation.Description = " Returns all metadata from Sharepoint files in a folder and all subfolders. ",
        Documentation.Source = "https://www.jaknapowerbi.cz . ",
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
