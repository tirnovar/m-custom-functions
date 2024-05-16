let
    output = (inputTbl as table) as table => [
        originCntr = Table.RowCount(inputTbl),
        schm = List.Buffer(Table.SelectRows(Table.Schema(Table.StopFolding(inputTbl)), each [Kind] = "number")[Name]),
        addition = #table(
            List.Combine({{"Columns"}, schm}),
            List.Transform(
                schm,
                each
                    List.Combine(
                        {
                            {_},
                            [
                                crCol = _,
                                Cols = schm,
                                xCols = Table.Column(inputTbl, crCol),
                                sX = List.Sum(xCols),
                                sX2 = List.Sum(List.Transform(xCols, each Number.Power(_, 2))),
                                Y = List.Transform(
                                    Cols,
                                    each
                                        if _ = crCol then
                                            null
                                        else
                                            [
                                                df = Table.SelectColumns(inputTbl, {crCol, _}),
                                                sY = List.Sum(Table.Column(df, _)),
                                                sXY = List.Sum(List.Transform(Table.ToRows(df), each _{0} * _{1})),
                                                sY2 = List.Sum(
                                                    List.Transform(Table.Column(df, _), each Number.Power(_, 2))
                                                ),
                                                pearson_numerator = (originCntr * sXY) - (sX * sY),
                                                pearson_denominator_X = originCntr * Number.Power(sX2, 2) - Number.Power(
                                                    sX, 2
                                                ),
                                                pearson_denominator_Y = (originCntr * sY2) - Number.Power(sY, 2),
                                                person_denominator = Number.Sqrt(
                                                    pearson_denominator_X * pearson_denominator_Y
                                                ),
                                                result = pearson_numerator / person_denominator
                                            ][result]
                                )
                            ][Y]
                        }
                    )
            )
        )
    ][addition],
    documentation = [
        Documentation.Name = " get-NumberColumnsCorrelation.pq ",
        Documentation.Description = " Calculates Correlation between all numeric columns in the input table.",
        Documentation.Source = " https://www.datameerkat.com ",
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