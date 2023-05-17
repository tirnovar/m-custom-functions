let
    output = (startDate as date, endDate as date, value as number) as number =>
        let
            startOfMonthStartDate = Date.StartOfMonth(startDate),
            startOfMonthEndDate = Date.StartOfMonth(endDate),
            endOfMonthStartDate = Date.EndOfMonth(startDate),
            endOfMonthEndDate = Date.EndOfMonth(endDate),
            singleResult = (singleStart as date, singleEnd as date) as number =>
                Value.Divide(value, Date.StartOfMonth(Date.EndOfMonth(singleStart) - singleStart)) * Number.From(
                    singleEnd - singleStart
                ),
            result =
                if endOfMonthStartDate = endOfMonthEndDate then
                    singleResult(startDate, endDate)
                else
                    let
                        innerListOfDates = List.Buffer(
                            List.Select(
                                List.Dates(
                                    Date.StartOfMonth(startDate), 
                                    Number.From(endDate - startDate), 
                                    #duration(1, 0, 0, 0)
                                ),
                                each Date.Day(_) = 1
                            )
                        ),
                        tranformator = List.Sum(
                            List.Transform(
                                innerListOfDates,
                                each
                                    if _ = startOfMonthStartDate then
                                        singleResult(startDate, Date.EndOfMonth(_))
                                    else if _ = startOfMonthEndDate then
                                        singleResult(endDate, Date.EndOfMonth(_))
                                    else
                                        value
                            )
                        )
                    in
                        tranformator
        in
            result,
            documentation = [
                Documentation.Name = " get-ExactDivergenceValueByMonth.pq ",
                Documentation.Description = " Calculate exact value for each month and part of month on the edges of interval. ",
                Documentation.Source = " https://www.jaknapowerbi.cz . ",
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
   
