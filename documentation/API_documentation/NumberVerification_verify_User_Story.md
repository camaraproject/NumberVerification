# Number Verification Verify API User Story

| **Item** | **Details** |
| ---- | ------- |
| ***Summary*** | As an enterprise application developer, I want to verify the phone number associated with the phone from which the call was made, so I can get a proof of possession of the phone number. |

| ***Roles, Actors and Scope*** | **Roles:** Customer:User, Customer:BusinessManager, Customer:Administrator<br> **Actors:** Application service providers, hyperscalers, application developers, end users. <br> **Scope:**  <br> - Verifies if the specified phone number (plain text or hashed format) matches the one that the user is currently using. |
| ***Pre-conditions*** |The preconditions are listed below:<br><ol><li>The Customer:BusinessManager and Customer:Administrator have been onboarded to the CSP's API platform.</li><li>The Customer:BusinessManager has successfully subscribed to the Number Verification product from the product catalog.</li><li>The Customer:Administrator has onboarded the Customer:User to the platform.</li><li>The Customer:User performs an authorization request to CSP.</li><li> The CSP checks access & user approval then provide access token to the Customer:User </li><li> The Customer:User get the access token based on network authentication to ensure secure access of the API.|

| ***Activities/Steps*** | **Starts when:** The customer application makes a POST verify via the number verification API providing in the request the phone number provided by the user on the application. This input could be hashed or plain.<br>**Ends when:** The Number verification server answers if the phone number provided corresponds to the one of the line from which the request was triggered. |
| ***Post-conditions*** | The customer application could continue offering its service to the user with the confirmation of the user phone number.  |
| ***Exceptions*** | Several exceptions might occur during the Number Verification API operations<br>- Unauthorized: Not valid credentials (e.g. use of already expired access token).<br>- Invalid input: Not valid input data to invoke operation (e.g. phone number without the '+' prefix).<br>- Not able to provide: Client authentication was not performed via mobile network. Not working on mobile hotspot (tethering) neither Wifi nor VPN mobile connections |
