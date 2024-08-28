

@NumberVerification_verify
Feature: Camara Number Verification API verify

# Input to be provided by the implementation to the tests
# References to OAS spec schemas refer to schemas specified in
# https://raw.githubusercontent.com/camaraproject/NumberVerification/main/code/API_definitions/number-verification.yaml
#
# Implementation indications:
# * api_root: API root of the server URL
#
# Testing assets:
# * a mobile device with SIM card with NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER1
# * a mobile device with SIM card with NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER2
# * a mobile device with SIM card with NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER_HASHED1
# * a mobile device with SIM card with NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER_HASHED2



  Background: Common Number Verification verify setup
    Given the resource "/number-verification/v0"  as  base url
    And the header "Content-Type" is set to "application/json"
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" is set to a UUID value
    And the request body is compliant with the schema NumberVerificationRequestBody
    And the response body is compliant with the schema NumberVerificationMatchResponse
    And the header "x-correlator" is set to a UUID value
    And NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER1 is compliant with the schema DevicePhoneNumber
    And NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER2 is compliant with the schema DevicePhoneNumber
    And NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER1 is different to NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER2

  @NumberVerification_verify0_phoneNumber_does_not_match_schema
  Scenario Outline: phoneNumber value does not comply with the schema
    Given the request body property "$.phoneNumber" is set to: <phone_number_value>
    When the HTTP "POST" request is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text
    And they acquired a valid access token associated with NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER1 through OIDC authorization code flow
    
    Examples:
      | phone_number_value |
      | string_value       |
      | 1234567890         |
      | +12334foo22222     |
      | +00012230304913849 |
      | 123                |
      | ++49565456787      |


  @NumberVerification_verify100_match_true
  Scenario:  verify phone number NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER1, network connection and access token matches NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER1
    Given they use the base url
    And the resource is "/verify"
    And one of the scopes associated with the access token is number-verification:verify
    When the HTTPS "POST" request is sent
    And the connection the request is sent over originates from a device with NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER1
    And the request body has the field phoneNumber with a value of NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER1
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response body complies with the OAS schema at "/components/schemas/NumberVerificationMatchResponse"
    Then the response status code is 200
    And the response property "$.devicePhoneNumberVerified" is true

  @NumberVerification_verify300_match_hashed_true
  Scenario:  verify hashed phone number hashed NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER1, network connection and access token matches NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER1
    Given they use the base url
    And the resource is "/verify"
    And one of the scopes associated with the access token is number-verification:verify
    When the HTTPS "POST" request is sent
    And the connection the request is sent over originates from a device with NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER1
    And the request body has the field hashedPhoneNumber with a value of NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER_HASHED1
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response body complies with the OAS schema at "/components/schemas/NumberVerificationMatchResponse"
    Then the response status code is 200
    And the response property "$.devicePhoneNumberVerified" is true


  @NumberVerification_verify101_match_false
  Scenario:  verify phone number NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER1 but access token is associated with NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER2
    Given they use the base url
    And the resource is "/verify"
    And one of the scopes associated with the access token is number-verification:verify
    When the HTTPS "POST" request is sent
    And the connection the request is sent over originates from a device with NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER1
    And the request body has the field phoneNumber with a value of NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER2
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response body complies with the OAS schema at "/components/schemas/NumberVerificationMatchResponse"
    Then the response status code is 200
    And the response property "$.devicePhoneNumberVerified" is false

  @NumberVerification_verify301_match_false
  Scenario:  verify hashed phone number NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER1 but access token is associated with NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER2
    Given they use the base url
    And the resource is "/verify"
    And one of the scopes associated with the access token is number-verification:verify
    When the HTTPS "POST" request is sent
    And the connection the request is sent over originates from a device with NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER1
    And the request body has the field hashedPhoneNumber with a value of NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER_HASHED2
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response body complies with the OAS schema at "/components/schemas/NumberVerificationMatchResponse"
    Then the response status code is 200
    And the response property "$.devicePhoneNumberVerified" is false

  @NumberVerification_verify200_missing_phone_number_in_request
  Scenario:  verify phone number but no phonenumber in request
    Given they use the base url
    And the resource is "/verify"
    And one of the scopes associated with the access token is number-verification:verify
    When the HTTPS "POST" request is sent
    And the connection the request is sent over originates from a device with NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER1
    And the request body has NO the field phoneNumber or hashedPhoneNumber
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response body complies with the OAS schema at "/components/schemas/ErrorInfo"
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @NumberVerification_verify201_missing_scope
  Scenario:  verify phone number with valid access token but scope number-verification:verify is missing
    Given they use the base url
    And the resource is "/verify"
    And none of the scopes associated with the access token is number-verification:verify
    When the HTTPS "POST" request is sent
    And the connection the request is sent over originates from a device with NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER1
    And the request body has the field phoneNumber with a value of NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER1
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response body complies with the OAS schema at "/components/schemas/ErrorInfo"
    Then the response status code is 403
    And the response property "$.status" is 403
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" is "Request not authenticated due to missing, invalid, or expired credentials."

  @NumberVerification_verify202_expired_access_token
  Scenario:  verify phone number with expired access token
    Given they use the base url
    And the resource is "/verify"
    And one of the scopes associated with the access token is number-verification:verify
    When the HTTPS "POST" request is sent
    And the connection the request is sent over originates from a device with NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER1
    And the access token has expired
    And the request body has the field phoneNumber with a value of NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response body complies with the OAS schema at "/components/schemas/ErrorInfo"
    Then the response status code is 401
    And the response property "$.status" is 401
    And the response property "$.code" is "AUTHENTICATION_REQUIRED"
    And the response property "$.message" is "New authentication is required."

  @NumberVerification_verify203_both_phone_number_and_hashed_in_request
  Scenario:  verify phone number but no phonenumber in request
    Given they use the base url
    And the resource is "/verify"
    And one of the scopes associated with the access token is number-verification:verify
    When the HTTPS "POST" request is sent
    And the connection the request is sent over originates from a device with NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER1
    And the request body has the field phoneNumber with a value of NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER1
    And the request body has the field hashedPhoneNumber with a value of NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER_HASHED1
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response body complies with the OAS schema at "/components/schemas/ErrorInfo"
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @NumberVerification_phone_number_verify204_no_phonenumber_associated_with_access_token
  Scenario:  verify phone number with valid access token that is not associated with a phone number
    Given they use the base url
    And the resource is "/verify"
    And one of the scopes associated with the access token is number-verification:verify
    When the HTTPS "GET" request is sent
    And the connection the request is sent over originates from a device with NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER1
    And the access token is not associated with a phone number
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response body complies with the OAS schema at "/components/schemas/ErrorInfo"
    Then the response status code is 403
    And the response property "$.status" is 403
    And the response property "$.code" is "INVALID_TOKEN_CONTEXT"
    And the response property "$.message" is "Phone number cannot be deducted from access token context."
    

  @NumberVerification_phone_number_verify205_must_have_used_network_authentication
  Scenario:  verify phone number with valid access token but network authentication was not used
    Given they use the base url
    And the resource is "/verify"
    And one of the scopes associated with the access token is number-verification:verify
    When the HTTPS "GET" request is sent
    And the connection the request is sent over originates from a device with NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER1
    And the information, e.g. authentication method reference, associated with the access token indicates that network authentication was NOT used
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response body complies with the OAS schema at "/components/schemas/ErrorInfo"
    Then the response status code is 403
    And the response property "$.status" is 403
    And the response property "$.code" is "NUMBER_VERIFICATION.USER_NOT_AUTHENTICATED_BY_MOBILE_NETWORK"
    And the response property "$.message" is "The subscription must be identified via the mobile network to use this servicet."
