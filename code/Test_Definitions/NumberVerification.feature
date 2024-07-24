

@NumberVerification
Feature: Camara Number Verification API

# Input to be provided by the implementation to the tests
# References to OAS spec schemas refer to schemas specified in
# https://raw.githubusercontent.com/camaraproject/NumberVerification/main/code/API_definitions/number_verification.yaml

  Background: Common Number Verification setup
    Given the resource "/number-verification/v0"  as  base url
    And the header "Content-Type" is set to "application/json"
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" is set to a UUID value
    And the request body is compliant with the schema NumberVerificationRequestBody
    And the response body is compliant with the schema NumberVerificationMatchResponse
    And NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER1 is compliant with the schema DevicePhoneNumber
    And NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER2 is compliant with the schema DevicePhoneNumber
    And NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER1 is different to NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER2

  @NumberVerification_verify_nooptout_match_true
  Scenario:  verify phone number NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER1
    Given they use the base url with path /verify over a mobile connection
    When they verify NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER1
    And the mobile connection is associated to NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER1
    And the subscriber associated with NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER1 has NOT opted-out of numberverify_verify
    And the request body has the field phoneNumber with a value of NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER1
    And the access_token is associated with NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER1
    Then Response code is 200
    And devicePhoneNumberVerified is true

  @NumberVerification_verify_nooptout_match_false
  Scenario:  verify phone number NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER1
    Given they use the base url with path /verify over a mobile connection
    When they verify NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER1
    And the mobile connection is associated to NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER1
    And the subscriber associated with NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER1 has NOT opted-out of numberverify_verify
    And the request body has the field phoneNumber with a value of NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER2
    And the access_token is associated with NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER1
    Then Response code is 200
    And devicePhoneNumberVerified is false

  @NumberVerification_verify_empty_request_body_nooptout_match_true
  Scenario:  verify phone number NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER1
    Given they use the base url with path /verify over a mobile connection
    When they verify NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER1
    And the mobile connection is associated to NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER1
    And the subscriber associated with NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER1 has NOT opted-out of numberverify_verify
    And the request body is empty
    And the access_token is associated with NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER1
    Then Response code is 200
    And devicePhoneNumberVerified is true


  # subscriber opted out cases

  @NumberVerification_verify_optout_match_true
  Scenario:  verify phone number NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER1
    Given they use the base url with path /verify over a mobile connection
    When they verify NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER1
    And the mobile connection is associated to NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER1
    And the subscriber associated with NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER1 has opted-out of numberverify_verify
    And the access_token is associated with NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER1
    And the access_token is associated with NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER1
    Then Response code is xxx
    And devicePhoneNumberVerified is true

  @NumberVerification_verify_optout_match_false
  Scenario:  verify phone number NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER1
    Given they use the base url with path /verify over a mobile connection
    When they verify NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER1
    And the mobile connection is NOT associated to NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER1
    And the subscriber associated with NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER1 has opted-out of numberverify_verify
    And the access_token is associated with NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER1
    And the access_token is associated with NUMBERVERIFY_VERIFY_MATCH_PHONENUMBER1
    Then Response code is xxx
    And devicePhoneNumberVerified is false

