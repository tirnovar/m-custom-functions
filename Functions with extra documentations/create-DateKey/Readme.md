# Create DateKey

This DateKey contains:

<code>{Date as date, Day as number, Month as number, MonthName as text, Year as number, Quarter as number, DayOfWeek as number, IsWeekend as logic, Holidays as logic, EndDayOfMonth as number}</code>

## Requirements
For creating DateKey by this function you need 3 inputs.
- Start Date
- End Date
- List of Holidays (Really have to be LIST in format "DD.MM"

## Steps
- Put create-DateKey.pq code into Blank Query

![DateKey Function](https://github.com/tirnovar/m-custom-functions/blob/master/src/img/DateKey-1.png)

- Set-up your list of Holidays

![List of Holidays](https://github.com/tirnovar/m-custom-functions/blob/master/src/img/DateKey-2.png)

- In Blank Query use your new imported function

![Use of create-DateKey function](https://github.com/tirnovar/m-custom-functions/blob/master/src/img/DateKey-3.png)
