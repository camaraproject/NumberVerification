# Number Verification Verify API User Story

| **Item** | **Details** |
| ---- | ------- |
| ***Summary*** | When the user uses an enterprise application (web application or mobile application) and the user enters their phone number, then as an enterprise application developer, I want to verify that the entered phone number is associated with the mobile connection. |

| ***Actors and Scope*** | **Actors:** Application service provider (ASP), ASP:User, ASP: BusinessManager, ASP:Administrator, Channel Partner, End-User, Communication Service Provider (CSP). <br> **Scope:**  <br> - Verifies if the specified phone number (plain text or hashed format) matches the one that the user is currently using. |
| ***Pre-conditions*** |The preconditions are listed below:<br><ol><li>The ASP:BusinessManager and ASP:Administrator have been onboarded to the CSP's API platform via (or not) a Channel Partner.</li><li>The ASP:BusinessManager has successfully subscribed to the Number Verification product from the CSP's product catalog via (or not) a Channel Partner.</li><li>The ASP:Administrator has onboarded the ASP:User to the CSP API platform via (or not) a Channel Partner.</li><li>The ASP:User performs an authorization request to CSP.</li><li> The CSP checks access & End-User approval then provide access token to the ASP:User </li><li> The ASP:User get the access token, via (or not) the Channel Partner, based on network authentication to ensure secure access of the API.|
| ***Activities/Steps*** | **Starts when:** The ASP:User makes a POST request via the number verification API providing in the request the phone number provided by the End-User on the ASP:User. This request could be done via (or not) the Channel Partner. This input could be hashed or plain.<br>**Ends when:** The CSP's Number Verification Server responds to confirm whether the provided phone number matches the end-user's device from which the request was initiated or not. |
| ***Post-conditions*** | The ASP:User could continue offering its service to the End-User with the confirmation of the user phone number.  |
| ***Exceptions*** | Several exceptions might occur during the Number Verification API operations<br>- Unauthorized: Not valid credentials (e.g. use of already expired access token).<br>- Invalid input: Not valid input data to invoke operation (e.g. phone number without the '+' prefix).<br>- Not able to provide: Client authentication was not performed via mobile network. Not working on mobile hotspot (tethering) neither Wifi nor VPN mobile connections |