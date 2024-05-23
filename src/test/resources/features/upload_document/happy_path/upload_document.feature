#@uploadDocument #@success
Feature: UploadDocument - Happy Paths

#@eob #@fhir
  Scenario: As DHS, I want to upload an Explanation of Benefits FHIR
    Given The document type is EOB
    And with headers below
      | X-Correlation-ID    | MSG:66d9bb7d-ebbf-4c77-b1db-9b440cb18010 |
      | userID              | 9910002                                  |
      | channel             | CRP                                      |
      | documentSourceActor | Medicare                                 |
      | HPIO                | 7900002                                  |
      | productVersion      | 1.0.0                                    |
      | productName         | Hostipal                                 |
    And The IHI number is 8003608000078105
    And document id is urn:oid:2.35.157598728300360404652072519241668369187
    And delete document if it exist with HTTP response 404 or 412
    And a health care provider who uploads the Document with HTTP details as below
      | Content-Type | application/fhir+json |
      | Accept       | application/fhir+json |
    When I upload a document document_eob_successful
    Then the status code for record creation response is 201
    And the response header parameter Location exists and have right structure
    And the response includes
      | resourceType | ExplanationOfBenefit |
    And the unknown code table should has records contained in below data table
      | codeSystem                                    | code           | initialStatus |
      | http://pbs.gov.au/code/item                   | NEW_CODE       |  NEW           |
      | http://pbs.gov.au/code/item/unknowncodesystem | UNCHECKED_CODE | UNCHECKED     |
      | non-existent_code_system | NON_CODE | UNCHECKED     |
    And the unknown code table should not has records contained in below data table
      | codeSystem                     | code      | display                     |
      | urn:oid:1.2.36.1.2001.1001.101 | 100.16650 | Pharmaceutical Benefit Item |
    And delete document if it exist with HTTP response 204 or 404

#@eob #@fhir #@multiple-names
  Scenario: As DHS, I want to upload an Explanation of Benefits FHIR
    Given The document type is EOB
    And with headers below
      | X-Correlation-ID    | MSG:66d9bb7d-ebbf-4c77-b1db-9b440cb18110 |
      | userID              | 9910002                                  |
      | channel             | CRP                                      |
      | documentSourceActor | Medicare                                 |
      | HPIO                | 7900002                                  |
      | productVersion      | 1.0.0                                    |
      | productName         | Hostipal                                 |
    And The IHI number is 8003608000078105
    And document id is urn:oid:2.25.157598728300360404652072509241207938567
    And delete document if it exist with HTTP response 404 or 412
    And a health care provider who uploads the Document with HTTP details as below
      | Content-Type | application/fhir+json |
      | Accept       | application/fhir+json |
    When I upload a document document_eob_multiple_names_successful
    Then the status code for record creation response is 201
    And the response header parameter Location exists and have right structure
    And the response includes
      | resourceType | ExplanationOfBenefit |
    And delete document if it exist with HTTP response 200 or 404

#@eob #@fhir #@no-provider
  Scenario: As DHS, I want to upload an Explanation of Benefits FHIR
    Given The document type is EOB
    And with headers below
      | X-Correlation-ID    | MSG:66d9bb7d-ebbf-4c77-b1db-9b440cb18110 |
      | userID              | 9910002                                  |
      | channel             | CRP                                      |
      | documentSourceActor | Medicare                                 |
      | HPIO                | 7900002                                  |
      | productVersion      | 1.0.0                                    |
      | productName         | Hostipal                                 |
    And The IHI number is 8003608000078105
    And document id is urn:oid:2.25.15759872830036040465207251924120860532
    And delete document if it exist with HTTP response 404 or 412
    And a health care provider who uploads the Document with HTTP details as below
      | Content-Type | application/fhir+json |
      | Accept       | application/fhir+json |
    When I upload a document document_eob_no_provider_successful
    Then the status code for record creation response is 201
    And the response header parameter Location exists and have right structure
    And the response includes
      | resourceType | ExplanationOfBenefit |
    And delete document if it exist with HTTP response 200 or 404

  #@consent #@fhir
  Scenario: As DHS, I want to upload a Consent FHIR
    Given The document type is Consent
    And with headers below
      | X-Correlation-ID    | MSG:66d9bb7d-ebbf-4c77-b1db-9b440cb18011 |
      | userID              | 9910002                                  |
      | channel             | CRP                                      |
      | documentSourceActor | Medicare                                 |
      | HPIO                | 7900002                                  |
      | productVersion      | 1.0.0                                    |
      | productName         | Hostipal                                 |
    And The IHI number is 8003608000078105
    And document id is urn:oid:2.45.157598728300360404652072519241668369195
    And delete document if it exist with HTTP response 404 or 412
    And a health care provider who uploads the Document with HTTP details as below
      | Content-Type | application/fhir+json |
      | Accept       | application/fhir+json |
    When I upload a document document_consent_successful
    Then the status code for record creation response is 201
    And the response header parameter Location exists and have right structure
    And the response includes
      | resourceType | Consent |
    And delete document if it exist with HTTP response 200 or 404

  #@immunization #@fhir
  Scenario: As DHS, I want to upload a list of Immunizations FHIR
    Given The document type is Immunization
    And with headers below
      | X-Correlation-ID    | MSG:66d9bb7d-ebbf-4c77-b1db-9b440cb18012 |
      | userID              | 9910002                                  |
      | channel             | CRP                                      |
      | documentSourceActor | Medicare                                 |
      | HPIO                | 7900002                                  |
      | productVersion      | 1.0.0                                    |
      | productName         | Hostipal                                 |
    And The IHI number is 8003608000078105
    And document id is urn:oid:2.55.157598728300360404652072519241668369195
    And delete document if it exist with HTTP response 404 or 412
    And a health care provider who uploads the Document with HTTP details as below
      | Content-Type | application/fhir+json |
      | Accept       | application/fhir+json |
    When I upload a document document_immunization_successful
    Then the status code for record creation response is 201
    And the response includes
      | resourceType | Bundle |
    And delete document if it exist with HTTP response 200 or 404

