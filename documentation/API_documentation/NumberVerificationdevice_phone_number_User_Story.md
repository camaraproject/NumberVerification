# Number Verification Device Phone Number API User Story

| **Item** | **Details** |
| ---- | ------- |
| ***Summary*** | As an enterprise application developer, I want to retrieve the phone number associated with the line from which the call was made, so that I can ensure that I obtain the correct phone number and avoid fraud e.g. identity theft. |

| ***Roles, Actors and Scope*** | **Roles:** Customer:User, Customer:BusinessManager, Customer:Administrator<br> **Actors:** Application service providers, hyperscalers, application developers, end users. <br> **Scope:**  <br>-Returns the phone number associated with the access token so API clients can get the phone number and verify it themselves. |
| ***Pre-conditions*** |The preconditions are listed below:<br><ol><li>The Customer:BusinessManager and Customer:Administrator have been onboarded to the CSP's API platform.</li><li>The Customer:BusinessManager has successfully subscribed to the Number Verification product from the product catalog.</li><li>The Customer:Administrator has onboarded the Customer:User to the platform.</li><li>The Customer:user performs an authorization request to CSP</li><li> The CSP checked access & user approval then provide access token to the Customer:user </li><li> The Customer:user get the access token based on network authentication to ensure secure access of the API.|
| ***Activities/Steps*** | **Starts when:** The customer application makes a POST device phone number via the number verification API.<br>**Ends when:** The Number verification server answers providing the phone number corresponding to the one of the line from which the request was triggered. The customer application can check if this number corresponds to the one keyed by the user.|
| ***Post-conditions*** | The customer application could continue offering its service to the user with the confirmation of the user phone number.  |

| ***Exceptions*** | Several exceptions might occur during the Number Verification API operations<br>- Unauthorized: Not valid credentials (e.g. use of already expired access token).<br>- Invalid input: Not valid input data to invoke operation (e.g. phone number without the '+' prefix).<br>- Not able to provide: Client authentication was not performed via mobile network. Not working on mobile hotspot (tethering) neither Wifi nor VPN mobile connections|
