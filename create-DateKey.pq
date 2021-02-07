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
                            Quarter = Int64.Type,
                            DayOfWeek = Int64.Type,
                            IsWeekend = logical,
                            czHolidays = logical,
                            EndDayOfMonth = Int64.Type
                        ],
                        List.Transform(
                            List.Dates(
                                start_date,
                                (Number.From(end_date) - Number.From(start_date)),
                                #duration(1, 0, 0, 0)
                            ),
                            each
                                {
                                    _,
                                    Date.Day(_),
                                    Date.Month(_),
                                    Date.ToText(_, "MMMM", "en-us"),
                                    Date.Year(_),
                                    Date.QuarterOfYear(_),
                                    Date.DayOfWeek(_,Day.Monday) + 1,
                                    if Date.DayOfWeek(_,Day.Monday) + 1 = 6 or Date.DayOfWeek(_,Day.Monday) + 1 = 7 then true else false,
                                    if List.Contains(
                                        {"1.1","1.5","8.5","5.7","6.7","28.9","28.10","17.11","24.12","25.12","26.12"}, Number.ToText(Date.Day(_)) & "." & Number.ToText(Date.Month(_)))  then true else false,
                                    Date.Day(Date.EndOfMonth(_))
                                }
                        )
                    )
            in
                tb
in
    output