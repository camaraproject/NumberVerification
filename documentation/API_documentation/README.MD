# Number Verify API documentation

## Overview

### Introduction

CAMARA Number Verify API aims to deliver proof of device possession, that is attached to SIM card and MSISDN, using mobile network authentication. 

[GSMA Mobile Connect Verified MSISDN specification](https://www.gsma.com/identity/wp-content/uploads/2022/12/IDY.54-Mobile-Connect-Verified-MSISDN-Definition-and-Technical-Requirements-1.0.pdf) was used as source of input for this API.  For more about Mobile Connect, please see [Mobile Connect website](https://mobileconnect.io/).

### Quick start

1. Download yaml file.
2. Contact CAMARA API maintainers to get guidance on the onboarding process:

   * [Deutsche Telekom - Dawid Wróblewski](https://github.com/DT-DawidWroblewski)
   * [Telefonica - Mona Mokhber](https://github.com/monamok)
   * [Orange - Ludovic Robert](https://github.com/bigludo7)
## Documentation

### Details

[DetailsPage](../../documentation/API_documentation/CAMARA/NUMBER_VERIFICATION_API.md)

### Endpoint definitions

|Flavour|Endpoint type|Endpoint path|
|---|---|---|
|CAMARA|AuthN/AuthZ||
||resource|/verify|
||resource|/device-phone-number|

### Errors

Described inside yaml file.

### Release Notes

|No|Version|Changelog|
|:---:|---:|:---|
|1|0.1.0|Camara & Mobile Connect flavors available|
|2|0.2.1|Camara only version<br>|

## API Spec

[API definition (code)](../../code/API_definitions/number_verification.yaml)
