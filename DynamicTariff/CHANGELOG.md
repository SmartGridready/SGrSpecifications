# Changelog

All notable changes to the JSON schema and OpenAPI specification will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).


## [2.0.0-preview4] - 2026-08-10

### Changed

- omitting `start_timestamp` and `end_timestamp` retrieves latest day with published data instead of current day

### Fixed

- consistency of EMS unlink status


## [2.0.0-preview3] - 2026-07-02

### Changed

- changed `TariffName` from enum to simple string
- tariff types, their parameters and tariff components not nullable

### Fixed

- `standard_basegroup` of integrated


## [2.0.0-preview2] - 2026-07-01

### Changed

- EMS unlink response
- OIDC security scheme changed back to `oauth2`
- publication timestamp, tariff types, their parameters and tariff components are nullable

### Fixed

- Description and examples


## [2.0.0-preview1] - 2026-06-19

First preview release of the upcoming specification.

### Added

- tariff types `metering`, `national_fees`, `dso`, `refund`, `dso_complete`, `integrated_complete`
- tariff components `base`, `energy`, `power`, `reactive_energy`
- authentication using OpenID Connect (OIDC)
- protected API endpoints to link or unlink EMS and to retrieve tariff prices assigned to the EMS, instead of using the public API with explicit tariff name


## [1.0.5] - 2026-05-28

### Changed

- removed authentication mechanisms, since it is a pure public API
- examples and descriptions

### Fixed

- schema of time stamps in response


## [1.0.4] - 2026-03-19

### Added

- price unit `CHF_kVarh`

### Changed

- renamed OpenAPI specification and schema
- title of OpenAPI specification
- order of request parameters in OpenAPI specification
- renamed response to `TariffResponse`
- improved description of schemas

### Fixed

- example of `TariffResponse`


## [1.0.3] - 2026-02-04

### Added

- first actual publication of JSON schema and OpenAPI specification
