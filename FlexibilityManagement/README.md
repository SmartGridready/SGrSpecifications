# SGCP Flexibility Management

This directory provides _JSON schemas_ and _OpenAPI_ specification templates
for SmartGridready-compatible SGCP flexibility management:

- JSON Schema V1
  - [Get Settings](./Schema/sgcp_flexmgmt_schema_settings_v1.json)
  - [Get Data](./Schema/sgcp_flexmgmt_schema_data_v1.json)
  - [Set Restrict Power](./Schema/sgcp_flexmgmt_schema_restrictpower_v1.json)
- [OpenAPI Specification Template V1](./OpenAPI/sgcp_flexmgmt_openapi_v1.yaml)

The specification is based on the functional profile
[SGCP FlexMgmt 4m)](https://library.smartgridready.ch/FP_SGr_SGCP_FlexMgmt_4m_1.0.xml?viewProfile).

When implementing your concrete flexibility management API, use the provided OpenAPI template, modify it and generate the source code
using tools like [OpenAPI Generator](https://github.com/OpenAPITools/openapi-generator).
