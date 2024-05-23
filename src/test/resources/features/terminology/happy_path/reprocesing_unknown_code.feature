#@terminology #@reprocessing #@success
Feature: terminologyReprocessing - Happy Path

  Scenario: For test reprocessing unknown code
    Given I need to prepare the unknown code data into database
      | year | codeSystem                  | code   | display | initialStatus | currentStatus |
      | 2018 | http://pbs.gov.au/code/item | J00MQE | DISPLAY | UNCHECKED     | UNCHECKED     |
      | 2018 | http://pbs.gov.au/code/item | 10004M | DISPLAY | NEW           | NEW           |
      | 2018 | non-existent_code_system    | KKO34  | DISPLAY | NEW           | NEW           |
    When I trigger the execution of reprocessing and the http staus should be 204
    Then the unknown codes shouble be with the expected status as data table
      | year | codeSystem                  | code   | display | initialStatus | currentStatus |
      | 2018 | http://pbs.gov.au/code/item | J00MQE | DISPLAY | UNCHECKED     | NEW           |
      | 2018 | http://pbs.gov.au/code/item | 10004M | DISPLAY | NEW           | COMPLETED     |
      | 2018 | non-existent_code_system    | KKO34  | DISPLAY | NEW           | UNCHECKED     |