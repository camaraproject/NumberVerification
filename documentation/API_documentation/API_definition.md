# Reference
CAMARA Number Verify is based on Mobile Connect Verified MSISDN standardized product:

[IDY.54](assets/docs/(placeholder4MCspec).docx)

**IDY.54 Mobile Connect Verified MSISDN Definition and Technical Requirements** 

## About Mobile Connect

Mobile Connect is a worldwide initiative by Mobile Operators to bring a wide portfolio of Identity services to market that enable SPs and End-Users to transact with one-another more securely through strong authentication, authorisation and exchange of attributes, subject to User consent.

The Mobile Connect architecture consists of a Core framework around which additional components can be added to support the different Mobile Connect services as well as other API based services that delivers value to the customer. The Core framework is based upon the OpenID Connect (OIDC) protocol suite and allows Users to be identified by their MSISDN (or a related Pseudonymous Customer Reference) to enable authentication on their mobile device. Attributes sharing services are based upon the OAUTH2.0 framework - Client Credentials grant.

## Number Verify / Verified MSISDN definition

Mobile Connect Verified MSISDN allows Developer // Service Provider (SP) to verify the MSISDN (phone number) of the device connected to the mobile data network through which a User is accessing an SP service. In doing so, it enables the SP to check that the device being used to access a particular SP User account belongs to the account holder. Such a service can also be used by theSP for verifying the User’s device as a complementary service when a User is being authenticated.

Mobile Connect Verified MSISDN is defined as two service variants:

- **Verified MSISDN Match**: in which the Mobile Operator compares the MSISDN associated with the mobile device against that provided by the SP in the service request1. The MSISDN can be supplied in an E164 format [5] or in a hashed form. Verified MSISDN Match ensures no data is shared by the Mobile Operator.

Note that the Verified MSISDN service only works for devices which have an active mobile data bearer. It will not work via another data connection such as WiFi.

## Use Case examples

Mobile Connect Verified MSISDN supports a range of practical use cases including:

    1. Android Account Setup 
    2. Mobile Banking App installation and password-less login 
    3. Android password-less login
    4. RCS client installation / configuration
    5. Posting online ad or reviews on a website
    6. Verified MSISDN service as the second factor authentication 

Some examples are listed below in more detail to explain the use of Verified MSISDN.

### Android device upgrade (Google)

Verified MSISDN service could be used as an additional authentication step to provide more confidence to Google when a User first logs in on a new device with their Google credentials. When upgrading to a new/different Android phone, the User needs to enter their Google credentials to personalize the device - at this point, Google need additional confirmation that the individual entering the credentials is the legitimate account owner and not an attacker.

Google typically solve this issue through the use of SMS OTP but would prefer to use an Mobile Operator API such as Verified MSISDN to verify the association of device to the User without creating friction within the User experience when upgrading to a new Android phone.

### Password-less login

A separate but related problem is that it is quite common for a User to forget their Google credentials altogether and need to establish a new set (and new identity) in order to activate their Android device - this creates friction for the User, but also presents a service continuity issue for Google.

An alternative approach for verifying a new Android device would be for Google to adopt the User's phone number as the username, and possession/control of the Android device associated with that phone number as an implicit factor of authentication. This approach is simple and can then be combined with a lightweight knowledge factor (e.g., related to their Google or mobile account) to sign the User in and mitigate SIM swap fraud.

### Mobile Banking App & Apple/Android Pay installation

Similar to the Android upgrade use case, whenever a User wishes to install and/or configure a new SP app on their device, it is important that the SP can check that the device on which the app is being installed is associated with the User in question to mitigate against an attacker gaining access to a User's account by entering the User's credentials (username/password) via their own device. Mobile banking is a good example of this, the bank needing to ensure that the device upon which a mobile banking app is being installed is associated with the same phone number as on file for the bank account for that User.

A similar use case is where a User requests their debit/credit card to be tokenised and installed on their mobile phone (e.g., for use within Apple Pay, Samsung Pay, Android Pay etc.) and it is important that the issuing bank can verify that the User making the request is the same as the cardholder – by verifying that the phone number associated with the device upon which the debit/credit card will be installed is the same as the phone number on file for the cardholder (and matching other attributes such as name & address registered against that phone number), the issuing bank can mitigate against fraud.

## Verified MSISDN Functional Description

### Verified MSISDN Service Flow

The SP must initiate the Verified MSISDN request via the User’s mobile device which is directly connected to the mobile data network. The Mobile Operator ID GW must support **HTTP Header enrichment or a similar mechanism to be able to extract the User’s MSISDN from the mobile data network.** Verified MSIDN will not work if the device is on Wi-Fi or on a mobile hotspot.

Because Mobile Connect Verified MSISDN requires the use of the mobile data network it may be that the SP app includes a feature to allow switching the data bearer to ensure that the mobile data network is used.

**Figure 1** shows a high-level flow for a Verified MSISDN service request. The use case shown is one of registering a mobile app to allow password-less log-in. 
- This User is installing an SP’s mobile app on their device and in response to the prompt, the User enters their phone number.
- The SP educates the User about the need to perform number verification whenever the User attempts to login in the future. The SP provides further details such as revocation mechanism in a linked page (shown as “Learn more”).
- The User is asked to provide long-lived consent to the SP. The use of data needs to be clearly stated in terms of the service and the privacy policy.

![Figure 1 - Mobile Connect Verified MSISDN Service Flow](./assets/images/figure1.png)

The service flow is as follows:

- The SP’s app initiates a Mobile Connect Verified MSISDN service request towards the Mobile Operator’s ID GW Authorization endpoint using Mobile Connect Device-Initiated mode. The SP specifies the service required using the scope parameter to indicate whether Verified MSISDN Share, Verified MSISDN Match (Plain) or Verified MSISDN Match (Hashed) is required.
  - In this example, it is assumed that the SP already has the relevant Mobile Operator ID GW metadata and credentials to be able to initiate a service request to the correct Mobile Operator ID GW for that User. If not available, then this can be obtained by using the API Exchange Discovery service or by obtaining the details directly from the Mobile Operator.
- The Mobile Operator’s ID GW validates the request (i.e. that the SP has been registered with the Mobile Operator for the Mobile Connect Verified MSISDN service requested)
- The ID GW optionally can check that the source is from a known IP range (white listed)
- The Mobile Operator ID GW checks whether the User is registered for Mobile Connect
- If the MSISDN is not yet registered for Mobile Connect, based on ID GW policies a new Mobile Connect account may be created “on-the-fly” for that MSISDN. 
- The Mobile Operator retrieves the MSISDN from the IP Header (or uses an alternate mechanism to obtain the network-authenticated MSISDN for that device)

In order to be able to share (or match) User information with a SP, the User must give their consent. 

> **Figure 1** illustrates the option where the Mobile Operator ID GW captures User consent which, within the context of this use case, might be at initial registration for the SP service.
>
> User consent can also be captured by the SP, subject to the Mobile Operator’s ID GW consent policies and the contractual agreement with the SP. 
>
> Consent can also be long-lived where it exists for an extended period of time to provide a smoother User experience.
>
> If consent is not required (i.e. the User has already given their consent) then this step can be omitted.

- An Authorization Code is then returned to the SP as part of a standard Device-Initiated flow and the SP can then retrieve the ID Token and Access Token by make a Token Request to the ID GW Token endpoint.
- For Verified MSISDN Share the SP can then make a Resource Request to the Resource endpoint with the Access Token to fetch the MSISDN of the device. 
- For Verified MSISDN Match the SP can fetch the MSISDN match result by making a Resource Request with the Access Token and including the appropriate attribute identifier and value within the mc_claims parameter:
  - The attribute identifier is  “device_msisdn” with a value of the MSISDN in plain text if scope= ”mc_vm_match” was specified in the service request.
  - The attribute identifier is “device_msisdn_hash”  with a value of the hash of the MSISDN if scope=”mc_vm_match_hash” was specified in the service request.
- The Resource Server matches the attribute value with the previously extracted MSISDN or hash of the MSISDN extracted by the Authorization Server. If they match, the service returns a Boolean value “true” to the SP. 
- If the verification fails, then it returns a Boolean value “false” to the SP. 


### User Consent Management

The Mobile Connect Verified MSISDN service is designed to be used as a fraud check so typically, User consent will be captured by the SP (at registration and /or included within standard terms and conditions) and the service will be processed in the background without any explicit User consent.

## Verified MSISDN Service Specification

### OIDC Authorization Request Parameters - scope

The SP requests Mobile Connect Verified MSISDN services via the scope parameter in the Mobile Connect OIDC Authorization Request as per Table 1.

**Table 1 - Mobile Connect Verified MSISDN scope Values**
|Mobile Connect Verified MSISDN|OIDC Authorization Request scope Parameter|
|:---|:---|
|Mobile Connect Verified MSISDN Match [plain]|“mc_vm_match”|
|Mobile Connect Verified MSISDN Match [hashed]|“mc_vm_match_hash”|

### API details

Mobile Connect Verified MSISDN is only supported in Device-Initiated mode where the User is accessing an online SP service via their mobile device using a mobile data connection.

[MC Device Initiated mode](assets/yaml/MC_di_v2.3-build_14.yaml)

### Verified MSISDN Match details

For Mobile Connect Verified MSISDN Match, the MSISDN that the SP wishes to match against the device MSISDN captured by the Mobile Operator ID GW is submitted as part of the Resource Request.

For Mobile Connect Verified MSISDN Match one of the attribute identifiers and associated value shown in **Table 2** must be included in the Resource Request depending upon the scope value specified in the OIDC Authorization Request. 

**Table 2 - Mobile Connect Verified MSISDN Match – Attribute Identifiers and Values for the Resource Request**

|Attribute Identifier|Type|Description|
|:---|:---:|:---|
|device_msisdn|String|The value is the MSISDN to be verified. E.164 format is RECOMMENDED|
|device_msisdn_hash|String|Hashed value of MSISDN to be verified. SHA256 algorithm recommended.|

The Resource Request contains a JSON Payload with the mc_claims parameter which contains the requested service scope value (e.g. “mc_vm_match_hash”) followed by the appropriate attribute identifier, as defined in **Table 2**, and the value (hashed value in this case) to be matched. For example, based on an Mobile Connect Verified MSISDN Match (Hashed) service request, the Resource Request would be as follows:

>POST /connect/mc_vm HTTP/1.1.
user-Agent: XXXXXXXXXX
Host: mc-idgw-Operator.example.com.
Authorization: Bearer LTRjZDMtNDUyYi1iNjk.
Content-Type: application/json.
Accept: application/json.
Content-Length: 73.
.
{
    "mc_claims":
    {
        "device_msisdn_hash":"3d84a3838599719df7deacc7fb91903bde5430a8c0e007c3eba93bce0c69c5a2"
        }
    }

based on an Mobile Connect Verified MSISDN Match (Plain) service request, the Resource Request would be as follows:

>POST /connect/mc_vm HTTP/1.1.
user-Agent: XXXXXXXXXX
Host: mc-idgw-Operator.example.com.
Authorization: Bearer LTRjZDMtNDUyYi1iNjk.
Content-Type: application/json.
Accept: application/json.
Content-Length: 73.
.
{
"mc_claims" : {
               "device_msisdn" : "+44123456789"
               }
} 


**Table 3** shows the attribute identifier and associated value that is returned in the Resource Response for Mobile Connect Verified MSISDN Match. The response is the same irrespective of whether plain text or hashed values were submitted in the Resource Request.

**Table 3 - Mobile Connect Verified MSISDN Match – Returned Attributes in the Resource Response**
|Attribute Identifier |Type|Usage Category|Description|
|:---|:---:|:---:|:---|
|device_msisdn_verified|Boolean|REQUIRED|Match result: “true” / “false”|

The following example shows the Resource Response for the Mobile Connect Verified MSISDN Match service. Note the same result is returned for both plain text and hashed variants.

>HTTP/1.1 200 OK.
Date: Tue, 03 Oct 2017 09:37:43 GMT.
Server: XXXXXXX
Expires: Thu, 19 Nov 1981 08:52:00 GMT.
Cache-Control: no-store, no-cache, must-revalidate, post-check=0, pre-check=0.
Pragma: no-cache.
Content-Length: xx.
Content-Type: application/json.
.
{
  "sub": "cd45a691-d311-4134-9a0c-2747e5110d22"
  "device_msisdn_verified": true
}

