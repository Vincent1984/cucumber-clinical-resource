#@getMedicareOverview #@fail
Feature: GetMedicareOverview - Error Codes

#@inputValidation #@PCEHR_ERROR_0171
  Scenario: As DHS, I want get Medicare Overview should return CorrelationID is not provided
    Given The document query type is EOB
    And with the query header details below
      | Accept              | application/fhir+json |
      | channel             | NCP                   |
      | userID              | 2                     |
      | hpio                |                       |
      | documentSourceActor | Medicare              |
    And with the query param details below
      | patientID | 8003608000041012 |
      | accessLevel  | GENERAL          |
      | fromDate     | 2017-04-12       |
      | toDate       | 2017-05-12       |
    When I request to get document
    Then the status code for getMedicareOverview operation response is 400
    And the getMedicareOverview response includes
      | resourceType         	| OperationOutcome 										|
      | issue[0].severity    	| error            										|
      | issue[0].code         	| required                             					|
      | issue[0].details.text 	| Missing X-Correlation-ID	 		|
      | issue[0].diagnostics  	| PCEHR_INT_000051         							| 

  #@fhir #@mbs #@EOB
  Scenario: As DHS, I want to get an Explanation of Benefits FHIR with Documents not found.
    Given The document query type is EOB
    And with the query header details below
      | X-Correlation-ID    | MSG:99999999-ebbf-4c77-b1db-9b440cb05003 |
      | channel             | NCP                                      |
      | Accept              | application/fhir+json                    |
      | userID              | 2300350216                               |
      | documentSourceActor | Medicare                                 |
    And with the query param details below
      | patientID    | 8003608333411015 |
      | accessLevel  | GENERAL          |
      | fromDate     | 2010-01-01       |
      | toDate       | 2011-12-31       |
    When I request to get document
    Then the status code for getMedicareOverview operation response is 404
    And the getMedicareOverview response includes
      | resourceType         	| OperationOutcome 										|
      | issue[0].severity    	| error            										|
      | issue[0].code         	| not-found                             					|
      | issue[0].details.text 	| Documents not found.	 		|
      | issue[0].diagnostics  	| PCEHR_INT_004023          							| 

  #@fhir #@Consent
  Scenario: As DHS, I want to get a Consent resource with Documents not found.
    Given The document query type is Consent
    And with the query header details below
      | X-Correlation-ID    | MSG:99999999-ebbf-4c77-b1db-9b440cb05005 |
      | channel             | NCP                                      |
      | Accept              | application/fhir+json                    |
      | userID              | 2300366573                               |
      | documentSourceActor | Medicare                                 |
    And with the query param details below
      | patientID    | 8003608333411015 |
      | accessLevel  | GENERAL          |
      | fromDate     | 2009-01-01       |
      | toDate       | 2009-12-31       |
    When I request to get document
    Then the status code for getMedicareOverview operation response is 404
    And the getMedicareOverview response includes
      | resourceType         	| OperationOutcome 										|
      | issue[0].severity    	| error            										|
      | issue[0].code         	| not-found                             					|
      | issue[0].details.text 	| Documents not found.	 		|
      | issue[0].diagnostics  	| PCEHR_INT_004023          							| 

  #@fhir #@Immunization
  Scenario: As DHS, I want to get a Immunization with Documents not found.
    Given The document query type is Immunization
    And with the query header details below
      | X-Correlation-ID    | MSG:99999999-ebbf-4c77-b1db-9b440cb05007 |
      | channel             | NCP                                      |
      | Accept              | application/fhir+json                    |
      | userID              | 2300366573                               |
      | documentSourceActor | Medicare                                 |
    And with the query param details below
      | patientID    | 8003608333411015 |
      | accessLevel  | GENERAL          |
      | fromDate     | 2008-01-01       |
      | toDate       | 2008-12-31       |
    When I request to get document
    Then the status code for getMedicareOverview operation response is 404
    And the getMedicareOverview response includes
      | resourceType         	| OperationOutcome 										|
      | issue[0].severity    	| error            										|
      | issue[0].code         	| not-found                             					|
      | issue[0].details.text 	| Documents not found.	 		|
      | issue[0].diagnostics  	| PCEHR_INT_004023          							| 