# DataBrothers Power Query Custom Function Library

This repository has been created as an open-source library of [Štěpán Rešl](https://www.linkedin.com/in/%C5%A1t%C4%9Bp%C3%A1n-re%C5%A1l-464084152/?originalSubdomain=cz) - [DataBrothers s.r.o.](https://www.databorthers.cz)

This library contains mostly pure M-functions without any other languages.

## General Functions:

Method | Name | Description | Language
------ | ---- | ----------- | --------
Create | [DateKey](https://github.com/tirnovar/m-custom-functions/blob/master/Functions%20with%20extra%20documentations/create-DateKey/create-DateKey.pq) | Returns a DateKey table with a list of working days based on a list of holidays that can be defined as a separate list. | M
Get | [EasterDate](https://github.com/tirnovar/m-custom-functions/blob/master/get-EasterDate.pg) | Returning Date of Easter Sunday for inputted Year. | M
Get | [DataToJson](https://github.com/tirnovar/m-custom-functions/blob/master/get-DataToJson.pq) | Returns inputted table as a one JSON structure. | M + R
Get | [CumulatedValueByCategoryAndPreviousDates](https://github.com/tirnovar/m-custom-functions/blob/master/get-CumulatedValueByCategoryAndPreviousDates.pq)| Return cumulated summary by specific category and previous dates. This function required Table, String names of columns: <code>{Cumulation, Category, Date}</code> and Columns thats will be used as Category and DateKey | M
Get | [RangeOfNumbers](https://github.com/tirnovar/m-custom-functions/blob/master/get-RangeOfNumbers.pq) | Return list of numbers between start number and latest number that an inputted count of digits can create. If you use "true" and fromStart variables, then numbers will be added to the start; otherwise, it will end. | M
Get | [ServiceDeskIssuesDataFromJiraCloud](https://github.com/tirnovar/m-custom-functions/blob/master/get-ServiceDeskIssuesDataFromJiraCloud.pq) | Getting all data of issues from JIRA CLOUD (including history). | M
Get | [WorkingMDBetweenDatesAndByWorkingHours](https://github.com/tirnovar/m-custom-functions/blob/master/get-WorkingMDBetweenDatesAndByWorkingHours.pq) | Returning Time between StartDateTime and EndDateTime by Working hours and working days (without weekends). | M
Get | [TableOfUsersFromMicrosoftGraphAPI](https://github.com/tirnovar/m-custom-functions/blob/master/Functions%20with%20extra%20documentations/get-TableOfUsersFromMicrosoftGraphAPI/get-TableOfUsersFromMicrosoftGraphAPI.pq) | Getting table with data from Microsoft Graph API about Users. You have to create OWN Azure Aplication in Azure Active Directory with API Permisons: <code>{User.Read, Reports.Read.All, Directory.Read.All}</code> | M
Get | [AllWorldCountriesWithDetails](https://github.com/tirnovar/m-custom-functions/blob/master/get-AllWorldCountriesWithDetails.pq) | Geting table of wold Countries with details about them. | M
Get | [StoryousAPIKey](https://github.com/tirnovar/m-custom-functions/blob/master/Functions%20with%20extra%20documentations/get-Storyous/get-StoryousAPIKey/get-StoryousAPIKey.pq) | Returns Bearer API Token for Storyous API | M
Get | [StoryousDataOfMarketPlaceBillsByAPI](https://github.com/tirnovar/m-custom-functions/blob/master/Functions%20with%20extra%20documentations/get-Storyous/get-StoryousDataOfMarketPlaceBillsByAPI/get-StoryousDataOfMarketPlaceBillsByAPI.pq) | Returns all data from Storyous API of Market, Places and Bills | M
Get | [StoryousDataUniverzalWithoutRecursion](https://github.com/tirnovar/m-custom-functions/blob/master/Functions%20with%20extra%20documentations/get-Storyous/get-StoryousDataUniverzalWithoutRecursion/get-StoryousDataUniverzalWithoutRecursion.pq) | This function is great to use if you need to get specific table from Storyous API | M
Send | [DataToPowerAutomateAsJSON](https://github.com/tirnovar/m-custom-functions/blob/master/send-DataToPowerAutomateAsJSON.pq) | Sending JSON structured data to Power Automate HTTP endpoint and returning TEXT value Send or Something happened. | M

## 🇨🇿 Functions:
Method | Name | Description | Language
------ | ---- | ----------- | --------
Get | [ExchangeRateOfCZK](https://github.com/tirnovar/m-custom-functions/blob/master/get-ExchangeRatesOfCZK.pq)| Returns Table of Exchange rate of all currencies from ČNB to CZK | M
Get | [Inflace_z_ČNB](https://github.com/tirnovar/m-custom-functions/blob/master/get-InflaceZ%C4%8CNB.pq)| Returns Inflace from ČNB (Česká Národní Banka) | M
