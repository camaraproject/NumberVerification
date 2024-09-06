# Changelog Number Verification API


## Table of contents

- **[r1.2](#r12)**
- **[r1.1](#r11)**
- **[v0.3.1](#v031)**


**Please be aware that the project will have frequent updates to the main branch. There are no compatibility guarantees associated with code in any branch, including main, until it has been released. For example, changes may be reverted before a release is published. For the best results, use the latest published release.**

# r1.2

## Release Notes

This release contains the definition and documentation of
* number-verification 1.0.0

The API definition(s) are based on
* Commonalities v0.4.0
* Identity and Consent Management v0.2.0

## number-verification 1.0.0

**number-verification 1.0.0 is the release of the first stable version of the NumberVerification API.**

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/NumberVerification/r1.2/code/API_definitions/number-verification.yaml&nocors)
  - [View it on Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/camaraproject/NumberVerification/r1.2/code/API_definitions/number-verification.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/NumberVerification/blob/r1.2/code/API_definitions/number-verification.yaml)

**Main Changes**

* API and test definitions updated to conform to the Commonalities v0.4.0 and Identity and Consent Management v0.2.0 guidelines included in the CAMARA Fall24 meta-release
* Additional documentation & test cases added.
* Changed name of the file itself from number_verification.yaml to number-verification.yaml


### Added

* User Story in documentation/API_documentation directory by @bigludo7 [PR118](https://github.com/camaraproject/NumberVerification/pull/118)
* Test Definition in Test_Definitions directory by @AxelNennker [PR124](https://github.com/camaraproject/NumberVerification/pull/124)

### Changed

* Aligned with CAMARA design guidelines & Identity Consent management by @AxelNennker 
* Make the '+' mandatory for the phone number by @fernandopradocabrillo [PR90](https://github.com/camaraproject/NumberVerification/pull/90)
* Cosmetic change following megalinter integration by @bigludo7 [PR103](https://github.com/camaraproject/NumberVerification/pull/103)
* Update Authorization and authentication part accordingly to ICM by @fernandopradocabrillo [PR88](https://github.com/camaraproject/NumberVerification/issues/88)
* Adding a pattern for PhoneNumber in /verify by @maxl2287 [PR68](https://github.com/camaraproject/NumberVerification/issues/76)
* Clarify use of 'user' and 'subscriber' wording by @AxelNennker [PR102](https://github.com/camaraproject/NumberVerification/pull/102)
* Clarify that the sequence diagram in the yaml documentation is an example by @bigludo7 [PR139](https://github.com/camaraproject/NumberVerification/pull/139)

### Fixed

* Replaced OAuth2 auth code flow by OIDC auth code flow by @AxelNennker [PR109](https://github.com/camaraproject/NumberVerification/pull/109)

### Removed

* Removed documentation (replaced by doc in the yaml) by @AxelNennker [PR137](https://github.com/camaraproject/NumberVerification/pull/1379)

## New Contributors
* N/A


# r1.1

## Release Notes

This release contains the definition and documentation of
* Number Verification API 1.0.0-rc.1



The API definition(s) are based on
* Commonalities v0.4.0
* Identity and Consent Management v0.2.0


## Number Verification v1.0.0-rc.1


**number-verification 1.0.0-rc.1** is the first release-candidate version for the v1.0.0 of the number verification API.

- API definition **with inline documentation**:
    - OpenAPI [YAML spec file](https://github.com/camaraproject/NumberVerification/blob/r1.1/code/API_definitions/number_verification.yaml)
    - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/NumberVerification/r1.1/code/API_definitions/number_verification.yaml&nocors)
    - [View it on Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/camaraproject/NumberVerification/r1.1/code/API_definitions/number_verification.yaml)
    
**number-verification 1.0.0-rc.1 is the first stable version for CAMARA Number Verification API**

This version contains significant changes compared to v0.3.1, and it is not backward compatible.

### Added

* User Story in documentation/API_documentation directory by @bigludo7 [PR118](https://github.com/camaraproject/NumberVerification/pull/118)
* Test Definition in Test_Definitions directory [To be done]

### Changed

* Aligned with CAMARA design guidelines & Identity Consent management
* Make the '+' mandatory for the phone number by @fernandopradocabrillo [PR90](https://github.com/camaraproject/NumberVerification/pull/90)
* Cosmetic change following megalinter integration by @bigludo7 [PR103](https://github.com/camaraproject/NumberVerification/pull/103)
* Update Authorization and authentication part accordingly to ICM by @fernandopradocabrillo [PR88](https://github.com/camaraproject/NumberVerification/issues/88)
* Adding a pattern for PhoneNumber in /verify by @maxl2287 [PR68](https://github.com/camaraproject/NumberVerification/issues/76)
* Clarify use of 'user' and 'subscriber' wording by @AxelNennker [PR102](https://github.com/camaraproject/NumberVerification/pull/102)

### Fixed

* Replaced OAuth2 auth code flow by OIDC auth code flow by @AxelNennker [PR109](https://github.com/camaraproject/NumberVerification/pull/109)

### Removed

* n/a

## New Contributors 

- @AxelNennker made their first contribution in clarifying use of 'user' and 'subscriber' wording by @AxelNennker [PR102](https://github.com/camaraproject/NumberVerification/pull/102)
- @rartych made their first contribution in GitHub workflows [#108](https://github.com/camaraproject/NumberVerification/pull/108)
- @fernandopradocabrillo made their first contribution by updating Authorization and authentication part accordingly to ICM [PR88](https://github.com/camaraproject/NumberVerification/issues/88)
- @maxl2287 made their first contribution by adding a pattern for PhoneNumber in /verify  [PR68](https://github.com/camaraproject/NumberVerification/issues/76)
- @bigludo7 made their first contribution by making change following megalinter integration [PR103](https://github.com/camaraproject/NumberVerification/pull/103)

**Full Changelog**: https://github.com/camaraproject/NumberVerification/compare/v0.3.1...r1.1

## v0.3.1

Initital release of Camara Number Verification API

## What's Changed
* Telefonica Proposal by @monamok in https://github.com/camaraproject/NumberVerification/pull/3
* Adding API documentation by @monamok in https://github.com/camaraproject/NumberVerification/pull/6
* Initial content for Number Verify by @DT-DawidWroblewski in https://github.com/camaraproject/NumberVerification/pull/2
* New specific 403 token error and guidelines alignment by @monamok in https://github.com/camaraproject/NumberVerification/pull/19
* adding puml by @DT-DawidWroblewski in https://github.com/camaraproject/NumberVerification/pull/24
* guidelines alignment errors and camel case by @monamok in https://github.com/camaraproject/NumberVerification/pull/30
* Change 'sub' cardinality + add attribute description by @bigludo7 in https://github.com/camaraproject/NumberVerification/pull/32
* Embed documentation in API Spec by @monamok in https://github.com/camaraproject/NumberVerification/pull/38

**Full Changelog**: https://github.com/camaraproject/NumberVerification/commits/v0.3.1
