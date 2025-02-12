@NumberVerification_device_phone_number_share
Feature: Camara Number Verification API device phone number share

# Input to be provided by the implementation to the tests
# References to OAS spec schemas refer to schemas specified in
# /code/API_definitions/number-verification.yaml
#
# Implementation indications:
# * api_root: API root of the server URL
#
# Testing assets:
# * a mobile device with SIM card with NUMBERVERIFY_SHARE_PHONENUMBER1
# * a mobile device with SIM card with NUMBERVERIFY_SHARE_PHONENUMBER2

  Background: Common Number Verification phone number share setup
    Given the resource "/device-phone-number/v1.1.0-rc.1"  as  base url
    And the header "Content-Type" is set to "application/json"
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" is set to a UUID value
    And the request body is compliant with the schema NumberVerificationRequestBody
    And the response body is compliant with the schema NumberVerificationMatchResponse
    And the header "x-correlator" is set to a UUID value
    And NUMBERVERIFY_SHARE_PHONENUMBER1 is compliant with the schema DevicePhoneNumber
    And NUMBERVERIFY_SHARE_PHONENUMBER2 is compliant with the schema DevicePhoneNumber
    And NUMBERVERIFY_SHARE_PHONENUMBER1 is different to NUMBERVERIFY_SHARE_PHONENUMBER2
    And they acquired a valid access token associated with NUMBERVERIFY_SHARE_PHONENUMBER1 through OIDC authorization code flow

  @NumberVerification_phone_number_share100_match_true
  Scenario:  share phone number NUMBERVERIFY_SHARE_PHONENUMBER1, network connection and access token matches NUMBERVERIFY_SHARE_PHONENUMBER1
    Given they use the base url
    And the resource is "/device-phone-number"
    And one of the scopes associated with the access token is number-verification:device-phone-number:read
    When the HTTPS "GET" request is sent
    And the connection the request is sent over originates from a device with NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER1
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/NumberVerificationShareResponse"
    Then the response status code is 200
    And the response property "$.devicePhoneNumber" is set to NUMBERVERIFY_SHARE_PHONENUMBER1

  @NumberVerification_phone_number_share201_missing_scope
  Scenario:  share phone number with valid access token but scope number-verification:device-phone-number:read is missing
    Given they use the base url
    And the resource is "/device-phone-number"
    And none of the scopes associated with the access token is number-verification:device-phone-number:read
    When the HTTPS "GET" request is sent
    And the connection the request is sent over originates from a device with NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER1
    And the request body has the field phoneNumber with a value of NUMBERVERIFY_SHARE_PHONENUMBER1
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response body complies with the OAS schema at "/components/schemas/ErrorInfo"
    Then the response status code is 403
    And the response property "$.status" is 403
    And the response property "$.code" is "PERMISSION_DENIED"
    And the response property "$.message" is "Client does not have sufficient permissions to perform this action."

  @NumberVerification_phone_number_share202_expired_access_token
  Scenario:  share phone number with expired access token
    Given they use the base url
    And the resource is "/device-phone-number"
    And one of the scopes associated with the access token is number-verification:device-phone-number:read
    When the HTTPS "GET" request is sent
    And the connection the request is sent over originates from a device with NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER1
    And the access token has expired
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response body complies with the OAS schema at "/components/schemas/ErrorInfo"
    Then the response status code is 401
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" is "Request not authenticated due to missing, invalid, or expired credentials."

#  @NumberVerification_phone_number_share203_no_phonenumber_associated_with_access_token
#  Note: As 403 INVALID_TOKEN_CONTEXT code was removed this test is not anymore relevant.
#  Scenario:  share phone number with valid access token that is not associated with a phone number
#    Given they use the base url
#    And the resource is "/device-phone-number"
#    And one of the scopes associated with the access token is number-verification:device-phone-number:read
#    When the HTTPS "GET" request is sent
#    And the connection the request is sent over originates from a device with NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER1
#    And the access token is not associated with a phone number
#    And the response header "x-correlator" has same value as the request header "x-correlator"
#    And the response header "Content-Type" is "application/json"
#    And the response body complies with the OAS schema at "/components/schemas/ErrorInfo"
#    Then the response status code is 403
#    And the response property "$.status" is 403
#    And the response property "$.code" is "INVALID_TOKEN_CONTEXT"
#    And the response property "$.message" is "Phone number cannot be deducted from access token context."

  @NumberVerification_phone_number_share205_must_have_used_network_authentication
  Scenario:  share phone number with valid access token but network authentication was not used
    Given they use the base url
    And the resource is "/device-phone-number"
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
