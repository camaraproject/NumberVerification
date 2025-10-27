Feature: CAMARA Number Verification API, vwip - Operation phoneNumberShare

  # Input to be provided by the implementation to the tester
  #
  # References to OAS spec schemas refer to schemas specified in
  # /code/API_definitions/number-verification.yaml
  #
  # Testing assets:
  # * a valid testing phone number supported by the service

  Background: Common phoneNumberShare setup
    Given the resource "/number-verification/vwip" as base url
    And the header "Content-Type" is set to "application/json"
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" complies with the schema at "#/components/schemas/XCorrelator"

  # Generic success scenario

  @phone_number_share_01_generic_success_scenario
  Scenario: Common validations for any success scenario
    Given a valid phone number supported by the service, identified by the token
    When the request "phoneNumberShare" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/NumberVerificationShareResponse"

  # Scenarios testing specific situations
  @phone_number_share_02_success_scenario
  Scenario: Validate success scenario
    Given a valid phone number supported by the service, identified by the token
    And the token has been obtained by a supported authentication method
    When the request "phoneNumberShare" is sent
    Then the response status code is 200
    And the response property "$.devicePhoneNumber" is equal to the phone number associated with the access token

  # Generic 401 errors

  @phone_number_verify_401.1_no_authorization_header
  Scenario: No Authorization header
    Given the header "Authorization" is removed
    When the request "phoneNumberShare" is sent
    Then the response status code is "401"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @phone_number_verify_401.2_expired_access_token
  Scenario: Expired access token
    Given the header "Authorization" is set to an expired access token
    When the request "phoneNumberShare" is sent
    Then the response status code is "401"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @phone_number_verify_401.3_invalid_access_token
  Scenario: Invalid access token
    Given the header "Authorization" is set to an invalid access token
    When the request "phoneNumberShare" is sent
    Then the response status code is "401"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  # Generic 403 errors

  @phoneNumberShare_403.1_invalid_token_permissions
  Scenario: Access token does not have the required permissions
    Given the header "Authorization" is set to an access token without the required scope
    When the request "phoneNumberShare" is sent
    Then the response status code is "403"
    And the response property "$.status" is 403
    And the response property "$.code" is "PERMISSION_DENIED"
    And the response property "$.message" contains a user friendly text

  # Other specific 403 errors

  @phoneNumberShare_403.2_not_authenticated_using_network_or_sim_based_authentication
  Scenario: Response error when the token has not been obtained by a supported authentication method
    Given the header "Authorization" is set to a token for which neither Network-based nor SIM-based authentication was used
    When the request "phoneNumberShare" is sent
    Then the response status code is "403"
    And the response property "$.status" is 403
    And the response property "$.code" is "NUMBER_VERIFICATION.USER_NOT_AUTHENTICATED_BY_MOBILE_NETWORK"
    And the response property "$.message" contains a user friendly text
