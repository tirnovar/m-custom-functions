let
    output = (xslxBinary as binary, optional searchedColor as text, optional notSearchedColor as text) =>
        let
            /* UNZIP FUNCTION FROM MARK WHITE
     LINK TO ARTICLE WITH CODE http://sql10.blogspot.com/2016/06/reading-zip-files-in-powerquery-m.html */
            unZipOfXLSX = (xlsxFile as binary) =>
                let
                    Header = BinaryFormat.Record(
                        [
                            MiscHeader = BinaryFormat.Binary(14),
                            BinarySize = BinaryFormat.ByteOrder(
                                BinaryFormat.UnsignedInteger32, ByteOrder.LittleEndian
                            ),
                            FileSize = BinaryFormat.ByteOrder(BinaryFormat.UnsignedInteger32, ByteOrder.LittleEndian),
                            FileNameLen = BinaryFormat.ByteOrder(
                                BinaryFormat.UnsignedInteger16, ByteOrder.LittleEndian
                            ),
                            ExtrasLen = BinaryFormat.ByteOrder(
                                BinaryFormat.UnsignedInteger16, ByteOrder.LittleEndian
                            )
                        ]
                    ),
                    HeaderChoice = BinaryFormat.Choice(
                        BinaryFormat.ByteOrder(BinaryFormat.UnsignedInteger32, ByteOrder.LittleEndian),
                        each
                            if _ <> 67324752
                            // not the IsValid number? then return a dummy formatter
                            then
                                BinaryFormat.Record([IsValid = false, Filename = null, Content = null])
                            else
                                BinaryFormat.Choice(
                                    BinaryFormat.Binary(26),
                                    // Header payload – 14+4+4+2+2
                                    each
                                        BinaryFormat.Record(
                                            [
                                                IsValid = true,
                                                Filename = BinaryFormat.Text(Header(_)[FileNameLen]),
                                                Extras = BinaryFormat.Text(Header(_)[ExtrasLen]),
                                                Content = BinaryFormat.Transform(
                                                    BinaryFormat.Binary(Header(_)[BinarySize]),
                                                    (x) =>
                                                        try
                                                            Binary.Buffer(Binary.Decompress(x, Compression.Deflate))
                                                        otherwise
                                                            null
                                                )
                                            ]
                                        ),
                                    type binary
                                    // enable streaming
                                )
                    ),
                    ZipFormat = BinaryFormat.List(HeaderChoice, each _[IsValid] = true),
                    Entries = List.Transform(
                        List.RemoveLastN(ZipFormat(xlsxFile), 1),
                        (e) => [FileName = e[Filename], Content = e[Content]]
                    )
                in
                    Table.FromRecords(Entries),
            // END OF MARK WHITE's UNZIP FUNCTION //
            // Suport Functions //
            themeColors = (themeBinary as binary) =>
                let
                    schemaColorList =
                        let
                            initTbl = Table.Combine(
                                Record.ToList(
                                    Table.RemoveColumns(
                                        Xml.Tables(themeBinary)[themeElements]{0}[clrScheme]{0}, "Attribute:name"
                                    ){
                                        0
                                    }
                                )
                            ),
                            extraction = Table.AddColumn(
                                initTbl,
                                "clrs",
                                each
                                    (
                                        if [sysClr] <> null then
                                            [sysClr]{0}[#"Attribute:lastClr"]
                                        else
                                            [srgbClr]{0}[#"Attribute:val"]
                                    )
                                        & "00"
                            )[clrs]
                        in
                            extraction
                in
                    schemaColorList,
            stylesIDs = (stylesXML as binary, themeColors as list) =>
                let
                    Source = Xml.Tables(stylesXML){[Name = "fills"]}[Table]{0}[fill],
                    expandPatternOfFill = Table.ExpandTableColumn(Source, "patternFill", {"fgColor"}, {"fgColor"}),
                    expandBackGroundColor = Table.ExpandTableColumn(
                        expandPatternOfFill,
                        "fgColor",
                        {"Attribute:indexed", "Attribute:rgb", "Attribute:theme"},
                        {"indexed", "rgb", "theme"}
                    ),
                    indexedColorsList = List.Buffer(
                        Table.ToList(
                            Xml.Tables(
                                stylesXML{[Name = "styles.xml"]}[Content]
                            ){
                                [Name = "colors"]
                            }[Table]{
                                [Name = "indexedColors"]
                            }[Table]{
                                0
                            }[Table]
                        )
                    ),
                    indexCreator = Table.AddIndexColumn(expandBackGroundColor, "Index", 0, 1, Int64.Type),
                    filterForSpecificColor =
                        if searchedColor <> null then
                            let
                                colorSeeker = Table.AddColumn(
                                    indexCreator,
                                    "colorSeeker",
                                    each
                                        try
                                            if [indexed] <> null then
                                                indexedColorsList{Number.From([indexed])}
                                            else if [rgb] <> null then
                                                [rgb]
                                            else
                                                themeColors{Number.From([theme])}
                                            otherwise null
                                )
                            in
                                Table.SelectRows(colorSeeker, each Text.Contains([colorSeeker], searchedColor))
                        else if notSearchedColor <> null then
                            let
                                colorSeeker = Table.AddColumn(
                                    indexCreator,
                                    "colorSeeker",
                                    each
                                        try
                                            if [indexed] <> null then
                                                indexedColorsList{Number.From([indexed])}
                                            else if [rgb] <> null then
                                                [rgb]
                                            else
                                                themeColors{Number.From([theme])}
                                            otherwise null
                                )
                            in
                                Table.SelectRows(
                                    colorSeeker,
                                    each
                                        not Text.Contains([colorSeeker], notSearchedColor) and [colorSeeker] <> null
                                )
                        else
                            let
                                nonNullCounter = Table.AddColumn(
                                    indexCreator,
                                    "counter",
                                    each List.NonNullCount(Record.ToList(Record.RemoveFields(_, "Index")))
                                )
                            in
                                Table.SelectRows(nonNullCounter, each [counter] <> 0)
                in
                    filterForSpecificColor[Index],
            XfsIDs = (stylesXML as binary, listOfStyles as list) =>
                let
                    Source = Xml.Tables(stylesXML){[Name = "cellXfs"]}[Table][xf]{0}[[#"Attribute:fillId"]],
                    indexCreator = List.Transform(
                        Table.SelectRows(
                            Table.AddIndexColumn(Source, "Index", 0, 1, Int64.Type),
                            each List.Contains(listOfStyles, Number.From([#"Attribute:fillId"]))
                        )[Index],
                        each Text.From(_)
                    )
                in
                    indexCreator,
            valueExtract = (workheetBinaries as binary, XfsSearchingIds as list, dt as list) =>
                let
                    sheetExtraction = Xml.Tables(workheetBinaries){[Name = "sheetData"]}[Table][Table]{0}[[c]],
                    expandSheetData = Table.SelectRows(
                        Table.AddColumn(
                            Table.ExpandTableColumn(
                                sheetExtraction,
                                "c",
                                {"v", "Attribute:r", "Attribute:s", "Attribute:t"},
                                {"v", "r", "s", "t"}
                            ),
                            "search",
                            each let s = _[s] in List.Select(XfsSearchingIds, each _ = s){0} ?
                        ),
                        each [search] <> null
                    )[[v], [t], [search], [s], [r]],
                    output = Table.AddColumn(
                        expandSheetData,
                        "val",
                        each
                            if [t] = null then
                                [v]
                            else
                                try dt{Number.From([v])}[#"Element:Text"]{0} otherwise dt{Number.From([v])}
                    )
                in
                    output[[val], [r]],
            sharedStrings = (shString as binary) => let Source = Xml.Tables(shString)[si]{0}[t] in Source,
            //Data Extraction
            unzipingXLSX = unZipOfXLSX(xslxBinary),
            themes = List.Buffer(themeColors(unzipingXLSX{[FileName = "xl/theme/theme1.xml"]}[Content])),
            styles = List.Buffer(stylesIDs(unzipingXLSX{[FileName = "xl/styles.xml"]}[Content], themes)),
            xfs = List.Buffer(XfsIDs(unzipingXLSX{[FileName = "xl/styles.xml"]}[Content], styles)),
            data = List.Buffer(sharedStrings(unzipingXLSX{[FileName = "xl/sharedStrings.xml"]}[Content])),
            extraction =
                let
                    generator = Table.RenameColumns(
                        Table.SelectRows(
                            Table.TransformColumns(
                                Table.SelectRows(unzipingXLSX, each Text.Contains([FileName], "worksheets")),
                                {
                                    {"FileName", each Text.BetweenDelimiters(_, "xl/worksheets/", ".xml")},
                                    {"Content", each valueExtract(_, xfs, data)}
                                }
                            ),
                            each not Table.IsEmpty(_[Content])
                        ),
                        {"FileName", "Sheet"}
                    ),
                    epander = Table.TransformColumnTypes(
                        Table.ExpandTableColumn(generator, "Content", {"val", "r"}, {"Value", "Position"}),
                        {{"Sheet", type text}, {"Value", type text}, {"Position", type text}}
                    )
                in
                    epander
        in
            extraction
in
    output
