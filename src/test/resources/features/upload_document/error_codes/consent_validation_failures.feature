#@uploadDocument #@fail #@consentValidation #@PCEHR_ERROR_0004
Feature: UploadDocument - Consent Validation - Error Codes

  #@PCEHR_INT_006005
  Scenario: As DHS, I want to get a Consent error when Record Status is not active
    Given The document type is EOB
      And with headers below
      | X-Correlation-ID    | MSG:66d9bb7d-ebbf-4c77-b1db-9b440cb18002  | 
      | userID              | uuid:66d9bb7d-ebbf-4c77-b1db-9b440cb18dd4 | 
      | HPIO                | HospitalID                                | 
      | channel             | CRP                                       | 
      | documentSourceActor | Medicare                                  | 
      | productVersion | 1.0.0                                 |
      | productName    | Hostipal                              |
      And The IHI number is 8000000000100001
      And document id is urn:oid:2.35.157598728300360404652072519241668369195
      And a health care provider who uploads the Document with HTTP details as below
      | Content-Type | application/fhir+json | 
     When I upload a document document_eob_successful
     Then the status code for record creation response is 403
      And the response includes
      | resourceType          | OperationOutcome     | 
      | issue[0].severity     | error                | 
      | issue[0].details.text | Record is not active | 
      | issue[0].diagnostics  | PCEHR_INT_006005     | 
  
  #@PCEHR_INT_006006
  Scenario: As DHS, I want to get a Consent error when IHI status is not active
    Given The document type is EOB
      And with headers below
      | X-Correlation-ID    | MSG:66d9bb7d-ebbf-4c77-b1db-9b440cb18003  | 
      | userID              | uuid:66d9bb7d-ebbf-4c77-b1db-9b440cb18dd4 | 
      | HPIO                | HospitalID                                | 
      | channel             | CRP                                       | 
      | documentSourceActor | Medicare                                  | 
      | productVersion | 1.0.0                                 |
      | productName    | Hostipal                              |
      And The IHI number is 8000000000100002
      And document id is urn:oid:2.35.157598728300360404652072519241668369195
      And a health care provider who uploads the Document with HTTP details as below
      | Content-Type | application/fhir+json | 
     When I upload a document document_eob_successful
     Then the status code for record creation response is 403
      And the response includes
      | resourceType          | OperationOutcome     | 
      | issue[0].severity     | error                | 
      | issue[0].details.text | IHI is not active | 
      | issue[0].diagnostics  | PCEHR_INT_006006     | 

  #@PCEHR_INT_006004
  Scenario: As DHS, I want to get a Consent error when Record is not active
    Given The document type is EOB
      And with headers below
      | X-Correlation-ID    | MSG:66d9bb7d-ebbf-4c77-b1db-9b440cb18004  | 
      | userID              | uuid:66d9bb7d-ebbf-4c77-b1db-9b440cb18dd4 | 
      | HPIO                | HospitalID                                | 
      | channel             | CRP                                       | 
      | documentSourceActor | Default                                   | 
      | productVersion | 1.0.0                                 |
      | productName    | Hostipal                              |
      And The IHI number is 8000000000100003
      And document id is urn:oid:2.35.157598728300360404652072519241668369195
      And a health care provider who uploads the Document with HTTP details as below
      | Content-Type | application/fhir+json | 
     When I upload a document document_eob_successful
     Then the status code for record creation response is 403
      And the response includes
      | resourceType          | OperationOutcome     | 
      | issue[0].severity     | error                | 
      | issue[0].details.text | Document source actor not found | 
      | issue[0].diagnostics  | PCEHR_INT_006007     | 
  
  #@PCEHR_INT_006007
  Scenario: As DHS, I want to get a Consent error when Document source actor not found
    Given The document type is EOB
      And with headers below
      | X-Correlation-ID    | MSG:66d9bb7d-ebbf-4c77-b1db-9b440cb18005  | 
      | userID              | uuid:66d9bb7d-ebbf-4c77-b1db-9b440cb18dd4 | 
      | HPIO                | HospitalID                                | 
      | channel             | CRP                                       | 
      | documentSourceActor | Default                                   | 
      | productVersion | 1.0.0                                 |
      | productName    | Hostipal                              |
      And The IHI number is 8000000000100004
      And document id is urn:oid:2.35.157598728300360404652072519241668369195
      And a health care provider who uploads the Document with HTTP details as below
      | Content-Type | application/fhir+json | 
     When I upload a document document_eob_successful
     Then the status code for record creation response is 403
      And the response includes
      | resourceType          | OperationOutcome     | 
      | issue[0].severity     | error                | 
      | issue[0].details.text | Document source actor not found | 
      | issue[0].diagnostics  | PCEHR_INT_006007     | 
  
  #@PCEHR_INT_006009
  Scenario: As DHS, I want to get a Consent error when Consent for document type not given
    Given The document type is EOB
      And with headers below
      | X-Correlation-ID    | MSG:66d9bb7d-ebbf-4c77-b1db-94440cb18106  | 
      | userID              | uuid:66d9bb7d-ebbf-4c77-b1db-9b440cb18dd4 | 
      | HPIO                | HospitalID                                | 
      | channel             | CRP                                       | 
      | documentSourceActor | Medicare                                  | 
      | productVersion | 1.0.0                                 |
      | productName    | Hostipal                              |
      And The IHI number is 8000000000100006
      And document id is urn:oid:2.35.157598728300360404652072519241668369187
      And a health care provider who uploads the Document with HTTP details as below
      | Content-Type | application/fhir+json | 
     When I upload a document document_eob_failed_document_type_invalid
     Then the status code for record creation response is 400
      And the response includes
      | resourceType          | OperationOutcome     | 
      | issue[0].severity     | error                | 
      | issue[0].details.text | The document type code is not valid. It is either empty or not defined in CODE_100_16650,  CODE_100_16644 , CODE_100_17042 , CODE_100_16659 and CODE_100_16671 . | 
      | issue[0].diagnostics  | PCEHR_INT_006010     | 
      
  #@PCEHR_INT_007201
  Scenario: As DHS, I want to get a Consent error when  not found
    Given The document type is EOB
      And with headers below
      | X-Correlation-ID    | MSG:66d9bb7d-ebbf-4c77-b1db-94440cb18107  | 
      | userID              | uuid:66d9bb7d-ebbf-4c77-b1db-9b440cb18dd4 | 
      | HPIO                | HospitalID                                | 
      | channel             | CRP                                       | 
      | documentSourceActor | Medicare                                  | 
      | productVersion | 1.0.0                                 |
      | productName    | Hostipal                              |
      And The IHI number is 000000000000000
      And document id is urn:oid:2.35.157598728300360404652072519241668369187
      And a health care provider who uploads the Document with HTTP details as below
      | Content-Type | application/fhir+json | 
     When I upload a document document_eob_failed_document_type_invalid
     Then the status code for record creation response is 400
      And the response includes
      | resourceType          | OperationOutcome     | 
      | issue[0].severity     | error                | 
      | issue[0].details.text | The document type code is not valid. It is either empty or not defined in CODE_100_16650,  CODE_100_16644 , CODE_100_17042 , CODE_100_16659 and CODE_100_16671 . | 
      | issue[0].diagnostics  | PCEHR_INT_006010     |
