#@getMedicareOverview #@success
Feature: GetMedicareOverview - Happy Path

  #@fhir #@mbs #@EOB
  Scenario: As DHS, I want to get an Explanation of Benefits FHIR
    Given The document query type is EOB
    And Prepare data in data/getMedicareOverview/get_eob_success.csv
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
    Then the status code for getMedicareOverview operation response is 200
    And the getMedicareOverview response includes
      | resourceType                                            | Bundle                                                    |
      | entry[0].resource.resourceType                          | ExplanationOfBenefit                                               |

  #@fhir #@Consent
  Scenario: As DHS, I want to get a Consent resource
    Given The document query type is Consent
    And Prepare data in data/getMedicareOverview/get_consent_success.csv
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
    Then the status code for getMedicareOverview operation response is 200
    And the getMedicareOverview response includes
      | resourceType                                            | Bundle                                                    |
      | entry[0].resource.resourceType                          | Consent                                               |

  #@fhir #@Immunization
  Scenario: As DHS, I want to get a Immunization 
    Given The document query type is Immunization
    And Prepare data in data/getMedicareOverview/get_immunization_success.csv
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
    Then the status code for getMedicareOverview operation response is 200
    And the getMedicareOverview response includes
      | resourceType                                            | Bundle                                                    |
      | entry[0].resource.resourceType                          | Immunization                                               |
      | entry[1].resource.resourceType                          | Immunization                                               |
