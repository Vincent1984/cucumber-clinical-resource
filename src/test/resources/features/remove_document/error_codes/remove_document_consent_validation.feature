#@removeDocument #@failed
Feature: removeDocument - Consent Validation - Error Codes

  #@Provider   
  Scenario Outline: As NCP/NPP/Mobility(provider), I want to remove Document EOB with channel CRP and throw ERROR PCEHR_INT_006013
    Given The document type is "EOB" and uri is "/ExplanationOfBenefit"
      And Prepare remove document data in "data/removeDocument/happy_feature_removalDocuments.csv"
      And Use channel "<channel>" in header
      And with header params detail as
      | Key              | Value                   | 
      | Accept           | application/json                         | 
      | X-Correlation-ID | MSG:66d9bb7d-ebbf-4c77-b1db-9ZZZZZXXXX02 | 
      | userID           | 2300366573                               | 
      | hpio             | 7200002                              	| 
      And with query params detail as
      | Key        | Value                                            | 
      | documentID          | urn:oid:2.25.157598728300360404652072519241668369101  | 
      | patientID           | 8000000000300002                                  |
     When I try to remove the document
     Then the status code of response is "403"
     And verify the JSON OperationOutcome response includes
      | Key                   | Value                   | 
      | resourceType          | OperationOutcome     | 
      | issue[0].severity     | error                | 
      | issue[0].details.text | This eHealth Record is temporarily suspended. You are not permitted to access this record whilst it is suspended. If you require further information please contact 1800 723 471. | 
      | issue[0].diagnostics  | PCEHR_INT_006013     | 
    Examples: 
      | channel      | 
      | CRP          | 

  #@Provider
  Scenario Outline: As NCP/NPP/Mobility(provider), I want to remove Document EOB with channel CRP and throw ERROR PCEHR_INT_006005
    Given The document type is "EOB" and uri is "/ExplanationOfBenefit"
      And Prepare remove document data in "data/removeDocument/happy_feature_removalDocuments.csv"
      And Use channel "<channel>" in header
      And with header params detail as
      | Key              | Value                   | 
      | Accept           | application/json                         | 
      | X-Correlation-ID | MSG:66d9bb7d-ebbf-4c77-b1db-9ZZZZZXXXX03 | 
      | userID           | 2300366573                               | 
      | hpio             | 7200003                           		    | 
      And with query params detail as
      | Key        | Value                                            | 
      | documentID          | urn:oid:2.25.157598728300360404652072519241668369101  | 
      | patientID           | 8000000000300003                                  |
     When I try to remove the document
     Then the status code of response is "403"
     And verify the JSON OperationOutcome response includes
      | Key                   | Value                   | 
      | resourceType          | OperationOutcome     | 
      | issue[0].severity     | error                | 
      | issue[0].details.text | Record is not active | 
      | issue[0].diagnostics  | PCEHR_INT_006005     | 
    Examples: 
      | channel      | 
      | CRP          | 
 
  #@Provider
  Scenario Outline: As NCP/NPP/Mobility(provider), I want to remove Document EOB with channel CRP and throw ERROR PCEHR_INT_007202
    Given The document type is "EOB" and uri is "/ExplanationOfBenefit"
      And Prepare remove document data in "data/removeDocument/happy_feature_removalDocuments.csv"
      And Use channel "<channel>" in header
      And with header params detail as
      | Key              | Value                   | 
      | Accept           | application/json                         | 
      | X-Correlation-ID | MSG:66d9bb7d-ebbf-4c77-b1db-9ZZZZZXXXX04 | 
      | userID           | 2300366573                               | 
      | hpio             | 123                               		| 
      And with query params detail as
      | Key        | Value                                            | 
      | documentID          | urn:oid:2.25.157598728300360404652072519241668369101  | 
      | patientID           | -1                                 |
     When I try to remove the document
     Then the status code of response is "404"
     And verify the JSON OperationOutcome response includes
      | Key                   | Value                   | 
      | resourceType          | OperationOutcome     | 
      | issue[0].severity     | error                | 
      | issue[0].details.text | Provider relationship not found | 
      | issue[0].diagnostics  | PCEHR_INT_007202     | 
    Examples: 
      | channel      | 
      | CRP          | 

  #@Consumer     
  Scenario Outline: As NCP/NPP/Mobility(Consumer), I want to remove Document EOB with channel CRP and throw ERROR PCEHR_INT_006013
    Given The document type is "EOB" and uri is "/ExplanationOfBenefit"
      And Prepare remove document data in "data/removeDocument/happy_feature_removalDocuments.csv"
      And Use channel "<channel>" in header
      And with header params detail as
      | Key              | Value                   | 
      | Accept           | application/json                         | 
      | X-Correlation-ID | MSG:66d9bb7d-ebbf-4c77-b1db-9ZZZZZXXXX06 | 
      | userID           | 9310002                               | 
      And with query params detail as
      | Key        | Value                                            | 
      | documentID          | urn:oid:2.25.157598728300360404652072519241668369101  | 
      | patientID           | 8000000000310002                                  |
     When I try to remove the document
     Then the status code of response is "403"
     And verify the JSON OperationOutcome response includes
      | Key                   | Value                   | 
      | resourceType          | OperationOutcome     | 
      | issue[0].severity     | error                | 
      | issue[0].details.text | This eHealth Record is temporarily suspended. You are not permitted to access this record whilst it is suspended. If you require further information please contact 1800 723 471. | 
      | issue[0].diagnostics  | PCEHR_INT_006013     | 
    Examples: 
      | channel        | 
      | MOS            | 

  #@Consumer
  Scenario Outline: As NCP/NPP/Mobility(Consumer), I want to remove Document EOB with channel CRP and throw ERROR PCEHR_INT_006005
    Given The document type is "EOB" and uri is "/ExplanationOfBenefit"
      And Prepare remove document data in "data/removeDocument/happy_feature_removalDocuments.csv"
      And Use channel "<channel>" in header
      And with header params detail as
      | Key              | Value                   | 
      | Accept           | application/json                         | 
      | X-Correlation-ID | MSG:66d9bb7d-ebbf-4c77-b1db-9ZZZZZXXXX07 | 
      | userID           | 9310003                               | 
      And with query params detail as
      | Key        | Value                                            | 
      | documentID          | urn:oid:2.25.157598728300360404652072519241668369101  | 
      | patientID           | 8000000000310003                                  |
     When I try to remove the document
     Then the status code of response is "403"
     And verify the JSON OperationOutcome response includes
      | Key                   | Value                   | 
      | resourceType          | OperationOutcome     | 
      | issue[0].severity     | error                | 
      | issue[0].details.text | Record is not active | 
      | issue[0].diagnostics  | PCEHR_INT_006005     | 
    Examples: 
      | channel        | 
      | MOS            | 
     
  #@Consumer
  Scenario Outline: As NCP/NPP/Mobility(Consumer), I want to remove Document EOB with channel CRP and throw ERROR PCEHR_INT_006015
    Given The document type is "EOB" and uri is "/ExplanationOfBenefit"
      And Prepare remove document data in "data/removeDocument/happy_feature_removalDocuments.csv"
      And Use channel "<channel>" in header
      And with header params detail as
      | Key              | Value                   | 
      | Accept           | application/json                         | 
      | X-Correlation-ID | MSG:66d9bb7d-ebbf-4c77-b1db-9ZZZZZXXXX08 | 
      | userID           | 9310004                               | 
      And with query params detail as
      | Key        | Value                                            | 
      | documentID          | urn:oid:2.25.157598728300360404652072519241668369101  | 
      | patientID           | 8000000000310004                                  |
     When I try to remove the document
     Then the status code of response is "403"
     And verify the JSON OperationOutcome response includes
      | Key                   | Value                   | 
      | resourceType          | OperationOutcome     | 
      | issue[0].severity     | error                | 
      | issue[0].details.text | No active consumer relationship found | 
      | issue[0].diagnostics  | PCEHR_INT_006015     | 
    Examples: 
      | channel        | 
      | MOS            | 

  #@Consumer
  Scenario Outline: As NCP/NPP/Mobility(Consumer), I want to remove Document EOB with channel CRP and throw ERROR PCEHR_INT_007203
    Given The document type is "EOB" and uri is "/ExplanationOfBenefit"
      And Prepare remove document data in "data/removeDocument/happy_feature_removalDocuments.csv"
      And Use channel "<channel>" in header
      And with header params detail as
      | Key              | Value                   | 
      | Accept           | application/json                         | 
      | X-Correlation-ID | MSG:66d9bb7d-ebbf-4c77-b1db-9ZZZZZXXXX09 | 
      | userID           | 2300366573                               | 
      And with query params detail as
      | Key        | Value                                            | 
      | documentID          | urn:oid:2.25.157598728300360404652072519241668369101  | 
      | patientID           | 0000000000000000                                  |
     When I try to remove the document
     Then the status code of response is "404"
     And verify the JSON OperationOutcome response includes
      | Key                   | Value                   | 
      | resourceType          | OperationOutcome     | 
      | issue[0].severity     | error                | 
      | issue[0].details.text | Consumer relationship not found  | 
      | issue[0].diagnostics  | PCEHR_INT_007203     | 
    Examples: 
      | channel        | 
      | MOS            | 

