## How to get All Data Gateways?
### To get all data gateways, you need to prepare this information:
- Azure Tenant Id
- Application Client Id
- Application Client Secret

![Client & Tenant IDs](https://github.com/tirnovar/m-custom-functions/blob/master/Power%20BI%20REST%20API/src/img/Client%20%26%20Tenant%20IDs.png)
![Client Secret](https://github.com/tirnovar/m-custom-functions/blob/master/Power%20BI%20REST%20API/src/img/Client%20Secret.png)

### Do I need some particular setting in Azure App?
Shortly? YES! App setting you need to go to Authentication -> Platform configuration -> Add Platform -> Web - And set Redirect URIs to <code>http://localhost:8080</code>

### Let's start step by step.
1) By [Create URL to user Login](https://github.com/tirnovar/m-custom-functions/blob/master/Power%20BI%20REST%20API/Gateways/Build%20Initial%20Call%20URL/get-InitialCallURLToUserToken.pq) function, you will receive a URL that you will need to put into your browser.
2) After login / If you already were logged in browser URL, you will find a new one that will start with <code>localhost:8080</code>.
![Returned URL to localhost](https://github.com/tirnovar/m-custom-functions/blob/master/Power%20BI%20REST%20API/src/img/Returned%20URL%20to%20localhost.png)
3) You can extract the needed code from this returned URL by [Extract code](https://github.com/tirnovar/m-custom-functions/blob/master/Power%20BI%20REST%20API/Gateways/Extract%20Code%20From%20URL/get-CodeFromURL.pq) function.
4) Now you need to get <code>Refresh Token</code>. To get this type of token, you will need an app to call APIs and handle redirections. I recommend [Postman](https://www.postman.com/) App.
5) In Postman you need to import this cURL: <code>curl --location --request POST 'https://login.microsoftonline.com/<AzureTenantID>/oauth2/v2.0/token' \ --header 'Content-Type: application/x-www-form-urlencoded' \ --data-urlencode 'code=<ExportedCode>' \ --data-urlencode 'client_id=<ApplicationClientId>' \ --data-urlencode 'client_secret=<ApplicationClientSecret>' \ --data-urlencode 'scope=https://analysis.windows.net/powerbi/api/.default' \ --data-urlencode 'redirect_uri=http://localhost:8080' \ --data-urlencode 'grant_type=authorization_code'</code> <p> <p> And import change all "<>" parameters for requested values. (Dont forget to change the one in URL also!)
6) In JSON response, you will find <code>Refresh Token</code> that you need to receive your [UserToken](https://github.com/tirnovar/m-custom-functions/blob/master/Power%20BI%20REST%20API/Gateways/Get%20User%20Token/get-UserToken.pq).
7) Thanks to [UserToken](https://github.com/tirnovar/m-custom-functions/blob/master/Power%20BI%20REST%20API/Gateways/Get%20User%20Token/get-UserToken.pq) function, you need to generate <code>Bearer Token</code>.
8) Received token you can use to call [Gateways](https://github.com/tirnovar/m-custom-functions/blob/master/Power%20BI%20REST%20API/Gateways/Get%20Gateways/get-Gateways.pq) function and finally receive outputs!
  
### What to be aware of?
- Code received by [Extract code](https://github.com/tirnovar/m-custom-functions/blob/master/Power%20BI%20REST%20API/Gateways/Extract%20Code%20From%20URL/get-CodeFromURL.pq) can be called only once. If your call with this code will return an ERROR, you need to generate code again from scratch.
