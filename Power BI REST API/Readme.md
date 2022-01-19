# Power BI REST API CUSTOM Function Library

This repository has been created as an open-source library of [Štěpán Rešl](https://www.linkedin.com/in/%C5%A1t%C4%9Bp%C3%A1n-re%C5%A1l-464084152/?originalSubdomain=cz) - [DataBrothers s.r.o.](https://www.databorthers.cz)

## Authentication Functions:

Method | Name | Description 
------ | ---- | ----------- 
Post | [PBI - Bearer Token](https://github.com/tirnovar/m-custom-functions/blob/master/Power%20BI%20REST%20API/Token/get-BearerToken.pq) | ######


## Admin Functions:
Method | Name | Description 
------ | ---- | ----------- 
Get | [EasterDate](https://github.com/tirnovar/m-custom-functions/blob/master/get-EasterDate.pq) | ######

## Scanner API Functions:
Method | Name | Description | Requirements
------ | ---- | ----------- | ------------
Post | [GetInfo](https://github.com/tirnovar/m-custom-functions/blob/master/Power%20BI%20REST%20API/ScannerAPI/Get%20Info/get-getInfo.pq) | Start scanning to selected Workspace | [PBI - Bearer Token](https://github.com/tirnovar/m-custom-functions/blob/master/Power%20BI%20REST%20API/Token/get-BearerToken.pq) + [WorkspaceId]()
Get | [Scan Status](https://github.com/tirnovar/m-custom-functions/blob/master/Power%20BI%20REST%20API/ScannerAPI/Get%20Scan%20Status/get-ScanStatus.pq) | Returns actual status of called scan (by ID) | [PBI - Bearer Token](https://github.com/tirnovar/m-custom-functions/blob/master/Power%20BI%20REST%20API/Token/get-BearerToken.pq) + [scanId](https://github.com/tirnovar/m-custom-functions/blob/master/Power%20BI%20REST%20API/ScannerAPI/Get%20Info/get-getInfo.pq)
Get | [Scan Results](https://github.com/tirnovar/m-custom-functions/blob/master/Power%20BI%20REST%20API/ScannerAPI/Get%20Scanned%20Result/get-ScanResult.pq) | Returns results of called scan (by ID) !(Works only when [Scan Status](https://github.com/tirnovar/m-custom-functions/blob/master/Power%20BI%20REST%20API/ScannerAPI/Get%20Scan%20Status/get-ScanStatus.pq) is "Successful")! | [PBI - Bearer Token](https://github.com/tirnovar/m-custom-functions/blob/master/Power%20BI%20REST%20API/Token/get-BearerToken.pq) + [scanId](https://github.com/tirnovar/m-custom-functions/blob/master/Power%20BI%20REST%20API/ScannerAPI/Get%20Info/get-getInfo.pq)
Get | [Scan Status and / or Results](https://github.com/tirnovar/m-custom-functions/blob/master/Power%20BI%20REST%20API/ScannerAPI/Get%20Scan%20Status%20And%20Results/get-ScanStatusAndResult.pq) | Call [Scan Status](https://github.com/tirnovar/m-custom-functions/blob/master/Power%20BI%20REST%20API/ScannerAPI/Get%20Scan%20Status/get-ScanStatus.pq) and if result is "Successful" then [Scan Results](https://github.com/tirnovar/m-custom-functions/blob/master/Power%20BI%20REST%20API/ScannerAPI/Get%20Scanned%20Result/get-ScanResult.pq) is called for results | [PBI - Bearer Token](https://github.com/tirnovar/m-custom-functions/blob/master/Power%20BI%20REST%20API/Token/get-BearerToken.pq) + [scanId](https://github.com/tirnovar/m-custom-functions/blob/master/Power%20BI%20REST%20API/ScannerAPI/Get%20Info/get-getInfo.pq)
