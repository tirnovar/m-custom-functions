let
    output =
        (start_date as date, end_date as date, list_of_holidays as list) as table =>
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
                            Holidays = logical,
                            EndDayOfMonth = Int64.Type
                        ],
                        List.Transform(
                            List.Dates(
                                start_date,
                                (
                                    Number.From(end_date)
                                    - Number.From(start_date)
                                ),
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
                                    Date.DayOfWeek(_, Day.Monday) + 1,
                                    if
                                        Date.DayOfWeek(_, Day.Monday)
                                        + 1
                                        = 6
                                        or Date.DayOfWeek(_, Day.Monday)
                                        + 1
                                        = 7
                                    then
                                        true
                                    else
                                        false,
                                    if
                                        List.Contains(
                                            list_of_holidays,
                                            Number.ToText(Date.Day(_))
                                            & "."
                                            & Number.ToText(Date.Month(_))
                                        )
                                    then
                                        true
                                    else
                                        false,
                                    Date.Day(Date.EndOfMonth(_))
                                }
                        )
                    )
            in
                tb,
    documentation = [
        Documentation.Name = " Create-dateKey.pq ",
        Documentation.Description = " Funcion is creating DateKey table. ",
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