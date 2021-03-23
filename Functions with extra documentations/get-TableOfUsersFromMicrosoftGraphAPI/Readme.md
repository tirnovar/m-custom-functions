# Get Table of Users from Microsoft Graph API
This function returns all data from Microsoft Graph API about Users

## Requirements
- Register App into Azure Active Directory
- Set up API permissions
- Azure AD Tenant ID from App
- Azure Application Client ID
- Azure Application Client Secret

## Steps
- Go to App registration inside [Azure Active Directory](https://portal.azure.com/#blade/Microsoft_AAD_IAM/ActiveDirectoryMenuBlade/Overview)

![Go to App registration](https://github.com/tirnovar/m-custom-functions/blob/master/src/img/GetUserDataFromGraphAPI-1.png)

- Create new app (if you want to use already existing one then skip this step)

![AppCreating](https://github.com/tirnovar/m-custom-functions/blob/master/src/img/GetUserDataFromGraphAPI-2.png)

- Copy Application (client) ID {Azure Application Client ID} and Directory (tenant) ID {Azure AD Tenant ID}, then you can go to API Permissions

![RequiredIDs](https://github.com/tirnovar/m-custom-functions/blob/master/src/img/GetUserDataFromGraphAPI-3.png)

- Set up APPLICATION PERMISSIONS and Grant them!

![Set-up application permission](https://github.com/tirnovar/m-custom-functions/blob/master/src/img/GetUserDataFromGraphAPI-4.png)

![GrantingPermissions](https://github.com/tirnovar/m-custom-functions/blob/master/src/img/GetUserDataFromGraphAPI-5.png)

- Create client Secrets (Set expiration as you like)

![Client Secrets](https://github.com/tirnovar/m-custom-functions/blob/master/src/img/GetUserDataFromGraphAPI-6.png)

- Create Blank Query and input code from get-TableOfUsersFromMicrosoftGraphApi.pq

![Function](https://github.com/tirnovar/m-custom-functions/blob/master/src/img/GetUserDataFromGraphAPI-7.png)

- And you are done!

![Users](https://github.com/tirnovar/m-custom-functions/blob/master/src/img/GetUserDataFromGraphAPI-8.png)
