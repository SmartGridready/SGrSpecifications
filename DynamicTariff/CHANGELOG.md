# Changelog

All notable changes to the JSON schema and OpenAPI specification will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).


## [2.0.0-preview] - 2026-07-01

Preview release of the upcoming specification.

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
