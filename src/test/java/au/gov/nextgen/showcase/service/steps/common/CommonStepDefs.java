package au.gov.nextgen.showcase.service.steps.common;

import static org.junit.Assert.assertEquals;
import java.util.List;
import java.util.Map;
import com.jayway.restassured.path.json.JsonPath;
import com.jayway.restassured.path.json.config.JsonPathConfig;
import cucumber.api.DataTable;
import cucumber.api.PendingException;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;

public class CommonStepDefs extends BaseDefs {

    @Then("^the status code of response is \"([^\"]*)\"$")
    public void the_status_code_of_response_is_something(String statusCode) throws Throwable {
    	response.then().statusCode(Integer.parseInt(statusCode));
    }

    @And("^with header params detail as$")
    public void with_header_params_detail_as(DataTable headerTable) throws Throwable {
    	List<Map<String,String>> headerList = headerTable.asMaps(String.class, String.class);
    	for(Map<String,String> headerMap : headerList){
    		headers.put(headerMap.get("Key"), headerMap.get("Value"));
    	}
    }

    @And("^with query params detail as$")
    public void with_query_params_detail_as(DataTable queryTable) throws Throwable {
    	List<Map<String,String>> queryList = queryTable.asMaps(String.class, String.class);
    	for(Map<String,String> queryMap : queryList){
    		querys.put(queryMap.get("Key"), queryMap.get("Value"));
    	}
    }

    @And("^verify the JSON OperationOutcome response includes$")
    public void verify_the_json_operationoutcome_response_includes(DataTable responseTable) throws Throwable {
    	JsonPath jsonPath = new JsonPath(response.asString()).using(new JsonPathConfig("UTF-8"));
    	List<Map<String,String>> responseList = responseTable.asMaps(String.class, String.class);
        for (Map<String,String> responseMap : responseList) {
            assertEquals(responseMap.get("Value"), jsonPath.getString(responseMap.get("Key")));
        }
    }
    
    @Given("^The request method is \"([^\"]*)\" and uri is \"([^\"]*)\"$")
    public void the_request_method_is_something_and_uri_is_something(String strArg1, String strArg2) throws Throwable {
        throw new PendingException();
    }

    @When("^I trigger the request$")
    public void i_trigger_the_request() throws Throwable {
        throw new PendingException();
    }
    
    @And("^with request body has defined in the file \"([^\"]*)\"$")
    public void with_request_body_has_defined_in_the_file_something(String strArg1) throws Throwable {
        throw new PendingException();
    }

	@Override
	public void beforeScenario() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void afterScenario() {
		// TODO Auto-generated method stub
		
	}
}
