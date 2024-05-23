#@uploadDocument #@fail
Feature: UploadDocument - Error Codes

  #@eob #@PCEHR_ERROR_9300
  Scenario: As DHS, I want to upload/index a failed EOB document
    Given The document type is EOB
      And with headers below
      | X-Correlation-ID    | MSG:66d9bb7d-ebbf-4c77-b1db-9b440cb18661 | 
      | userID              | 2300366573                               | 
      | channel             | CRP                                      | 
      | documentSourceActor | Medicare                                 | 
      | HPIO                | 8003626566686624                         | 
      | productVersion | 1.0.0                                    |
      | productName    | Hostipal                                 |
      And The IHI number is 8003608333411015
      And document id is urn:oid:2.35.157598728300360404652072519241668369195
      And a health care provider who uploads the Document with HTTP details as below
      | Content-Type | application/fhir+json | 
      | Accept       | application/fhir+json | 
     When I upload a document document_eob_failed
     Then the status code for record creation response is 400
      And the response includes
      | resourceType          | OperationOutcome            | 
      | issue[0].severity     | error                       | 
      | issue[0].details.text | FHIR Validation Failure | 
      | issue[0].diagnostics  | PCEHR_INT_010000            | 
  
  #@consent #@PCEHR_ERROR_9300
  Scenario: As DHS, I want to upload/index a failed Consent document
    Given The document type is Consent
      And with headers below
      | X-Correlation-ID    | MSG:66d9bb7d-ebbf-4c77-b1db-9b440cb18662 | 
      | userID              | 2300366573                               | 
      | channel             | CRP                                      | 
      | documentSourceActor | Medicare                                 | 
      | HPIO                | 8003626566686624                         | 
      | productVersion | 1.0.0                                    |
      | productName    | Hostipal                                 |
      And The IHI number is 8003608333411015
      And document id is urn:oid:2.45.157598728300360404652072519241668369195
      And a health care provider who uploads the Document with HTTP details as below
      | Content-Type | application/fhir+json | 
      | Accept       | application/fhir+json | 
     When I upload a document document_consent_failed
     Then the status code for record creation response is 400
      And the response includes
      | resourceType          | OperationOutcome            | 
      | issue[0].severity     | error                       | 
      | issue[0].details.text | FHIR Validation Failure | 
      | issue[0].diagnostics  | PCEHR_INT_010000            | 
  
  #@eob #@PCEHR_ERROR_9979
  Scenario: As DHS, I want to upload a duplicate Explanation of Benefits FHIR
    Given The document type is EOB
      And with headers below
      | X-Correlation-ID    | MSG:66d9bb7d-ebbf-4c77-b1db-9b440cb18663 | 
      | userID              | 2300366573                               | 
      | channel             | CRP                                      | 
      | documentSourceActor | Medicare                                 | 
      | HPIO                | 8003626566686624                         | 
      | productVersion | 1.0.0                                    |
      | productName    | Hostipal                                 |
      And The IHI number is 8003608333411015
      And document id is urn:oid:2.35.157598728300360404652072519241668369187
      And delete document if it exist with HTTP response 404 or 412
      And a health care provider who uploads the Document with HTTP details as below
      | Content-Type | application/fhir+json | 
      | Accept       | application/fhir+json | 
     When I upload a document document_eob_successful
     Then the status code for record creation response is 201
     When I upload a document document_eob_successful
     Then the status code for record creation response is 409
      And the response includes
      | resourceType          | OperationOutcome        | 
      | issue[0].severity     | error                   | 
      | issue[0].details.text | Resource already exists | 
      | issue[0].diagnostics  | PCEHR_INT_004006        | 
  
  #@consent #@PCEHR_ERROR_5101
  Scenario: As DHS, I want to upload/index a failed Consent document
    Given The document type is Consent
      And with headers below
      | X-Correlation-ID    | MSG:66d9bb7d-ebbf-4c77-b1db-9b440cb18664 | 
      | userID              | 2300366573                               | 
      | channel             | CRP                                      | 
      | documentSourceActor | Medicare                                 | 
      | HPIO                | 8003626566686624                         | 
      | productVersion | 1.0.0                                    |
      | productName    | Hostipal                                 |
      And The IHI number is 3608000041013
      And document id is urn:oid:2.45.157598728300360404652072519241668369195
      And a health care provider who uploads the Document with HTTP details as below
      | Content-Type | application/fhir+json | 
      | Accept       | application/fhir+json | 
     When I upload a document document_consent_successful
     Then the status code for record creation response is 404
      And the response includes
      | resourceType          | OperationOutcome                                  | 
      | issue[0].severity     | error                                             | 
      | issue[0].details.text | Consent not found      | 
      | issue[0].diagnostics  | PCEHR_INT_007201                                  | 
  
  #@immunization #@PCEHR_ERROR_9300
  Scenario: As DHS, I want to upload/index a failed Immunization document
    Given The document type is Immunization
      And with headers below
      | X-Correlation-ID    | MSG:66d9bb7d-ebbf-4c77-b1db-9b440cb18665 | 
      | userID              | 2300366573                               | 
      | channel             | CRP                                      | 
      | documentSourceActor | Medicare                                 | 
      | HPIO                | 8003626566686624                         | 
      | productVersion | 1.0.0                                    |
      | productName    | Hostipal                                 |
      And The IHI number is 8003608333411015
      And document id is urn:oid:1.3.6.1.4.1.21367.2005.3.7.1234
      And a health care provider who uploads the Document with HTTP details as below
      | Content-Type | application/fhir+json | 
      | Accept       | application/fhir+json | 
     When I upload a document document_immunization_failed
     Then the status code for record creation response is 400
      And the response includes
      | resourceType          | OperationOutcome            | 
      | issue[0].severity     | error                       | 
      | issue[0].details.text | FHIR Validation Failure          | 
      | issue[0].diagnostics  | PCEHR_INT_010000            | 
  
  #@immunization #@PCEHR_ERROR_9300
  Scenario: As DHS, I want to upload/index a failed Immunization document with invalid bundle type
    Given The document type is Immunization
      And with headers below
      | X-Correlation-ID    | MSG:66d9bb7d-ebbf-4c77-b1db-9b440cb18666 | 
      | userID              | 2300366573                               | 
      | channel             | CRP                                      | 
      | documentSourceActor | Medicare                                 | 
      | HPIO                | 8003626566686624                         | 
      | productVersion | 1.0.0                                    |
      | productName    | Hostipal                                 |
      And The IHI number is 8003608333411015
      And document id is urn:oid:1.3.6.1.4.1.21367.2005.3.7.1234
      And a health care provider who uploads the Document with HTTP details as below
      | Content-Type | application/fhir+json | 
      | Accept       | application/fhir+json | 
     When I upload a document document_immunization_failed_invalid_bundle_type
     Then the status code for record creation response is 400
      And the response includes
      | resourceType          | OperationOutcome            | 
      | issue[0].severity     | error                       | 
      | issue[0].details.text | FHIR Validation Failure     | 
      | issue[0].diagnostics  | PCEHR_INT_010000            | 
  
  #@eob #@PCEHR_ERROR_9300
  Scenario: As DHS, I want to upload/index a failed EOB document with No Provider Last Name
    Given The document type is EOB
      And with headers below
      | X-Correlation-ID    | MSG:66d9bb7d-ebbf-4c77-b1db-9b440cb18667 | 
      | userID              | 2300366573                               | 
      | channel             | CRP                                      | 
      | documentSourceActor | Medicare                                 | 
      | HPIO                | 8003626566686624                         | 
      | productVersion | 1.0.0                                    |
      | productName    | Hostipal                                 |
      And The IHI number is 8003608333411015
      And document id is urn:oid:2.35.157598728300360404652072519241668369195
      And a health care provider who uploads the Document with HTTP details as below
      | Content-Type | application/fhir+json | 
      | Accept       | application/fhir+json | 
     When I upload a document document_eob_last_name_missing
     Then the status code for record creation response is 400
      And the response includes
      | resourceType          | OperationOutcome            | 
      | issue[0].severity     | error                       | 
      | issue[0].details.text | FHIR Validation Failure    | 
      | issue[0].diagnostics  | PCEHR_INT_010000            | 

  #@eob #@PCEHR_ERROR_001018
  Scenario: As DHS, I want to upload/index a failed EOB document
    Given The document type is EOB
      And with headers below
      | X-Correlation-ID    | MSG:66d9bb7d-ebbf-4c77-b1db-9b440cb18669 | 
      | userID              | 2300366573                               | 
      | channel             | CRP                                      | 
      | documentSourceActor | Medicare                                 | 
      | HPIO                | 8003626566686624                         | 
      | productName    | Hostipal                                 |
      And The IHI number is 8003608333411015
      And document id is urn:oid:2.35.157598728300360404652072519241668369195
      And a health care provider who uploads the Document with HTTP details as below
      | Content-Type | application/fhir+json | 
      | Accept       | application/fhir+json | 
     When I upload a document document_eob_successful
     Then the status code for record creation response is 400
      And the response includes
      | resourceType          | OperationOutcome            | 
      | issue[0].severity     | error                       | 
      | issue[0].details.text | Missing productVersion | 
      | issue[0].diagnostics  | PCEHR_INT_000076            | 
  
  #@consent #@PCEHR_ERROR_001018
  Scenario: As DHS, I want to upload/index a failed Consent document
    Given The document type is Consent
      And with headers below
      | X-Correlation-ID    | MSG:66d9bb7d-ebbf-4c77-b1db-9b440cb18670 | 
      | userID              | 2300366573                               | 
      | channel             | CRP                                      | 
      | documentSourceActor | Medicare                                 | 
      | HPIO                | 8003626566686624                         | 
      | productName    | Hostipal                                 |
      And The IHI number is 8003608333411015
      And document id is urn:oid:2.45.157598728300360404652072519241668369195
      And a health care provider who uploads the Document with HTTP details as below
      | Content-Type | application/fhir+json | 
      | Accept       | application/fhir+json | 
     When I upload a document document_consent_successful
     Then the status code for record creation response is 400
      And the response includes
      | resourceType          | OperationOutcome            | 
      | issue[0].severity     | error                       | 
      | issue[0].details.text | Missing productVersion | 
      | issue[0].diagnostics  | PCEHR_INT_000076            |
  
  #@immunization #@PCEHR_ERROR_001018
  Scenario: As DHS, I want to upload/index a failed Immunization document
    Given The document type is Immunization
      And with headers below
      | X-Correlation-ID    | MSG:66d9bb7d-ebbf-4c77-b1db-9b440cb18671 | 
      | userID              | 2300366573                               | 
      | channel             | CRP                                      | 
      | documentSourceActor | Medicare                                 | 
      | HPIO                | 8003626566686624                         | 
      | productName    | Hostipal                                 |
      And The IHI number is 8003608333411015
      And document id is urn:oid:1.3.6.1.4.1.21367.2005.3.7.1234
      And a health care provider who uploads the Document with HTTP details as below
      | Content-Type | application/fhir+json | 
      | Accept       | application/fhir+json | 
     When I upload a document document_immunization_successful
     Then the status code for record creation response is 400
      And the response includes
      | resourceType          | OperationOutcome            | 
      | issue[0].severity     | error                       | 
      | issue[0].details.text | Missing productVersion    | 
      | issue[0].diagnostics  | PCEHR_INT_000076            |

 #@eob #@PCEHR_ERROR_001019
  Scenario: As DHS, I want to upload/index a failed EOB document
    Given The document type is EOB
      And with headers below
      | X-Correlation-ID    | MSG:66d9bb7d-ebbf-4c77-b1db-9b440cb18672 | 
      | userID              | 2300366573                               | 
      | channel             | CRP                                      | 
      | documentSourceActor | Medicare                                 | 
      | HPIO                | 8003626566686624                         | 
      | productVersion    | 1.0.0                                 |
      And The IHI number is 8003608333411015
      And document id is urn:oid:2.35.157598728300360404652072519241668369195
      And a health care provider who uploads the Document with HTTP details as below
      | Content-Type | application/fhir+json | 
      | Accept       | application/fhir+json | 
     When I upload a document document_eob_successful
     Then the status code for record creation response is 400
      And the response includes
      | resourceType          | OperationOutcome            | 
      | issue[0].severity     | error                       | 
      | issue[0].details.text | Missing productName         | 
      | issue[0].diagnostics  | PCEHR_INT_000077            | 
  
  #@consent #@PCEHR_ERROR_001019
  Scenario: As DHS, I want to upload/index a failed Consent document
    Given The document type is Consent
      And with headers below
      | X-Correlation-ID    | MSG:66d9bb7d-ebbf-4c77-b1db-9b440cb18673 | 
      | userID              | 2300366573                               | 
      | channel             | CRP                                      | 
      | documentSourceActor | Medicare                                 | 
      | HPIO                | 8003626566686624                         | 
      | productVersion    | 1.0.0                                 |
      And The IHI number is 8003608333411015
      And document id is urn:oid:2.45.157598728300360404652072519241668369195
      And a health care provider who uploads the Document with HTTP details as below
      | Content-Type | application/fhir+json | 
      | Accept       | application/fhir+json | 
     When I upload a document document_consent_successful
     Then the status code for record creation response is 400
      And the response includes
      | resourceType          | OperationOutcome            | 
      | issue[0].severity     | error                       | 
      | issue[0].details.text | Missing productName         | 
      | issue[0].diagnostics  | PCEHR_INT_000077            |
        
  #@immunization #@PCEHR_ERROR_001019
  Scenario: As DHS, I want to upload/index a failed Immunization document
    Given The document type is Immunization
      And with headers below
      | X-Correlation-ID    | MSG:66d9bb7d-ebbf-4c77-b1db-9b440cb18674 | 
      | userID              | 2300366573                               | 
      | channel             | CRP                                      | 
      | documentSourceActor | Medicare                                 | 
      | HPIO                | 8003626566686624                         | 
      | productVersion    | 1.0.0                                 |
      And The IHI number is 8003608333411015
      And document id is urn:oid:1.3.6.1.4.1.21367.2005.3.7.1234
      And a health care provider who uploads the Document with HTTP details as below
      | Content-Type | application/fhir+json | 
      | Accept       | application/fhir+json | 
     When I upload a document document_immunization_successful
     Then the status code for record creation response is 400
      And the response includes
      | resourceType          | OperationOutcome            | 
      | issue[0].severity     | error                       | 
      | issue[0].details.text | Missing productName         | 
      | issue[0].diagnostics  | PCEHR_INT_000077            |
   
  #@eob #@PCEHR_ERROR_0171
  Scenario: As DHS, I want to upload/index a failed EOB document
    Given The document type is EOB
      And with headers below
      | userID              | 2300366573                               | 
      | channel             | CRP                                      | 
      | documentSourceActor | Medicare                                 | 
      | HPIO                | 8003626566686624                         | 
      | productName    | Hostipal                                 |
      | productVersion    | 1.0.0                                 |
      And The IHI number is 8003608333411015
      And document id is urn:oid:2.35.157598728300360404652072519241668369195
      And a health care provider who uploads the Document with HTTP details as below
      | Content-Type | application/fhir+json | 
      | Accept       | application/fhir+json | 
     When I upload a document document_eob_successful
     Then the status code for record creation response is 400
      And the response includes
      | resourceType          | OperationOutcome            | 
      | issue[0].severity     | error                       | 
      | issue[0].details.text | Missing X-Correlation-ID    | 
      | issue[0].diagnostics  | PCEHR_INT_000051            | 
  
  #@consent #@PCEHR_ERROR_0171
  Scenario: As DHS, I want to upload/index a failed Consent document
    Given The document type is Consent
      And with headers below
      | userID              | 2300366573                               | 
      | channel             | CRP                                      | 
      | documentSourceActor | Medicare                                 | 
      | HPIO                | 8003626566686624                         | 
      | productName    | Hostipal                                 |
      | productVersion    | 1.0.0                                 |
      And The IHI number is 8003608333411015
      And document id is urn:oid:2.45.157598728300360404652072519241668369195
      And a health care provider who uploads the Document with HTTP details as below
      | Content-Type | application/fhir+json | 
      | Accept       | application/fhir+json | 
     When I upload a document document_consent_successful
     Then the status code for record creation response is 400
      And the response includes
      | resourceType          | OperationOutcome            | 
      | issue[0].severity     | error                       | 
      | issue[0].details.text | Missing X-Correlation-ID     | 
      | issue[0].diagnostics  | PCEHR_INT_000051            |
        
  #@immunization #@PCEHR_ERROR_0171
  Scenario: As DHS, I want to upload/index a failed Immunization document
    Given The document type is Immunization
      And with headers below
      | userID              | 2300366573                               | 
      | channel             | CRP                                      | 
      | documentSourceActor | Medicare                                 | 
      | HPIO                | 8003626566686624                         | 
      | productName    | Hostipal                                 |
      | productVersion    | 1.0.0                                 |
      And The IHI number is 8003608333411015
      And document id is urn:oid:1.3.6.1.4.1.21367.2005.3.7.1234
      And a health care provider who uploads the Document with HTTP details as below
      | Content-Type | application/fhir+json | 
      | Accept       | application/fhir+json | 
     When I upload a document document_immunization_successful
     Then the status code for record creation response is 400
      And the response includes
      | resourceType          | OperationOutcome            | 
      | issue[0].severity     | error                       | 
      | issue[0].details.text | Missing X-Correlation-ID    | 
      | issue[0].diagnostics  | PCEHR_INT_000051            |
           