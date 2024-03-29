let
    output = (startYear as number, endYear as number) =>
        let
            Source = List.Select(
                {startYear..endYear},
                (y) =>
                    List.Count(
                        List.Select(
                            {1..12},
                            (m) =>
                                let
                                    innerSelection = List.Dates(
                                        #date(y, m, 1),
                                        Date.Day(Date.EndOfMonth(#date(y, m, 1))),
                                        #duration(1, 0, 0, 0)
                                    ),
                                    fct = (vl as number) =>
                                        if List.Count(List.Select(innerSelection, each Date.DayOfWeek(_, 1) = vl)) >= 5 then
                                            true
                                        else
                                            false
                                in
                                    List.Count(
                                        List.Select(
                                            List.Generate(
                                                () => [vl = 6, res = fct(vl)],
                                                each (_[vl] ?? 1) > 3,
                                                each [vl = _[vl] - 1, res = fct(vl)],
                                                each [res]
                                            ),
                                            each _
                                        )
                                    ) = 3
                        )
                    ) > 1
            )
        in
            Source,
    documentation = [
        Documentation.Name = " get-ExtractYearsWithTwoMonthsWith5FIDAYSSATURDAYSSUDAYS.pq ",
        Documentation.Description = " Returns a list of years with two months with 5 Fridays, Saturdays and Sundays. ",
        Documentation.Source = "https://www.datameerkat.com . ",
        Documentation.Version = " 1.0 ",
        Documentation.Author = " Štěpán Rešl "
    ]
in
    Value.ReplaceType(output, Value.ReplaceMetadata(Value.Type(output), documentation))