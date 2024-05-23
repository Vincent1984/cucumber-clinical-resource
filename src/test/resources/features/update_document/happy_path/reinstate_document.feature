#@reinstate #@success
Feature: reinstateDocument - Happy Path

  Scenario: As NCP/NPP/Mobility, I want to reinstate document
    Given Prepare document data in "data/reinstateDocument/happy-feature-reinstateDocument.csv"
      And The document as type of EOB
      And with the put header details below
      | Accept           | application/fhir+json                    | 
      | X-Correlation-ID | reinstate:66d9bb7d-ebbf-4c77-b1db-9b440cb18001 | 
      | channel          | OPS                                      | 
      | userID           | 2300366573                               | 
      And with the action params details below
      | action     | reinstate                                                  | 
      | documentID | urn:oid:2.25.157598728300360404652072519241668369115 | 
      | patientID  | 8003608333411015                                           | 
     When I want to update the document
     Then the status code for update document response is 204
