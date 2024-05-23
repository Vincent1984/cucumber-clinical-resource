#@reinstate #@fail
Feature: reinstateDocument - Error Codes

  #@eob #@PCEHR_ERROR_3107
  Scenario: As NCP/NPP/Mobility, I want to reinstate document with document does not exist
    Given The document as type of EOB
      And with the put header details below
      | Accept           | application/fhir+json                    | 
      | X-Correlation-ID | reinstate:66d9bb7d-ebbf-4c77-b1db-9b440cb18001 | 
      | channel          | NCP                                      | 
      | userID           | 2                                        | 
      And with the action params details below
      | action     | reinstate                                                  | 
      | documentID | urn:oid:2.25.157598728300360404652072519241668369190 | 
      | patientID  | 8003601127488001                                           | 
     When I want to update the document
     Then the status code for update document response is 404
      And the update document response includes
      | resourceType          | OperationOutcome        | 
      | issue[0].severity     | error                   | 
      | issue[0].details.text | The document does not exist in the FHIR store. | 
      | issue[0].diagnostics  | PCEHR_INT_004005        | 
  
  #@eob #@PCEHR_ERROR_3002
  Scenario: As NCP/NPP/Mobility, I want to reinstate document with document already active
    Given Prepare document data in "data/reinstateDocument/happy-feature-reinstateDocument.csv"
      And The document as type of EOB
      And with the put header details below
      | Accept           | application/fhir+json                    | 
      | X-Correlation-ID | reinstate:66d9bb7d-ebbf-4c77-b1db-9b440cb18002 | 
      | channel          | NCP                                      | 
      | userID           | 2300366573                               | 
      And with the action params details below
      | action     | reinstate                                                  | 
      | documentID | urn:oid:2.25.157598728300360404652072519241668369116 | 
      | patientID  | 8003608333411015                                           | 
     When I want to update the document
     Then the status code for update document response is 400
      And the update document response includes
      | resourceType          | OperationOutcome                    | 
      | issue[0].severity     | error                               | 
      | issue[0].details.text | The document is already active in the FHIR store. | 
      | issue[0].diagnostics  | PCEHR_INT_004012                    | 
  
