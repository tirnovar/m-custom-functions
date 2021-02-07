let
    output =
        (start_date as date, end_date as date) as table =>
            let
                tb =
                    #table(
                        type table [
                            Date = date,
                            Day = Int64.Type,
                            Month = Int64.Type,
                            MonthName = text,
                            Year = Int64.Type,
                            Quarter = Int64.Type
                        ],
                        List.Transform(
                            List.Dates(
                                start_date,
                                (end_date - start_date),
                                #duration(1, 0, 0, 0)
                            ),
                            each
                                {
                                    _,
                                    Date.Day(_),
                                    Date.Month(_),
                                    Date.MonthName(_),
                                    Date.Year(_),
                                    Date.QuarterOfYear(_)
                                }
                        )
                    )
            in
                tb
in
    output