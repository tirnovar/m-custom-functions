let
    output =
        (fromYear as number) =>
            let
                year = Text.From(fromYear),
                out =
                    if Text.Length(year) <> 4 then
                        "Vložte hnodnotu roku ve formátu YYYY "
                    else
                        let
                            Zdroj =
                                Web.Contents(
                                    "https://www.czso.cz/",
                                    [RelativePath = "csu/czso/mira_inflace"]
                                ),
                            #"Extrahovaná tabulka z Html" =
                                Html.Table(
                                    Zdroj,
                                    {
                                        {
                                            "Column1",
                                            "TABLE.tabulka:nth-child(11) > * > TR > TH:not([colspan]):not([rowspan]):nth-child(1):nth-last-child(2), TABLE.tabulka:nth-child(11) > * > TR > TH:not([colspan]):not([rowspan]):nth-child(1):nth-last-child(13), TABLE.tabulka:nth-child(11) > * > TR > TD:not([colspan]):not([rowspan]):nth-child(1):nth-last-child(13)"
                                        },
                                        {
                                            "Column2",
                                            "TABLE.tabulka:nth-child(11) > * > TR > TH:not([colspan]):not([rowspan]):nth-child(1):nth-last-child(2) + TH[colspan=""12""]:not([rowspan]):nth-child(2):nth-last-child(1), TABLE.tabulka:nth-child(11) > * > TR > TH:not([colspan]):not([rowspan]):nth-child(1):nth-last-child(13) + TH:not([colspan]):not([rowspan]):nth-child(2):nth-last-child(12), TABLE.tabulka:nth-child(11) > * > TR > TD:not([colspan]):not([rowspan]):nth-child(1):nth-last-child(13) + TD:not([colspan]):not([rowspan]):nth-child(2):nth-last-child(12)"
                                        },
                                        {
                                            "Column3",
                                            "TABLE.tabulka:nth-child(11) > * > TR > TH:not([colspan]):not([rowspan]):nth-child(1):nth-last-child(2) + TH[colspan=""12""]:not([rowspan]):nth-child(2):nth-last-child(1), TABLE.tabulka:nth-child(11) > * > TR > TH:not([colspan]):not([rowspan]):nth-child(1):nth-last-child(13) + TH:not([colspan]):not([rowspan]):nth-child(2):nth-last-child(12) + TH:not([colspan]):not([rowspan]):nth-child(3):nth-last-child(11), TABLE.tabulka:nth-child(11) > * > TR > TD:not([colspan]):not([rowspan]):nth-child(1):nth-last-child(13) + TD:not([colspan]):not([rowspan]):nth-child(2):nth-last-child(12) + TD:not([colspan]):not([rowspan]):nth-child(3):nth-last-child(11)"
                                        },
                                        {
                                            "Column4",
                                            "TABLE.tabulka:nth-child(11) > * > TR > TH:not([colspan]):not([rowspan]):nth-child(1):nth-last-child(2) + TH[colspan=""12""]:not([rowspan]):nth-child(2):nth-last-child(1), TABLE.tabulka:nth-child(11) > * > TR > TH:not([colspan]):not([rowspan]):nth-child(1):nth-last-child(13) + TH:not([colspan]):not([rowspan]):nth-child(2):nth-last-child(12) + TH:not([colspan]):not([rowspan]):nth-child(3):nth-last-child(11) + TH:not([colspan]):not([rowspan]):nth-child(4):nth-last-child(10), TABLE.tabulka:nth-child(11) > * > TR > TD:not([colspan]):not([rowspan]):nth-child(1):nth-last-child(13) + TD:not([colspan]):not([rowspan]):nth-child(2):nth-last-child(12) + TD:not([colspan]):not([rowspan]):nth-child(3):nth-last-child(11) + TD:not([colspan]):not([rowspan]):nth-child(4):nth-last-child(10)"
                                        },
                                        {
                                            "Column5",
                                            "TABLE.tabulka:nth-child(11) > * > TR > TH:not([colspan]):not([rowspan]):nth-child(1):nth-last-child(2) + TH[colspan=""12""]:not([rowspan]):nth-child(2):nth-last-child(1), TABLE.tabulka:nth-child(11) > * > TR > TH:not([colspan]):not([rowspan]):nth-child(1):nth-last-child(13) + TH:not([colspan]):not([rowspan]):nth-child(2):nth-last-child(12) + TH:not([colspan]):not([rowspan]):nth-child(3):nth-last-child(11) + TH:not([colspan]):not([rowspan]):nth-child(4):nth-last-child(10) + TH:not([colspan]):not([rowspan]):nth-child(5):nth-last-child(9), TABLE.tabulka:nth-child(11) > * > TR > TD:not([colspan]):not([rowspan]):nth-child(1):nth-last-child(13) + TD:not([colspan]):not([rowspan]):nth-child(2):nth-last-child(12) + TD:not([colspan]):not([rowspan]):nth-child(3):nth-last-child(11) + TD:not([colspan]):not([rowspan]):nth-child(4):nth-last-child(10) + TD:not([colspan]):not([rowspan]):nth-child(5):nth-last-child(9)"
                                        },
                                        {
                                            "Column6",
                                            "TABLE.tabulka:nth-child(11) > * > TR > TH:not([colspan]):not([rowspan]):nth-child(1):nth-last-child(2) + TH[colspan=""12""]:not([rowspan]):nth-child(2):nth-last-child(1), TABLE.tabulka:nth-child(11) > * > TR > TH:not([colspan]):not([rowspan]):nth-child(1):nth-last-child(13) + TH:not([colspan]):not([rowspan]):nth-child(2):nth-last-child(12) + TH:not([colspan]):not([rowspan]):nth-child(3):nth-last-child(11) + TH:not([colspan]):not([rowspan]):nth-child(4):nth-last-child(10) + TH:not([colspan]):not([rowspan]):nth-child(5):nth-last-child(9) + TH:not([colspan]):not([rowspan]):nth-child(6):nth-last-child(8), TABLE.tabulka:nth-child(11) > * > TR > TD:not([colspan]):not([rowspan]):nth-child(1):nth-last-child(13) + TD:not([colspan]):not([rowspan]):nth-child(2):nth-last-child(12) + TD:not([colspan]):not([rowspan]):nth-child(3):nth-last-child(11) + TD:not([colspan]):not([rowspan]):nth-child(4):nth-last-child(10) + TD:not([colspan]):not([rowspan]):nth-child(5):nth-last-child(9) + TD:not([colspan]):not([rowspan]):nth-child(6):nth-last-child(8)"
                                        },
                                        {
                                            "Column7",
                                            "TABLE.tabulka:nth-child(11) > * > TR > TH:not([colspan]):not([rowspan]):nth-child(1):nth-last-child(2) + TH[colspan=""12""]:not([rowspan]):nth-child(2):nth-last-child(1), TABLE.tabulka:nth-child(11) > * > TR > TH:not([colspan]):not([rowspan]):nth-child(1):nth-last-child(13) + TH:not([colspan]):not([rowspan]):nth-child(2):nth-last-child(12) + TH:not([colspan]):not([rowspan]):nth-child(3):nth-last-child(11) + TH:not([colspan]):not([rowspan]):nth-child(4):nth-last-child(10) + TH:not([colspan]):not([rowspan]):nth-child(5):nth-last-child(9) + TH:not([colspan]):not([rowspan]):nth-child(6):nth-last-child(8) + TH:not([colspan]):not([rowspan]):nth-child(7):nth-last-child(7), TABLE.tabulka:nth-child(11) > * > TR > TD:not([colspan]):not([rowspan]):nth-child(1):nth-last-child(13) + TD:not([colspan]):not([rowspan]):nth-child(2):nth-last-child(12) + TD:not([colspan]):not([rowspan]):nth-child(3):nth-last-child(11) + TD:not([colspan]):not([rowspan]):nth-child(4):nth-last-child(10) + TD:not([colspan]):not([rowspan]):nth-child(5):nth-last-child(9) + TD:not([colspan]):not([rowspan]):nth-child(6):nth-last-child(8) + TD:not([colspan]):not([rowspan]):nth-child(7):nth-last-child(7)"
                                        },
                                        {
                                            "Column8",
                                            "TABLE.tabulka:nth-child(11) > * > TR > TH:not([colspan]):not([rowspan]):nth-child(1):nth-last-child(2) + TH[colspan=""12""]:not([rowspan]):nth-child(2):nth-last-child(1), TABLE.tabulka:nth-child(11) > * > TR > TH:not([colspan]):not([rowspan]):nth-child(1):nth-last-child(13) + TH:not([colspan]):not([rowspan]):nth-child(2):nth-last-child(12) + TH:not([colspan]):not([rowspan]):nth-child(3):nth-last-child(11) + TH:not([colspan]):not([rowspan]):nth-child(4):nth-last-child(10) + TH:not([colspan]):not([rowspan]):nth-child(5):nth-last-child(9) + TH:not([colspan]):not([rowspan]):nth-child(6):nth-last-child(8) + TH:not([colspan]):not([rowspan]):nth-child(7):nth-last-child(7) + TH:not([colspan]):not([rowspan]):nth-child(8):nth-last-child(6), TABLE.tabulka:nth-child(11) > * > TR > TD:not([colspan]):not([rowspan]):nth-child(1):nth-last-child(13) + TD:not([colspan]):not([rowspan]):nth-child(2):nth-last-child(12) + TD:not([colspan]):not([rowspan]):nth-child(3):nth-last-child(11) + TD:not([colspan]):not([rowspan]):nth-child(4):nth-last-child(10) + TD:not([colspan]):not([rowspan]):nth-child(5):nth-last-child(9) + TD:not([colspan]):not([rowspan]):nth-child(6):nth-last-child(8) + TD:not([colspan]):not([rowspan]):nth-child(7):nth-last-child(7) + TD:not([colspan]):not([rowspan]):nth-child(8):nth-last-child(6)"
                                        },
                                        {
                                            "Column9",
                                            "TABLE.tabulka:nth-child(11) > * > TR > TH:not([colspan]):not([rowspan]):nth-child(1):nth-last-child(2) + TH[colspan=""12""]:not([rowspan]):nth-child(2):nth-last-child(1), TABLE.tabulka:nth-child(11) > * > TR > TH:not([colspan]):not([rowspan]):nth-child(1):nth-last-child(13) + TH:not([colspan]):not([rowspan]):nth-child(2):nth-last-child(12) + TH:not([colspan]):not([rowspan]):nth-child(3):nth-last-child(11) + TH:not([colspan]):not([rowspan]):nth-child(4):nth-last-child(10) + TH:not([colspan]):not([rowspan]):nth-child(5):nth-last-child(9) + TH:not([colspan]):not([rowspan]):nth-child(6):nth-last-child(8) + TH:not([colspan]):not([rowspan]):nth-child(7):nth-last-child(7) + TH:not([colspan]):not([rowspan]):nth-child(8):nth-last-child(6) + TH:not([colspan]):not([rowspan]):nth-child(9):nth-last-child(5), TABLE.tabulka:nth-child(11) > * > TR > TD:not([colspan]):not([rowspan]):nth-child(1):nth-last-child(13) + TD:not([colspan]):not([rowspan]):nth-child(2):nth-last-child(12) + TD:not([colspan]):not([rowspan]):nth-child(3):nth-last-child(11) + TD:not([colspan]):not([rowspan]):nth-child(4):nth-last-child(10) + TD:not([colspan]):not([rowspan]):nth-child(5):nth-last-child(9) + TD:not([colspan]):not([rowspan]):nth-child(6):nth-last-child(8) + TD:not([colspan]):not([rowspan]):nth-child(7):nth-last-child(7) + TD:not([colspan]):not([rowspan]):nth-child(8):nth-last-child(6) + TD:not([colspan]):not([rowspan]):nth-child(9):nth-last-child(5)"
                                        },
                                        {
                                            "Column10",
                                            "TABLE.tabulka:nth-child(11) > * > TR > TH:not([colspan]):not([rowspan]):nth-child(1):nth-last-child(2) + TH[colspan=""12""]:not([rowspan]):nth-child(2):nth-last-child(1), TABLE.tabulka:nth-child(11) > * > TR > TH:not([colspan]):not([rowspan]):nth-child(1):nth-last-child(13) + TH:not([colspan]):not([rowspan]):nth-child(2):nth-last-child(12) + TH:not([colspan]):not([rowspan]):nth-child(3):nth-last-child(11) + TH:not([colspan]):not([rowspan]):nth-child(4):nth-last-child(10) + TH:not([colspan]):not([rowspan]):nth-child(5):nth-last-child(9) + TH:not([colspan]):not([rowspan]):nth-child(6):nth-last-child(8) + TH:not([colspan]):not([rowspan]):nth-child(7):nth-last-child(7) + TH:not([colspan]):not([rowspan]):nth-child(8):nth-last-child(6) + TH:not([colspan]):not([rowspan]):nth-child(9):nth-last-child(5) + TH:not([colspan]):not([rowspan]):nth-child(10):nth-last-child(4), TABLE.tabulka:nth-child(11) > * > TR > TD:not([colspan]):not([rowspan]):nth-child(1):nth-last-child(13) + TD:not([colspan]):not([rowspan]):nth-child(2):nth-last-child(12) + TD:not([colspan]):not([rowspan]):nth-child(3):nth-last-child(11) + TD:not([colspan]):not([rowspan]):nth-child(4):nth-last-child(10) + TD:not([colspan]):not([rowspan]):nth-child(5):nth-last-child(9) + TD:not([colspan]):not([rowspan]):nth-child(6):nth-last-child(8) + TD:not([colspan]):not([rowspan]):nth-child(7):nth-last-child(7) + TD:not([colspan]):not([rowspan]):nth-child(8):nth-last-child(6) + TD:not([colspan]):not([rowspan]):nth-child(9):nth-last-child(5) + TD:not([colspan]):not([rowspan]):nth-child(10):nth-last-child(4)"
                                        },
                                        {
                                            "Column11",
                                            "TABLE.tabulka:nth-child(11) > * > TR > TH:not([colspan]):not([rowspan]):nth-child(1):nth-last-child(2) + TH[colspan=""12""]:not([rowspan]):nth-child(2):nth-last-child(1), TABLE.tabulka:nth-child(11) > * > TR > TH:not([colspan]):not([rowspan]):nth-child(1):nth-last-child(13) + TH:not([colspan]):not([rowspan]):nth-child(2):nth-last-child(12) + TH:not([colspan]):not([rowspan]):nth-child(3):nth-last-child(11) + TH:not([colspan]):not([rowspan]):nth-child(4):nth-last-child(10) + TH:not([colspan]):not([rowspan]):nth-child(5):nth-last-child(9) + TH:not([colspan]):not([rowspan]):nth-child(6):nth-last-child(8) + TH:not([colspan]):not([rowspan]):nth-child(7):nth-last-child(7) + TH:not([colspan]):not([rowspan]):nth-child(8):nth-last-child(6) + TH:not([colspan]):not([rowspan]):nth-child(9):nth-last-child(5) + TH:not([colspan]):not([rowspan]):nth-child(10):nth-last-child(4) + TH:not([colspan]):not([rowspan]):nth-child(11):nth-last-child(3), TABLE.tabulka:nth-child(11) > * > TR > TD:not([colspan]):not([rowspan]):nth-child(1):nth-last-child(13) + TD:not([colspan]):not([rowspan]):nth-child(2):nth-last-child(12) + TD:not([colspan]):not([rowspan]):nth-child(3):nth-last-child(11) + TD:not([colspan]):not([rowspan]):nth-child(4):nth-last-child(10) + TD:not([colspan]):not([rowspan]):nth-child(5):nth-last-child(9) + TD:not([colspan]):not([rowspan]):nth-child(6):nth-last-child(8) + TD:not([colspan]):not([rowspan]):nth-child(7):nth-last-child(7) + TD:not([colspan]):not([rowspan]):nth-child(8):nth-last-child(6) + TD:not([colspan]):not([rowspan]):nth-child(9):nth-last-child(5) + TD:not([colspan]):not([rowspan]):nth-child(10):nth-last-child(4) + TD:not([colspan]):not([rowspan]):nth-child(11):nth-last-child(3)"
                                        },
                                        {
                                            "Column12",
                                            "TABLE.tabulka:nth-child(11) > * > TR > TH:not([colspan]):not([rowspan]):nth-child(1):nth-last-child(2) + TH[colspan=""12""]:not([rowspan]):nth-child(2):nth-last-child(1), TABLE.tabulka:nth-child(11) > * > TR > TH:not([colspan]):not([rowspan]):nth-child(1):nth-last-child(13) + TH:not([colspan]):not([rowspan]):nth-child(2):nth-last-child(12) + TH:not([colspan]):not([rowspan]):nth-child(3):nth-last-child(11) + TH:not([colspan]):not([rowspan]):nth-child(4):nth-last-child(10) + TH:not([colspan]):not([rowspan]):nth-child(5):nth-last-child(9) + TH:not([colspan]):not([rowspan]):nth-child(6):nth-last-child(8) + TH:not([colspan]):not([rowspan]):nth-child(7):nth-last-child(7) + TH:not([colspan]):not([rowspan]):nth-child(8):nth-last-child(6) + TH:not([colspan]):not([rowspan]):nth-child(9):nth-last-child(5) + TH:not([colspan]):not([rowspan]):nth-child(10):nth-last-child(4) + TH:not([colspan]):not([rowspan]):nth-child(11):nth-last-child(3) + TH:not([colspan]):not([rowspan]):nth-child(12):nth-last-child(2), TABLE.tabulka:nth-child(11) > * > TR > TD:not([colspan]):not([rowspan]):nth-child(1):nth-last-child(13) + TD:not([colspan]):not([rowspan]):nth-child(2):nth-last-child(12) + TD:not([colspan]):not([rowspan]):nth-child(3):nth-last-child(11) + TD:not([colspan]):not([rowspan]):nth-child(4):nth-last-child(10) + TD:not([colspan]):not([rowspan]):nth-child(5):nth-last-child(9) + TD:not([colspan]):not([rowspan]):nth-child(6):nth-last-child(8) + TD:not([colspan]):not([rowspan]):nth-child(7):nth-last-child(7) + TD:not([colspan]):not([rowspan]):nth-child(8):nth-last-child(6) + TD:not([colspan]):not([rowspan]):nth-child(9):nth-last-child(5) + TD:not([colspan]):not([rowspan]):nth-child(10):nth-last-child(4) + TD:not([colspan]):not([rowspan]):nth-child(11):nth-last-child(3) + TD:not([colspan]):not([rowspan]):nth-child(12):nth-last-child(2)"
                                        },
                                        {
                                            "Column13",
                                            "TABLE.tabulka:nth-child(11) > * > TR > TH:not([colspan]):not([rowspan]):nth-child(1):nth-last-child(2) + TH[colspan=""12""]:not([rowspan]):nth-child(2):nth-last-child(1), TABLE.tabulka:nth-child(11) > * > TR > TH:not([colspan]):not([rowspan]):nth-child(1):nth-last-child(13) + TH:not([colspan]):not([rowspan]):nth-child(2):nth-last-child(12) + TH:not([colspan]):not([rowspan]):nth-child(3):nth-last-child(11) + TH:not([colspan]):not([rowspan]):nth-child(4):nth-last-child(10) + TH:not([colspan]):not([rowspan]):nth-child(5):nth-last-child(9) + TH:not([colspan]):not([rowspan]):nth-child(6):nth-last-child(8) + TH:not([colspan]):not([rowspan]):nth-child(7):nth-last-child(7) + TH:not([colspan]):not([rowspan]):nth-child(8):nth-last-child(6) + TH:not([colspan]):not([rowspan]):nth-child(9):nth-last-child(5) + TH:not([colspan]):not([rowspan]):nth-child(10):nth-last-child(4) + TH:not([colspan]):not([rowspan]):nth-child(11):nth-last-child(3) + TH:not([colspan]):not([rowspan]):nth-child(12):nth-last-child(2) + TH:not([colspan]):not([rowspan]):nth-child(13):nth-last-child(1), TABLE.tabulka:nth-child(11) > * > TR > TD:not([colspan]):not([rowspan]):nth-child(1):nth-last-child(13) + TD:not([colspan]):not([rowspan]):nth-child(2):nth-last-child(12) + TD:not([colspan]):not([rowspan]):nth-child(3):nth-last-child(11) + TD:not([colspan]):not([rowspan]):nth-child(4):nth-last-child(10) + TD:not([colspan]):not([rowspan]):nth-child(5):nth-last-child(9) + TD:not([colspan]):not([rowspan]):nth-child(6):nth-last-child(8) + TD:not([colspan]):not([rowspan]):nth-child(7):nth-last-child(7) + TD:not([colspan]):not([rowspan]):nth-child(8):nth-last-child(6) + TD:not([colspan]):not([rowspan]):nth-child(9):nth-last-child(5) + TD:not([colspan]):not([rowspan]):nth-child(10):nth-last-child(4) + TD:not([colspan]):not([rowspan]):nth-child(11):nth-last-child(3) + TD:not([colspan]):not([rowspan]):nth-child(12):nth-last-child(2) + TD:not([colspan]):not([rowspan]):nth-child(13):nth-last-child(1)"
                                        }
                                    },
                                    [RowSelector = "TABLE.tabulka:nth-child(11) > * > TR"]
                                ),
                            #"Odebrané horní řádky" =
                                Table.Skip(
                                    #"Extrahovaná tabulka z Html",
                                    1
                                ),
                            #"Záhlaví se zvýšenou úrovní" =
                                Table.PromoteHeaders(
                                    #"Odebrané horní řádky",
                                    [PromoteAllScalars = true]
                                ),
                            #"Přejmenované sloupce" =
                                Table.RenameColumns(
                                    #"Záhlaví se zvýšenou úrovní",
                                    {
                                        {
                                            "",
                                            "Rok"
                                        }
                                    }
                                ),
                            #"Další sloupce převedené na řádky" =
                                Table.UnpivotOtherColumns(
                                    #"Přejmenované sloupce",
                                    {"Rok"},
                                    "Měsíc",
                                    "Inflace"
                                ),
                            #"Změněný typ" =
                                Table.TransformColumnTypes(
                                    #"Další sloupce převedené na řádky",
                                    {
                                        {
                                            "Rok",
                                            Int64.Type
                                        },
                                        {
                                            "Měsíc",
                                            Int64.Type
                                        }
                                    }
                                ),
                            #"Změněný typ s národním prostředím" =
                                Table.TransformColumnTypes(
                                    #"Změněný typ",
                                    {
                                        {
                                            "Inflace",
                                            type number
                                        }
                                    },
                                    "cs-CZ"
                                ),
                            #"Filtrované řádky" =
                                Table.SelectRows(
                                    #"Změněný typ s národním prostředím",
                                    each
                                        ([Inflace] <> null)
                                        and [Rok]
                                        >= fromYear
                                )
                        in
                            #"Filtrované řádky"
            in
                out,
    documentation = [
        Documentation.Name = " get-InflaceZČNB.pq ",
        Documentation.Description = " Returns Inflace from ČNB (Česká Národní Banka) ",
        Documentation.Source = " https://www.jaknapowerbi.cz ",
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