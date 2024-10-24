# DataBrothers Power Query Custom Function Library

This repository has been created as an open-source library of [Štěpán Rešl](https://www.linkedin.com/in/%C5%A1t%C4%9Bp%C3%A1n-re%C5%A1l-464084152/?originalSubdomain=cz) - [DataBrothers s.r.o.](https://www.databorthers.cz)

This library contains mostly pure M-functions without any other languages.

## General Functions:

Method | Name | Description | Language
------ | ---- | ----------- | --------
Create | [DateKey](https://github.com/tirnovar/m-custom-functions/tree/master/Functions%20with%20extra%20documentations/create-DateKey) | Returns a DateKey table with a list of working days based on a list of holidays that can be defined as a separate list. | M
Get | [EasterDate](https://github.com/tirnovar/m-custom-functions/blob/master/get-EasterDate.pq) | Returning Date of Easter Sunday for inputted Year. | M
Get | [DataToJson](https://github.com/tirnovar/m-custom-functions/blob/master/get-DataToJson.pq) | Returns inputted table as a one JSON structure. | M + R
Get | [CumulatedValueByCategoryAndPreviousDates](https://github.com/tirnovar/m-custom-functions/blob/master/get-CumulatedValueByCategoryAndPreviousDates.pq)| Return cumulated summary by specific category and previous dates. This function required Table, String names of columns: <code>{Cumulation, Category, Date}</code> and Columns that will be used as Category and DateKey | M
Get | [RangeOfNumbers](https://github.com/tirnovar/m-custom-functions/blob/master/get-RangeOfNumbers.pq) | Return a list of numbers between the start number and the latest number that an inputted count of digits can create. If you use "true" and fromStart variables, then numbers will be added to the start; otherwise, it will end. | M
Get | [ServiceDeskIssuesDataFromJiraCloud](https://github.com/tirnovar/m-custom-functions/blob/master/get-ServiceDeskIssuesDataFromJiraCloud.pq) | Getting all data of issues from JIRA CLOUD (including history). | M
Get | [WorkingMDBetweenDatesAndByWorkingHours](https://github.com/tirnovar/m-custom-functions/blob/master/get-WorkingMDBetweenDatesAndByWorkingHours.pq) | Returning Time between StartDateTime and EndDateTime by Working hours and working days (without weekends). | M
Get | [AllWorldCountriesWithDetails](https://github.com/tirnovar/m-custom-functions/blob/master/get-AllWorldCountriesWithDetails.pq) | Getting table of world Countries with details about them. | M
Get | [NumbersFromText](https://github.com/tirnovar/m-custom-functions/blob/master/get-NumbersFromText.pq) | Returns all numbers from input text source | M
Get | [TableOfLanguages](https://github.com/tirnovar/m-custom-functions/blob/master/get-TableOfLanguages.pq) | Returns a table with all defined languages and their shortcodes. | M
Get | [Metadata of Files and their subfolders](https://github.com/tirnovar/m-custom-functions/blob/master/get-AllMetadataOfSharepointFilesInclucindNestesFolders.pq) | Returns all metadata from Sharepoint files in a folder and all subfolders. | M
Send | [DataToPowerAutomateAsJSON](https://github.com/tirnovar/m-custom-functions/blob/master/send-DataToPowerAutomateAsJSON.pq) | Sending JSON structured data to Power Automate HTTP endpoint and returning TEXT value Send or Something happened. | M
Get | [ColoredExcelCellsExtraction](https://github.com/tirnovar/m-custom-functions/blob/master/get-ColoredExcelCells.pq) | This function extracts all colored cells (can also extract just specific color or all colors without selected one) | M
Get | [Extract Years With Two Months With 5 FIDAYS, SATURDAYS and SUDAYS](https://github.com/tirnovar/m-custom-functions/blob/master/get-ExtractYearsWithTwoMonthsWith5FIDAYSSATURDAYSSUDAYS.pq) | Returns a list of years with two months with 5 Fridays, Saturdays and Sundays. | M
Get | [DEC to BIN Convertor](https://github.com/tirnovar/m-custom-functions/blob/master/get-DECtoBIN.pq) | Transfer decimal number to binary number. | M
Get | [RGB Tint Modifier](https://github.com/tirnovar/m-custom-functions/blob/master/get-rgbTintModifier.pq) | Inserted RGB color code: R: 68, G: 114, B: 196 and TINT 60% as a number and you will recive modified color code | M
Get | [Converter Between HEX and RGB Color codes](https://github.com/tirnovar/m-custom-functions/blob/master/get-ConverterBetweenHEXandRGB.pq) | Converts RGB color code to HEX code and VICE VERSA. | M
Get | [Correlation of Numeric Columns](https://github.com/tirnovar/m-custom-functions/blob/master/get-NumberColumnsCorrelation.pq) | Calculates Correlation between all numeric columns in the input table. | M
Get | [JSON to Text](https://github.com/tirnovar/m-custom-functions/blob/master/get-JSONToText.pq) | Converts JSON to Text. | M

## Microsoft Graph API:
Method | Name | Description | Language
------ | ---- | ----------- | --------
Get | [TableOfUsersFromMicrosoftGraphAPI](https://github.com/tirnovar/m-custom-functions/blob/master/Functions%20with%20extra%20documentations/get-TableOfUsersFromMicrosoftGraphAPI/get-TableOfUsersFromMicrosoftGraphAPI.pq) | Getting table with data from Microsoft Graph API about Users. You must create OWN Azure Aplication in Azure Active Directory with API Permisons: <code>{User.Read, Reports.Read.All, Directory.Read.All}</code> | M

## Storyous Functions:
Method | Name | Description | Language
------ | ---- | ----------- | --------
Get | [StoryousAPIKey](https://github.com/tirnovar/m-custom-functions/blob/master/Functions%20with%20extra%20documentations/get-Storyous/get-StoryousAPIKey/get-StoryousAPIKey.pq) | Returns Bearer API Token for Storyous API | M
Get | [StoryousDataOfMarketPlaceBillsByAPI](https://github.com/tirnovar/m-custom-functions/blob/master/Functions%20with%20extra%20documentations/get-Storyous/get-StoryousDataOfMarketPlaceBillsByAPI/get-StoryousDataOfMarketPlaceBillsByAPI.pq) | Returns all data from Storyous API of Market, Places and Bills | M
Get | [StoryousDataUniverzalWithoutRecursion](https://github.com/tirnovar/m-custom-functions/blob/master/Functions%20with%20extra%20documentations/get-Storyous/get-StoryousDataUniverzalWithoutRecursion/get-StoryousDataUniverzalWithoutRecursion.pq) | This function is great to use if you need to get specific table from Storyous API | M

## 🇨🇿 Functions:
Method | Name | Description | Language
------ | ---- | ----------- | --------
Get | [ExchangeRateOfCZK](https://github.com/tirnovar/m-custom-functions/blob/master/get-ExchangeRatesOfCZK.pq)| Returns Table of the Exchange rate of all currencies from ČNB to CZK | M
Get | [Inflace z ČNB](https://github.com/tirnovar/m-custom-functions/blob/master/get-InflaceZ%C4%8CNB.pq)| Returns Inflace from ČNB (Česká Národní Banka) | M

## Custom Function Template
Name | Description | Language
---- | ----------- | --------
[Custiom Function Template](https://github.com/tirnovar/m-custom-functions/blob/master/Function%20Template/function-template.pq) | Here is my template for developing custom #PowerQuery functions | M
