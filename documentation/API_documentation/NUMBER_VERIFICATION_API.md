
---------

**Please note that this document is deprecated. API documentation is now in the YAML file**

---------

# Overview

Number Verification API is used to verify that the provided **mobile phone number** is the one used in the device. It verifies that the user is using a device with the same *mobile phone number* as it is declared.
It also makes it possible for a Service provider to verify the number itself by returning the phone number associated to the authenticated user's access token.

## 1\. Introduction

Number Verification API performs real-time checks to verify the phone number of the mobile device being used to access a service provider (SP) service, where the mobile device is accessing the *service provider* over a mobile network (WiFi connections are out of this API scope) either by getting the comparison result or receiving the phone number of the device that it is used, so they can verify it themselves.

It uses direct mobile network connections to verify possession of a phone number in the background without requiring user interaction. There are neither OTPs (One-time passwords) received by SMS nor authenticator app downloads, so it is much simpler. It can be used at sign up, login, or transaction time to validate that a user's SIM (Subscriber Identity Module) is both actively connected to the mobile network and not spoofed or cloned.

**Out of scope:**

Not working on mobile hotspot (tethering) neither Wifi nor VPN mobile connections

## 2\. Quick Start

The usage of the API is based on several resources.

Before starting to use the API, the developer needs to know about the below specified details:

**API service endpoint**

Two endpoints are defined in Number Verification API:

- POST /number-verification/v0/verify : Verifies if the specified phone number (plain text or hashed format) matches the one that the user is currently using.
- GET /number-verification/v0/device-phone-number : Returns the phone number associated with the access token so API clients can verify the number themselves.

**Authentication**

Security access keys such as OpenId Connect 3-legged Access Tokens used by Client applications to invoke this API with dedicated scope. Client **must use network based authentication methods** to use this service. 

Sample API invocations are presented in Section 4.6.

## 3\. Authentication and Authorization

Number Verification API uses OpenId Connect 2.0 authorization code grant which allows three-legged Access Tokens. [[1]](#1)

## 4\. API Documentation

### 4.1 API Version

0.1.0

### 4.2 Details

#### 4.2.1 Endpoint Definition

Following table defines API endpoints of exposed REST based for Number Verification API operations.

| **Endpoint** | **Operation** | **Description** |
| -------- | --------- | ----------- |
| POST /number-verification/v0/verify | **Request to verify a number** | Create request in order to verify if the specified phone number (plain text or hashed format) matches the one that the user is currently using |
| GET /number-verification/v0/device-phone-number | **Request to get the device phone number** | Create a request to get the phone number associated with the access token so the API clients can verify the number themselves |


#### Number Verification API Resource Operations:
<br>

| **Request to verify a number** |
| -------------------------- |
| **HTTP Request**<br> POST /number-verification/v0/verify<br>**Query Parameters**<br> No query parameters are defined.<br>**Path Parameters**<br> No path parameters are defined.<br>**Request Body Parameters**<br> **One of:** <br> **phoneNumber**: A phone number belonging to the user. 'E164 with +' format.<br> **hashedPhoneNumber**: Hashed phone number. SHA-256 (in hexadecimal representation) of the mobile phone number in 'E164 with +' format.

 <br>**Response**<br> **200: OK**<br>  Response body: <br>**devicePhoneNumberVerified** : Boolean <br> **400:** **INVALID_ARGUMENT** <br> **401:** **UNAUTHENTICATED** <br> **403:** **PERMISSION_DENIED** <br> **403:** **NUMBER_VERIFICATION.USER_NOT_AUTHENTICATED_BY_MOBILE_NETWORK** <br> **403:** **NUMBER_VERIFICATION.INVALID_TOKEN_CONTEXT** <br> **500:** **INTERNAL**<br> **503:** **UNAVAILABLE**<br> **504:** **TIMEOUT**<br>
<br>

<br>

| **Request to get the device phone number** |
| -------------------------- |
| **HTTP Request**<br> GET /number-verification/v0/device-phone-number<br>**Query Parameters**<br> No query parameters are defined.<br>**Path Parameters**<br> No path parameters are defined.<br>**Request Body Parameters**<br> No body

 <br>**Response**<br> **200: OK**<br>  Response body: <br>**devicePhoneNumber** : The device phone number associated to the access token. 'E164 with +' format. <br> **400:** **INVALID_ARGUMENT**<br> **401:** **UNAUTHENTICATED** <br> **403:** **PERMISSION_DENIED** <br> **403:** **NUMBER_VERIFICATION.USER_NOT_AUTHENTICATED_BY_MOBILE_NETWORK** <br>  **403:** **NUMBER_VERIFICATION.INVALID_TOKEN_CONTEXT** <br> **500:** **INTERNAL** <br> **503:** **UNAVAILABLE**<br> **504:** **TIMEOUT**<br>
<br>

<br>

### 4.3 Errors

Since CAMARA Number Verification API is based on REST design principles and blueprints, well defined HTTP status codes and families specified by community are followed [[2]](#2).

Details of HTTP based error/exception codes for Number Verification API are described in Section 4.2 of each API REST based method.
Following table provides an overview of common error names, codes, and messages applicable to Number Verification API.

| No | Error Name | Error Code | Error Message |
| --- | ---------- | ---------- | ------------- |
|1	|400 |	INVALID_ARGUMENT |	"Client specified an invalid argument, request body or query param" |
|2	|401 |	UNAUTHENTICATED |	"Request not authenticated due to missing, invalid, or expired credentials" |
|3	|403 |	PERMISSION_DENIED |	"Client does not have sufficient permissions to perform this action" |
|4	|403 |	NUMBER_VERIFICATION.USER_NOT_AUTHENTICATED_BY_MOBILE_NETWORK |	"Client must authenticate via the mobile network to use this service" |
|5	|403 |	NUMBER_VERIFICATION.INVALID_TOKEN_CONTEXT |	"Phone number cannot be deducted from access token context" |
|6	|500 |	INTERNAL | "Server error" |
|7	|503 |	UNAVAILABLE | "Service unavailable" |
|8	|504 |	TIMEOUT | "Request timeout exceeded. Try later." |

<br>

### 4.4 Policies

N/A
<br>

### 4.5 Code Snippets
<br>
<span class="colour" style="color:rgb(36, 41, 47)">Snippets elaborates REST based API call with "*curl"* to request  </span>


Please note, the credentials for API authentication purposes need to be adjusted based on target security system configuration.

| Snippet 1. Request code  |
| ----------------------------------------------- |
| curl -X 'POST' `https://sample-base-url/number-verification/v0/verify`   <br>    -H 'accept: application/json' <br>    -H 'Content-Type: application/json'<br>    -H "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbG...."<br>    -d '{ "hashedPhoneNumber": "32f67ab4e4312618b09cd23ed8ce41b13e095fe52b73b2e8da8ef49830e50dba"}'  |
| The response will be: <br> 200 <br>   -d '{ "devicePhoneNumberVerified": true }'|
<br>

| Snippet 2. Validate code  |
| ----------------------------------------------- |
| curl -X 'GET' `https://sample-base-url/number-verification/v0/device-phone-number`   <br>    -H 'accept: application/json' <br>    -H 'Content-Type: application/json'<br>    -H "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbG...."<br> |
| The response will be: <br> 200 <br>   -d '{ "devicePhoneNumber": "+346661113334" }'|
<br>



### 4.6 FAQs

(FAQs will be added in a later version of the documentation)

### 4.7 Terms

N/A

### 4.8 Release Notes

N/A


## References


<a name="1">[1] [CAMARA Commonalities : Authentication and Authorization Concept for Service APIs](https://github.com/camaraproject/WorkingGroups/blob/main/Commonalities/documentation/Working/CAMARA-AuthN-AuthZ-Concept.md) <br>
<a name="2">[2] [HTTP Status codes spec](https://restfulapi.net/http-status-codes/) <br>
