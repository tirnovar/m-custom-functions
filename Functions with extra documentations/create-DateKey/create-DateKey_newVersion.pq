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
                            HolidayOrWeekend = logical,
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
                                let
                                    dt = _,
                                    day = Date.Day(dt),
                                    month = Date.Month(dt),
                                    monthName = Date.ToText(dt, "MMMM", "en-us"),
                                    year = Date.Year(dt),
                                    quarter = Date.QuarterOfYear(dt),
                                    dayOfWeek = Date.DayOfWeek(dt, Day.Monday) + 1,
                                    isWeekend =
                                        if dayOfWeek > 5 then
                                            true
                                        else
                                            false,
                                    holidays =
                                        if
                                            List.Contains(
                                                list_of_holidays,
                                                Number.ToText(day)
                                                & "."
                                                & Number.ToText(month)
                                            )
                                        then
                                            true
                                        else
                                            false,
                                    holidayorweekend =
                                        if isWeekend or holidays then
                                            true
                                        else
                                            false,
                                    enddayofmonth = Date.Day(Date.EndOfMonth(dt)),
                                    result = {
                                        dt,
                                        day,
                                        month,
                                        monthName,
                                        year,
                                        quarter,
                                        dayOfWeek,
                                        isWeekend,
                                        holidays,
                                        holidayorweekend,
                                        enddayofmonth
                                    }
                                in
                                    result
                        )
                    )
            in
                tb,
    documentation = [
        Documentation.Name = " Create-dateKey_newVersion.pq ",
        Documentation.Description = " Funcion is creating DateKey table. ",
        Documentation.Source = " https://www.jaknapowerbi.cz . ",
        Documentation.Version = " 2.0 ",
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