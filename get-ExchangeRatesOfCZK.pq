let
    fct =
        (startYear as number, endYear as number) =>
            let
                csvExtaction =
                    (fl as binary) =>
                        Csv.Document(
                            fl,
                            [
                                Delimiter = "|",
                                Encoding = 65001,
                                QuoteStyle = QuoteStyle.None
                            ]
                        ),
                transformator =
                    List.Transform(
                        {startYear..endYear},
                        each
                            let
                                caller =
                                    Web.Contents(
                                        "https://www.cnb.cz",
                                        [
                                            RelativePath = "cs/financni-trhy/devizovy-trh/kurzy-devizoveho-trhu/kurzy-devizoveho-trhu/rok.txt",
                                            Query = [
                                                rok = Text.From(_)
                                            ]
                                        ]
                                    ),
                                extract = Table.PromoteHeaders(csvExtaction(caller))
                            in
                                extract
                    )
            in
                Table.Combine(transformator)
in
    fct