# API Readiness Checklist

Checklist for number_verification 1.0.0 in release r1.2

| Nr | API release assets  | alpha | release-candidate |  public-release<br>initial | public-release<br> stable | Status | Comments |
|----|----------------------------------------------|:-----:|:-----------------:|:-------:|:------:|:----:|:----:|
|  1 | API definition                               |   M   |         M         |    M    |    M   |   Y   | [link](/code/API_definitions/number_verification.yaml) |
|  2 | Design guidelines from Commonalities applied |   O   |         M         |    M    |    M   |  Y    |      |
|  3 | Guidelines from ICM applied                  |   O   |         M         |    M    |    M   |   Y   |      |
|  4 | API versioning convention applied            |   M   |         M         |    M    |    M   |   Y   |      |
|  5 | API documentation                            |   M   |         M         |    M    |    M   |   Y   | Embed documentation into API spec - [link](/code/API_definitions/number_verification.yaml)  |
|  6 | User stories                                 |   O   |         O         |    O    |    M   |   Y   | [get](/documentation/API_documentation/NumberVerification_device_phone_number_User_Story.md) [verify](/documentation/API_documentation/NumberVerification_verify_User_Story.md) |
|  7 | Basic API test cases & documentation         |   O   |         M         |    M    |    M   |   Y   | [PR #124](https://github.com/camaraproject/NumberVerification/pull/124/files) |
|  8 | Enhanced API test cases & documentation      |   O   |         O         |    O    |    M   |   Y  | [PR #124](https://github.com/camaraproject/NumberVerification/pull/124/files) |
|  9 | Test result statement                        |   O   |         O         |    O    |    M   |   N   | link |
| 10 | API release numbering convention applied     |   M   |         M         |    M    |    M   |   Y   |      |
| 11 | Change log updated                           |   M   |         M         |    M    |    M   |   Y   | [link](/CHANGELOG.md) |
| 12 | Previous public-release was certified        |   O   |         O         |    O    |    M   |   Y   | [link](https://www.open-gateway.com/operators-map)    |

To fill the checklist:
- in the line above the table, replace the api-name, api-version and the rx.y by their actual values for the current API version and release.
- in the Status column, put "Y" (yes) if the release asset is available or fulfilled in the current release, a "N" (no) or a "tbd". Example use of "tbd" is in case an alpha or release-candidate API version does not yet provide all mandatory assets for the release.
- in the Comments column, provide the link to the asset once available, and any other relevant comments.

Note: the checklists of a public API version and of its preceding release-candidate API version can be the same.

The documentation for the content of the checklist is here: [API Readiness Checklist](https://wiki.camaraproject.org/display/CAM/API+Release+Process#APIReleaseProcess-APIreadinesschecklist).
