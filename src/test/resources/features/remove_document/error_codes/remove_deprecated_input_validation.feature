#@removeDocument #@inputValidation
Feature: removeDocument - Input Validation

  #@removeDocument #@AMDS-1114 #@Consumers-EOB #@PCEHR_ERROR_001013
  Scenario: AS Consumers, I want to remove a EOB document, but Correlation ID missing
    Given The document type is "EOB" and uri is "/ExplanationOfBenefit"
      And with header params detail as
      | Key          | Value                   | 
      | Accept       | application/json        | 
      | userID       | 2300366573              | 
      | channel | MOS | 
      And with query params detail as
      | Key           | Value                                            | 
      | documentID    | urn:oid:2.25.000000000000000000000000000000000000000 | 
      | patientID     | 8003608333411015                                 | 
     When I try to remove the document
     Then the status code of response is "400"
      And verify the JSON OperationOutcome response includes
      | Key                   | Value                                     | 
      | resourceType          | OperationOutcome                          | 
      | issue[0].severity     | error                                     | 
      | issue[0].code         | required                                   | 
      | issue[0].details.text | Missing X-Correlation-ID      | 
      | issue[0].diagnostics  | PCEHR_INT_000051                          | 
  
  #@removeDocument #@AMDS-1114 #@Consumers-EOB #@PCEHR_ERROR_001007
  Scenario: AS Consumers, I want to remove a EOB document, but IHI Missing
    Given The document type is "EOB" and uri is "/ExplanationOfBenefit"
      And with header params detail as
      | Key              | Value                   | 
      | Accept           | application/json        | 
      | X-Correlation-ID | RemoveDocumentCID000018 | 
      | userID           | 2300366573              | 
      | channel | MOS | 
      And with query params detail as
      | Key           | Value                                            | 
      | documentID    | urn:oid:2.25.000000000000000000000000000000000000000 | 
     When I try to remove the document
     Then the status code of response is "400"
      And verify the JSON OperationOutcome response includes
      | Key                   | Value            | 
      | resourceType          | OperationOutcome | 
      | issue[0].severity     | error            | 
      | issue[0].code         | required          | 
      | issue[0].details.text | Missing patientId  | 
      | issue[0].diagnostics  | PCEHR_INT_000056 | 
  
  #@removeDocument #@AMDS-1114 #@Consumers-EOB #@PCEHR_ERROR_001009
  Scenario: AS Consumers, I want to remove a EOB document, but Channel is missing
    Given The document type is "EOB" and uri is "/ExplanationOfBenefit"
      And with header params detail as
      | Key              | Value                   | 
      | Accept           | application/json        | 
      | X-Correlation-ID | RemoveDocumentCID000020 | 
      | userID           | 2300366573              | 
      And with query params detail as
      | Key           | Value                                            | 
      | documentID    | urn:oid:2.25.000000000000000000000000000000000000000 | 
      | patientID     | 8003608333411015                                 | 
     When I try to remove the document
     Then the status code of response is "400"
      And verify the JSON OperationOutcome response includes
      | Key                   | Value                            | 
      | resourceType          | OperationOutcome                 | 
      | issue[0].severity     | error                            | 
      | issue[0].code         | required                          | 
      | issue[0].details.text | Missing channel      | 
      | issue[0].diagnostics  | PCEHR_INT_000052                 | 
  
  #@removeDocument #@AMDS-1114 #@Consumers-EOB #@PCEHR_ERROR_001011
  Scenario: AS Consumers, I want to remove a EOB document, but User ID is missing
    Given The document type is "EOB" and uri is "/ExplanationOfBenefit"
      And with header params detail as
      | Key              | Value                   | 
      | Accept           | application/json        | 
      | X-Correlation-ID | RemoveDocumentCID000022 | 
      | channel | MOS | 
      And with query params detail as
      | Key           | Value                                            | 
      | documentID    | urn:oid:2.25.000000000000000000000000000000000000000 | 
      | patientID     | 8003608333411015                                 | 
     When I try to remove the document
     Then the status code of response is "400"
      And verify the JSON OperationOutcome response includes
      | Key                   | Value                           | 
      | resourceType          | OperationOutcome                | 
      | issue[0].severity     | error                           | 
      | issue[0].code         | required                         | 
      | issue[0].details.text | Missing userId         | 
      | issue[0].diagnostics  | PCEHR_INT_000054                | 
  
  #@removeDocument #@AMDS-1114 #@Consumers-EOB #@PCEHR_ERROR_001078
  Scenario: AS Consumers, I want to remove a EOB document, but Document Identifier is missing 
    Given The document type is "EOB" and uri is "/ExplanationOfBenefit"
      And with header params detail as
      | Key              | Value                   | 
      | Accept           | application/json        | 
      | X-Correlation-ID | RemoveDocumentCID000035 | 
      | userID           | 2300366573              | 
      | channel          | MOS                     | 
      And with query params detail as
      | Key           | Value             | 
      | patientID     | 8003608333411015  | 
     When I try to remove the document
     Then the status code of response is "400"
      And verify the JSON OperationOutcome response includes
      | Key                   | Value                        | 
      | resourceType          | OperationOutcome             | 
      | issue[0].severity     | error                        | 
      | issue[0].code         | required                      | 
      | issue[0].details.text | Missing documentId        | 
      | issue[0].diagnostics  | PCEHR_INT_000058             | 
