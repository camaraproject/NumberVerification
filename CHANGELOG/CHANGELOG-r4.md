# Changelog NumberVerification

<!-- TOC:START -->
## Table of Contents
- **[r4.2](#r42)**
- [r4.1](#r41)
<!-- TOC:END -->

**Please be aware that the project will have frequent updates to the main branch. There are no compatibility guarantees associated with code in any branch, including main, until it has been released. For example, changes may be reverted before a release is published. For the best results, use the latest published release.**

The below sections record the changes for each API version in each release as follows:

* for an alpha release, the delta with respect to the previous release
* for the first release-candidate, all changes since the last public release
* for subsequent release-candidate(s), only the delta to the previous release-candidate
* for a public release, the consolidated changes since the previous public release

# r4.2

## Release Notes

This public release contains the definition and documentation of
* number-verification 2.1.1

The API definition(s) are based on
* Commonalities r4.4 (0.9.0)
* Identity and Consent Management r4.2 (0.5.0)

## number-verification 2.1.1

**number-verification 2.1.1 is a patch update of this API.**

Changes documented below are compared to version 2.1.0.

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/NumberVerification/r4.2/code/API_definitions/number-verification.yaml&nocors)
  - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/NumberVerification/r4.2/code/API_definitions/number-verification.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/NumberVerification/blob/r4.2/code/API_definitions/number-verification.yaml)

### Breaking changes

* N/A

### Added

* Added access token requirements for Number Verification scopes: tokens are single-use, refresh tokens are not issued, and expiry is at most 300 seconds by @jpengar in https://github.com/camaraproject/NumberVerification/pull/226
* Added companion whitepaper: Operator Token Acquisition for Number Verification on Android (TS.43/OpenID4VP) by @albertoramosmonagas in https://github.com/camaraproject/NumberVerification/pull/238

### Changed

* Refactored DevicePhoneNumber reference in YAML by @bigludo7 in https://github.com/camaraproject/NumberVerification/pull/249
* Aligned with Commonalities r4.4 (0.9.0) by @bigludo7 in https://github.com/camaraproject/NumberVerification/pull/235 and @hdamker in https://github.com/camaraproject/NumberVerification/pull/252:
  * Error responses changed to reference `BadRequest400` and `Unauthenticated401` instead of `Generic400` / `Generic401`; error examples moved to `components/examples` by @bigludo7 in https://github.com/camaraproject/NumberVerification/pull/253
  * `maxLength` added to `phoneNumber`, `hashedPhoneNumber`, `x-correlator` and the `ErrorInfo` properties (no change in accepted values)
  * Tag names changed to `Phone Number Verify` / `Phone Number Share`
  * Added the mandatory "Request body strictness" section to `info.description`

### Fixed

* fix(number-verification): corrected Gherkin test definition defects by @hdamker in https://github.com/camaraproject/NumberVerification/pull/255
* test(number-verification): added missing 400 scenario for phoneNumberShare by @hdamker in https://github.com/camaraproject/NumberVerification/pull/257
* Corrected externalDocs.description wording in number-verification.yaml by @hdamker in https://github.com/camaraproject/NumberVerification/pull/240
* fix(number-verification): corrected RFC 2119 keywords and indentation in description by @hdamker in https://github.com/camaraproject/NumberVerification/pull/263

### Removed

* N/A

**Full Changelog**: https://github.com/camaraproject/NumberVerification/compare/r3.2...r4.2

# r4.1

## Release Notes

This release candidate contains the definition and documentation of
* number-verification 2.1.1-rc.2

The API definition(s) are based on
* Commonalities r4.4 (0.9.0)
* Identity and Consent Management r4.2 (0.5.0)

## number-verification 2.1.1-rc.2

**number-verification 2.1.1-rc.2 is a release-candidate version of this API.**

Changes documented below are compared to version 2.1.0.

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/NumberVerification/r4.1/code/API_definitions/number-verification.yaml&nocors)
  - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/NumberVerification/r4.1/code/API_definitions/number-verification.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/NumberVerification/blob/r4.1/code/API_definitions/number-verification.yaml)

### Breaking changes

* N/A

### Added

* Access token security considerations for Number Verification API by @jpengar in https://github.com/camaraproject/NumberVerification/pull/226
* Add companion whitepaper: Operator Token Acquisition for Number Verification on Android (TS.43/OpenID4VP) by @albertoramosmonagas in https://github.com/camaraproject/NumberVerification/pull/238

### Changed

* Refactor DevicePhoneNumber reference in YAML by @bigludo7 in https://github.com/camaraproject/NumberVerification/pull/249

### Fixed

* fix(number-verification): correct Gherkin test definition defects by @hdamker in https://github.com/camaraproject/NumberVerification/pull/255
* test(number-verification): add missing 400 scenario for phoneNumberShare by @hdamker in https://github.com/camaraproject/NumberVerification/pull/257
* Correct externalDocs.description wording in number-verification.yaml by @hdamker in https://github.com/camaraproject/NumberVerification/pull/240

### Removed

* N/A

**Full Changelog**: https://github.com/camaraproject/NumberVerification/compare/r3.2...r4.1

