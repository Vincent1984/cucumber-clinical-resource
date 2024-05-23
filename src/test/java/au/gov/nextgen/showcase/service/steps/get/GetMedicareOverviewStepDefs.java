package au.gov.nextgen.showcase.service.steps.get;

import static com.jayway.restassured.RestAssured.given;
import static org.junit.Assert.assertEquals;

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

import com.jayway.restassured.path.json.JsonPath;
import com.jayway.restassured.path.json.config.JsonPathConfig;
import com.jayway.restassured.path.xml.XmlPath;
import com.jayway.restassured.response.Header;
import com.jayway.restassured.response.Headers;
import com.jayway.restassured.response.Response;

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
public class GetMedicareOverviewStepDefs {

    public static final String PROTOCOL = "TLSv1.2";

    private Response response;

    private Headers headers;

    private String requestUrl;

    private String dataTemplatePath;

    private boolean hasTestData;
    
    private String getRequestUrl;

    private UriComponentsBuilder getUrlBuilder;

    @Autowired
    DataPrepareServiceImpl dataPrepareService;

    @Given("^The document query type is (EOB|Consent|Immunization)$")
    public void document_type(String documentType) {
        switch (documentType) {
            case "EOB":
                getRequestUrl = "/ExplanationOfBenefit";
                break;
            case "Consent":
                getRequestUrl = "/Consent";
                break;
            case "Immunization":
                getRequestUrl = "/Immunization";
                break;
            default:
                break;
        }
        getUrlBuilder = UriComponentsBuilder.fromUriString(ConstantsUtil.CLINICAL_RESOURCE_ENDPOINT + getRequestUrl);
    }

    @And("^Prepare data in (.*)$")
    public void prepareData(String dataFilePath) {
        dataTemplatePath = dataFilePath;
        dataPrepareService.createDocument(dataFilePath);
        hasTestData = true;
    }

    @And("^with the query header details below$")
    public void headers(Map<String, String> maps) throws Throwable {
        List<Header> headerList = new ArrayList<>();
        for (Map.Entry<String, String> field : maps.entrySet()) {
            headerList.add(new Header(field.getKey(), field.getValue()));
        }
        headers = new Headers(headerList);
    }

    @And("^with the query param details below$")
    public void params(Map<String, String> maps) throws Throwable {
        for (Map.Entry<String, String> entry : maps.entrySet()) {
            getUrlBuilder.queryParam(entry.getKey(), entry.getValue());
        }
        requestUrl = getUrlBuilder.build().encode().toString();
    }


    @When("^I request to get document$")
    public void upload_document() throws JSONException {
    	String accessToken = TestUtil.getCucumberAccessToken();
        response = given().auth().oauth2(accessToken).relaxedHTTPSValidation(PROTOCOL)
        		.headers(headers).when().get(requestUrl);
    }

    @Then("^the status code for getMedicareOverview operation response is (\\d+)$")
    public void verify_status_code(int statusCode) throws Throwable {
    	response.prettyPrint();
        response.then().statusCode(statusCode);
    }

    @And("^the getMedicareOverview response includes$")
    public void response_includes(Map<String, String> responseFields) throws Throwable {
        JsonPath jsonPath = new JsonPath(response.asString()).using(new JsonPathConfig("UTF-8"));
        for (Map.Entry<String, String> field : responseFields.entrySet()) {
            assertEquals(field.getValue(), jsonPath.getString(field.getKey()));
        }
    }

    @Before
    public void before() throws InstantiationException, IllegalAccessException, InvocationTargetException, IOException, ParseException {
        dataPrepareService.deleteAll();
    }

    @After
    public void after() throws InstantiationException, IllegalAccessException, InvocationTargetException, IOException, ParseException {
        if (hasTestData) {
            // todo comments deleting logic temporary
            dataPrepareService.deleteDocument(dataTemplatePath);
            hasTestData = false;
        }
    }
}