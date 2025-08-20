Feature: CAMARA Number Verification API, v2.1.0-rc.1 - Operation phoneNumberVerify

  # Input to be provided by the implementation to the tester
  #
  # References to OAS spec schemas refer to schemas specified in
  # /code/API_definitions/number-verification.yaml
  #
  # Testing assets:
  # * a valid testing phone number supported by the service
  # * a valid testing hashed phone number supported by the service


  Background: Common phoneNumberVerify setup
    Given the resource "/number-verification/v2rc1" as base url
    And the header "Content-Type" is set to "application/json"
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" complies with the schema at "#/components/schemas/XCorrelator"
    And the request body is set by default to a request body compliant with the schema

  # Generic success scenario

  @phone_number_verify_01_generic_success_scenario
  Scenario: Common validations for any success scenario
    Given a valid phone number identified by the token and provided in the request body
    When the request "phoneNumberVerify" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/NumberVerificationMatchResponse"


  # Scenarios testing specific situations

  @phone_number_verify.02_validate_phone_number_success_true
  Scenario: Validate success with phone number when response is true
    Given a valid phone number supported by the service, identified by the token
    And the token has been obtained by a supported authentication method
    And the body property "$.phoneNumber" is set to the phone number identified by the access token
    When the request "phoneNumberVerify" is sent
    Then the response status code is 200
    And the response property "$.devicePhoneNumberVerified" == true

  @phone_number_verify.03_validate_phone_number_success_false
  Scenario: Validate success with phone number when response is false
    Given a valid phone number supported by the service, identified by the token
    And the token has been obtained by a supported authentication method
    And the body property "$.phoneNumber" is set to a valid phone number different from the one identified by the access token
    When the request "phoneNumberVerify" is sent
    Then the response status code is 200
    And the response property "$.devicePhoneNumberVerified" == false

  @phone_number_verify.04_validate_hashed_phone_number_success_true
  Scenario: Validate success with hashed phone number when response is true
    Given a valid phone number supported by the service, identified by the token
    And the token has been obtained by a supported authentication method
    And the body property "$.hashedPhoneNumber" is set to the phone number identified by the access token, hashed in SHA-256 (in hexadecimal representation)
    When the request "phoneNumberVerify" is sent
    Then the response status code is 200
    And the response property "$.devicePhoneNumberVerified" == true

  @phone_number_verify.05_validate_hashed_phone_number_success_false
  Scenario: Validate success with hashed phone number when response is false
    Given a valid phone number supported by the service, identified by the token
    And the token has been obtained by a supported authentication method
    And the body property "$.hashedPhoneNumber" is set to a valid phone number different from the one identified by the access token, hashed in SHA-256 (in hexadecimal representation)
    When the request "phoneNumberVerify" is sent
    Then the response status code is 200
    And the response property "$.devicePhoneNumberVerified" == false


  # Generic 400 errors

  @phone_number_verify_400.1_no_request_body
  Scenario: Missing request body
    Given the request body is not included
    When the request "phoneNumberVerify" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @phone_number_verify_400.2_empty_request_body
  Scenario: Empty object as request body
    Given the request body is set to "{}"
    When the request "phoneNumberVerify" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @phone_number_verify_400.3_invalid_request_non_existing_property
  Scenario: Error when request body contains a property but it is neither phoneNumber nor hashedPhoneNumber
    Given a valid testing phoneNumber supported by the service, identified by the token
    And the request body property "$.additional_property" is set to "foo_value"
    And the request body does not contain neither "$.phoneNumber" nor "$.hashedPhoneNumber"
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  # Other specific 400 errors

  @phone_number_verify_400.4_both_phone_number_and_hashed_in_request
  Scenario: Response error when phoneNumber and hashedPhoneNumber are provided together in the request body
    Given the request body property "$.phoneNumber" is set to a valid phone number
    And the same phone number is compliant with OAS schema at "#/components/schemas/PhoneNumber"
    And the request body property "$.hashedPhoneNumber" is set to a valid phone number compliant with OAS schema at "#/components/schemas/HashedPhoneNumber"
    When the request "phoneNumberVerify" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  # Generic 401 errors

  @phone_number_verify_401.1_no_authorization_header
  Scenario: No Authorization header
    Given the header "Authorization" is removed
    And the request body is set to a valid request body
    When the request "phoneNumberVerify" is sent
    Then the response status code is "401"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @phone_number_verify_401.2_expired_access_token
  Scenario: Expired access token
    Given the header "Authorization" is set to an expired access token
    And the request body is set to a valid request body
    When the request "phoneNumberVerify" is sent
    Then the response status code is "401"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @phone_number_verify_401.3_invalid_access_token
  Scenario: Invalid access token
    Given the header "Authorization" is set to an invalid access token
    And the request body is set to a valid request body
    When the request "phoneNumberVerify" is sent
    Then the response status code is "401"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  # Generic 403 errors

  @phoneNumberVerify_403.1_invalid_token_permissions
  Scenario: Access token does not have the required permissions
    Given the header "Authorization" is set to an access token without the required scope
    And the request body is set to a valid request body
    When the request "phoneNumberVerify" is sent
    Then the response status code is "403"
    And the response property "$.status" is 403
    And the response property "$.code" is "PERMISSION_DENIED"
    And the response property "$.message" contains a user friendly text

  # Other specific 403 errors

  @phoneNumberVerify_403.2_not_authenticated_using_network_or_sim_based_authentication
  Scenario: Response error when the token has not been obtained by a supported authentication method 
    Given the header "Authorization" is set to a token for which neither Network-based nor SIM-based authentication was used
    And the request body is set to a valid request body
    When the request "phoneNumberVerify" is sent
    Then the response status code is "403"
    And the response property "$.status" is 403
    And the response property "$.code" is "NUMBER_VERIFICATION.USER_NOT_AUTHENTICATED_BY_MOBILE_NETWORK"
    And the response property "$.message" contains a user friendly text

  # Error scenarios for management of input parameter phoneNumber

  @phone_number_verify_C02.01_phone_number_not_schema_compliant
  Scenario: Phone number value does not comply with the schema
    Given the header "Authorization" is set to a valid access token which does not identify a single phone number
    And the request body property "$.phoneNumber" does not comply with the OAS schema at "#/components/schemas/PhoneNumber"
    When the request "phoneNumberVerify" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text
