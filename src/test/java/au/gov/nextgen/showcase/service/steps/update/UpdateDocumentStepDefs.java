package au.gov.nextgen.showcase.service.steps.update;

import static com.jayway.restassured.RestAssured.given;
import static org.hamcrest.Matchers.equalTo;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.json.JSONException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.TestPropertySource;
import org.springframework.web.util.UriComponentsBuilder;

import com.jayway.restassured.response.Header;
import com.jayway.restassured.response.Headers;
import com.jayway.restassured.response.Response;
import com.jayway.restassured.response.ValidatableResponse;

import au.gov.myhr.constants.ConstantsUtil;
import au.gov.myhr.dataprepare.DataPrepareServiceImpl;
import au.gov.myhr.dataprepare.SSLConfiguration;
import au.gov.myhr.util.TestUtil;
import au.gov.myhr.velocity.VelocityEngineConfig;
import au.gov.myhr.velocity.VelocityWrapper;
import cucumber.api.java.After;
import cucumber.api.java.Before;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;

/**
 * Created by zhihua.kang on 22/08/2017.
 */
@ContextConfiguration(classes = {SSLConfiguration.class, VelocityEngineConfig.class, VelocityWrapper.class,
        DataPrepareServiceImpl.class
})
@TestPropertySource(locations = {"/application-test.properties"})
public class UpdateDocumentStepDefs {

    public static final String PROTOCOL = "TLSv1.2";

    private Response response;

    private Headers headers;

    private String requestUrl;

    private ValidatableResponse json;

    private String dataTemplatePath;

    private boolean hasTestData;

    @Autowired
    DataPrepareServiceImpl dataPrepareService;

    private String updateRequestUrl;

    private UriComponentsBuilder updateUrlBuilder;

    @Given("^Prepare document data in \"([^\"]*)\"$")
    public void prepareData(String dataFilePath) {
        dataTemplatePath = dataFilePath;
        dataPrepareService.createDocument(dataFilePath);
        hasTestData = true;
    }

    @And("^The document as type of (EOB|Consent|Immunization)$")
    public void document_type(String documentType) {
        switch (documentType) {
            case "EOB":
                updateRequestUrl = "/ExplanationOfBenefit";
                break;
            case "Consent":
                updateRequestUrl = "/Consent";
                break;
            case "Immunization":
                updateRequestUrl = "/Immunization";
                break;
            default:
                break;
        }
        updateUrlBuilder = UriComponentsBuilder.fromUriString(ConstantsUtil.CLINICAL_RESOURCE_ENDPOINT + updateRequestUrl);
    }

    @And("^with the put header details below$")
    public void headers(Map<String, String> maps) throws Throwable {
        List<Header> headerList = new ArrayList<>();
        for (Map.Entry<String, String> field : maps.entrySet()) {
            headerList.add(new Header(field.getKey(), field.getValue()));
        }
        headers = new Headers(headerList);
    }

    @And("^with the action params details below$")
    public void params(Map<String, String> maps) throws Throwable {

        for (Map.Entry<String, String> entry : maps.entrySet()) {
            updateUrlBuilder.queryParam(entry.getKey(), entry.getValue());
        }
        requestUrl = updateUrlBuilder.build().encode().toString();
    }


    @When("^I want to update the document$")
    public void update_document() throws JSONException {
    	String accessToken = TestUtil.getCucumberAccessToken();
        response = given().auth().oauth2(accessToken).relaxedHTTPSValidation(PROTOCOL)
        		.headers(headers).when().put(requestUrl);
        response.prettyPrint();
    }

    @Then("^the status code for update document response is (\\d+)$")
    public void verify_status_code(int statusCode) throws Throwable {
        response.prettyPeek();
        json = response.then().statusCode(statusCode);
    }

    @And("^the update document response includes$")
    public void response_includes(Map<String, String> responseFields) throws Throwable {
        for (Map.Entry<String, String> field : responseFields.entrySet()) {
            json.body(field.getKey(), equalTo(field.getValue()));
        }
    }

    @Before
    public void before() throws InstantiationException, IllegalAccessException, InvocationTargetException, IOException, ParseException {
        dataPrepareService.deleteAll();
    }

    @After
    public void after() throws InstantiationException, IllegalAccessException, InvocationTargetException, IOException, ParseException {
        if (hasTestData) {
            dataPrepareService.deleteDocument(dataTemplatePath);
            hasTestData = false;
        }
    }
}