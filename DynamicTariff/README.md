# VSE-compatible Dynamic Tariffs

This directory provides _JSON schemas_ and _OpenAPI_ specification templates
for VSE-compatible dynamic tariffs:

- [JSON Schema 2026](./Schema/dynamic_tariff_vse_2026_schema.json)
- [OpenAPI Specification Template 2026](./OpenAPI/dynamic_tariff_vse_2026_openapi.yaml)

The tariff specification is based on the document
[Dynamische Netznutzungstarife im Verteilnetz (HDN – CH 2025)](https://www.strom.ch/de/shop/dynamische-netznutzungstarife-im-verteilnetz-hdn-ch-2025).

When implementing your dynamic tariff API, use the provided OpenAPI template, modify it and generate the source code
using tools like [OpenAPI Generator](https://github.com/OpenAPITools/openapi-generator).
