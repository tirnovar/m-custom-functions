let
    startDateTime = #datetime(2020, 1, 1, 15, 30, 00),
    startDate = Date.From(startDateTime),
    startTime = Time.From(startDateTime),
    startHour = Time.Hour(startTime),
    startWorkHour = #time(8, 00, 00),
    endDateTime = #datetime(2020, 1, 3, 17, 30, 00),
    endDate = Date.From(endDateTime),
    endTime = Time.From(endDateTime),
    endHour = Time.Hour(endTime),
    endWorkHour = #time(17, 00, 00),
    maxHoursPerDay = endWorkHour - startWorkHour,
    realStartTime =
        if startTime < startWorkHour then
            startWorkHour
        else if startTime > endWorkHour then
            endWorkHour
        else
            startTime,
    realEndTime =
        if endTime < startWorkHour then
            startWorkHour
        else if endTime > endWorkHour then
            endWorkHour
        else
            endTime,
    diversionOfTime = realEndTime - realStartTime,
    output =
        if startDate = endDate then
            if diversionOfTime > maxHoursPerDay then
                maxHoursPerDay
            else
                diversionOfTime
        else
            let
                dt =
                    Table.Buffer(
                        Table.SelectRows(
                            #table(
                                type table [
                                    Date = date,
                                    Weekend = logical
                                ],
                                List.Transform(
                                    List.Dates(
                                        startDate,
                                        (
                                            Number.From(endDate)
                                            - Number.From(startDate)
                                        )
                                        + 1,
                                        #duration(1, 0, 0, 0)
                                    ),
                                    each
                                        {
                                            _,
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
                                                false
                                        }
                                )
                            ),
                            each [Weekend] = false
                        )
                    ),
                addon =
                    Table.AddColumn(
                        dt,
                        "Addon",
                        each
                            if [Date] = startDate then
                                endWorkHour - realStartTime
                            else if [Date] = endDate then
                                endWorkHour - realEndTime
                            else
                                maxHoursPerDay,
                        Int64.Type
                    ),
                summarization = List.Sum(addon[Addon])
            in
                summarization,    
        documentation = [
        Documentation.Name = " get-WorkingMDBetweenDatesAndByWorkingHours.pq ",
        Documentation.Description = " Returning Time between StartDateTime and EndDateTime by Working hours and working days (without weekends). ",
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
