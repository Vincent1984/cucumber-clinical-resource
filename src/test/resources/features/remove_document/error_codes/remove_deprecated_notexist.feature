#@removeDocument #@errorCodes
Feature: removeDocument - Error Codes for Not Exist

  #@removeDocument #@AMDS-1115 #@Consumers-EOB
  Scenario Outline: AS Consumers, I want to remove a EOB document, but the document does not exist in the FHIR store
    Given The document type is "EOB" and uri is "/ExplanationOfBenefit"
      And Use channel "<channel>" in header
      And with header params detail as
      | Key              | Value                   | 
      | Accept           | application/json        | 
      | X-Correlation-ID | RemoveDocumentCID000009 | 
      | userID           | 2300366573              | 
      And with query params detail as
      | Key        | Value                                            | 
      | documentID | urn:oid:2.25.000000000000000000000000000000000000000 | 
      | patientID  | 8003608333411015                                 | 
     When I try to remove the document
     Then the status code of response is "404"
      And verify the JSON OperationOutcome response includes
      | Key                   | Value                   | 
      | resourceType          | OperationOutcome        | 
      | issue[0].severity     | error                 |
      | issue[0].code         | not-found               |
      | issue[0].details.text | The document does not exist in the FHIR store. | 
      | issue[0].diagnostics  | PCEHR_INT_004005        | 
    Examples: 
      | channel          | 
      | MOS              | 
  
  #@removeDocument #@AMDS-1115 #@Consumers-Consent
  Scenario Outline: AS Consumers, I want to remove a Consent document, but the document does not exist in the FHIR store
    Given The document type is "Consent" and uri is "/Consent"
      And Use channel "<channel>" in header
      And with header params detail as
      | Key              | Value                   | 
      | Accept           | application/json        | 
      | X-Correlation-ID | RemoveDocumentCID000010 | 
      | userID           | 2300366573              | 
      And with query params detail as
      | Key        | Value                                            | 
      | documentID | urn:oid:2.25.000000000000000000000000000000000000000 | 
      | patientID  | 8003608333411015                                 | 
     When I try to remove the document
     Then the status code of response is "404"
      And verify the JSON OperationOutcome response includes
      | Key                   | Value                   | 
      | resourceType          | OperationOutcome        | 
      | issue[0].severity     | error                 |
      | issue[0].code         | not-found               |
      | issue[0].details.text | The document does not exist in the FHIR store. | 
      | issue[0].diagnostics  | PCEHR_INT_004005        | 
    Examples: 
      | channel          | 
      | MOS              | 
  
  #@removeDocument #@AMDS-1115 #@Consumers-Immunization
  Scenario Outline: AS Consumers, I want to remove a Immunization document, but the document does not exist in the FHIR store
    Given The document type is "Immunization" and uri is "/Immunization"
      And Use channel "<channel>" in header
      And with header params detail as
      | Key              | Value                   | 
      | Accept           | application/json        | 
      | X-Correlation-ID | RemoveDocumentCID000011 | 
      | userID           | 2300366573              | 
      And with query params detail as
      | Key        | Value                                            | 
      | documentID | urn:oid:2.25.000000000000000000000000000000000000000 | 
      | patientID  | 8003608333411015                                 | 
     When I try to remove the document
     Then the status code of response is "404"
      And verify the JSON OperationOutcome response includes
      | Key                   | Value                   | 
      | resourceType          | OperationOutcome        | 
      | issue[0].severity     | error                 |
      | issue[0].code         | not-found               |
      | issue[0].details.text | The document does not exist in the FHIR store. | 
      | issue[0].diagnostics  | PCEHR_INT_004005        | 
    Examples: 
      | channel          | 
      | MOS              | 
  
  #@removeDocument #@AMDS-1115 #@Providers-EOB
  Scenario Outline: AS Providers, I want to remove a EOB document, but the document does not exist in the FHIR store
    Given The document type is "EOB" and uri is "/ExplanationOfBenefit"
      And Use channel "<channel>" in header
      And with header params detail as
      | Key              | Value                   | 
      | Accept           | application/json        | 
      | X-Correlation-ID | RemoveDocumentCID000012 | 
      | userID           | 2300366573              | 
      | hpio             | 8003626566686624        | 
      And with query params detail as
      | Key        | Value                                            | 
      | documentID | urn:oid:2.25.000000000000000000000000000000000000000 | 
      | patientID  | 8003608333411015                                 | 
     When I try to remove the document
     Then the status code of response is "404"
      And verify the JSON OperationOutcome response includes
      | Key                   | Value                   | 
      | resourceType          | OperationOutcome        | 
      | issue[0].severity     | error                 |
      | issue[0].code         | not-found               |
      | issue[0].details.text | The document does not exist in the FHIR store. | 
      | issue[0].diagnostics  | PCEHR_INT_004005        | 
    Examples: 
      | channel      | 
      | CRP          | 
  
  #@removeDocument #@AMDS-1115 #@Providers-Consent
  Scenario Outline: AS Providers, I want to remove a Consent document, but the document does not exist in the FHIR store
    Given The document type is "Consent" and uri is "/Consent"
      And Use channel "<channel>" in header
      And with header params detail as
      | Key              | Value                   | 
      | Accept           | application/json        | 
      | X-Correlation-ID | RemoveDocumentCID000013 | 
      | userID           | 2300366573              | 
      | hpio             | 8003626566686624        | 
      And with query params detail as
      | Key        | Value                                            | 
      | documentID | urn:oid:2.25.000000000000000000000000000000000000000 | 
      | patientID  | 8003608333411015                                 | 
     When I try to remove the document
     Then the status code of response is "404"
      And verify the JSON OperationOutcome response includes
      | Key                   | Value                   | 
      | resourceType          | OperationOutcome        | 
      | issue[0].severity     | error                 |
      | issue[0].code         | not-found               |
      | issue[0].details.text | The document does not exist in the FHIR store. | 
      | issue[0].diagnostics  | PCEHR_INT_004005        | 
    Examples: 
      | channel      | 
      | CRP          | 
  
  #@removeDocument #@AMDS-1115 #@Providers-Consent
  Scenario Outline: AS Providers, I want to remove a Immunization document, but the document does not exist in the FHIR store
    Given The document type is "Immunization" and uri is "/Immunization"
      And Use channel "<channel>" in header
      And with header params detail as
      | Key              | Value                   | 
      | Accept           | application/json        | 
      | X-Correlation-ID | RemoveDocumentCID000014 | 
      | userID           | 2300366573              | 
      | hpio             | 8003626566686624        | 
      And with query params detail as
      | Key        | Value                                            | 
      | documentID | urn:oid:2.25.000000000000000000000000000000000000000 | 
      | patientID  | 8003608333411015                                 | 
     When I try to remove the document
     Then the status code of response is "404"
      And verify the JSON OperationOutcome response includes
      | Key                   | Value                   | 
      | resourceType          | OperationOutcome        | 
      | issue[0].severity     | error                 |
      | issue[0].code         | not-found               |
      | issue[0].details.text | The document does not exist in the FHIR store. | 
      | issue[0].diagnostics  | PCEHR_INT_004005        | 
    Examples: 
      | channel      | 
      | CRP          | 
  
