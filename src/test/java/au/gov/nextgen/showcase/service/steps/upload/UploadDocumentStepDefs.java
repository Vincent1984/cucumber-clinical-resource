package au.gov.nextgen.showcase.service.steps.upload;

import static com.jayway.restassured.RestAssured.given;
import static org.hamcrest.Matchers.equalTo;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.text.ParseException;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.ArrayUtils;
import org.json.JSONException;
import org.junit.Assert;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.TestPropertySource;
import org.springframework.web.util.UriComponentsBuilder;

import com.google.gson.internal.LinkedTreeMap;
import com.jayway.restassured.response.Header;
import com.jayway.restassured.response.Headers;
import com.jayway.restassured.response.Response;
import com.jayway.restassured.response.ValidatableResponse;

import au.gov.myhr.constants.ConstantsUtil;
import au.gov.myhr.dataprepare.DataPrepareServiceImpl;
import au.gov.myhr.dataprepare.SSLConfiguration;
import au.gov.myhr.domain.UnknownCode;
import au.gov.myhr.util.TestUtil;
import au.gov.myhr.velocity.VelocityEngineConfig;
import au.gov.myhr.velocity.VelocityWrapper;
import cucumber.api.java.Before;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;

/**
 * Created by juan.manuel.caicedo on 10/07/2017.
 * Updated by xiaohui.c.liu on 19/07/1027
 */
@ContextConfiguration(classes = {SSLConfiguration.class, VelocityEngineConfig.class, VelocityWrapper.class,
        DataPrepareServiceImpl.class
})
@TestPropertySource(locations = {"/application-test.properties"})
public class UploadDocumentStepDefs {

    public static final String PROTOCOL = "TLSv1.2";

    private Response response;

    private Map<String, Object> params = new HashMap<String, Object>();

    private Headers headers;

    private Headers deleteHeaders;

    private ValidatableResponse json;

    private Header[] defaultHeaders;

    private String uploadRequestUrl;

    private UriComponentsBuilder uploadUrlBuilder;

    private static UriComponentsBuilder deleteUrlBuilder = UriComponentsBuilder.fromHttpUrl(ConstantsUtil.CLINICAL_RESOURCE_ENDPOINT);

    @Autowired
    DataPrepareServiceImpl dataPrepareService;

    @Autowired
    private VelocityWrapper velocityWrapper;

    @Before
    public void before() throws InstantiationException, IllegalAccessException, InvocationTargetException, IOException, ParseException {
        dataPrepareService.deleteAll();
        dataPrepareService.deleteAllCode();
    }

    @Given("^The document type is (EOB|Consent|Immunization)$")
    public void document_type(String documentType) {
        switch (documentType) {
            case "EOB":
                uploadRequestUrl = "/ExplanationOfBenefit";
                break;
            case "Consent":
                uploadRequestUrl = "/Consent";
                break;
            case "Immunization":
                uploadRequestUrl = "/";
                break;
            default:
                break;
        }
        uploadUrlBuilder = UriComponentsBuilder.fromUriString(ConstantsUtil.CLINICAL_RESOURCE_ENDPOINT + uploadRequestUrl);
    }

    @And("^with headers below$")
    public void with_headers_below(Map<String, String> maps) throws Throwable {
        defaultHeaders = new Header[maps.size()];
        int i = 0;
        for (Map.Entry<String, String> field : maps.entrySet()) {
            defaultHeaders[i] = new Header(field.getKey(), field.getValue());
            i++;
        }
    }

    @And("^The IHI number is (\\d+)$")
    public void ihi_number(long ini_number) throws Throwable {
        params.put("patient_id", ini_number);
        defaultHeaders = (Header[]) ArrayUtils.addAll(defaultHeaders,
                new Header[]{new Header("patientID", String.valueOf(ini_number))});
        uploadUrlBuilder.queryParam("patientID", String.valueOf(ini_number));
    }

    @And("^document id is (.*)$")
    public void patient_document(String documentId) throws Throwable {
        params.put("doc_id", documentId);
        defaultHeaders = (Header[]) ArrayUtils.addAll(defaultHeaders,
                new Header[]{new Header("documentID", documentId)});
        uploadUrlBuilder.queryParam("documentID", documentId);
        deleteUrlBuilder.pathSegment("nonprod/removeResource", documentId);
    }

    @And("^delete document if it exist with HTTP response (\\d+) or (\\d+)$")
    public void delete_patient(int statusCode1, int statusCode2) {
        String accessToken = TestUtil.getCucumberAccessToken();
        deleteHeaders = new Headers(defaultHeaders);
        response = given().auth().oauth2(accessToken).relaxedHTTPSValidation(PROTOCOL)
                .headers(deleteHeaders)
                .when()
                .delete(deleteUrlBuilder.build().encode().toString());
//        This part is used to suit for the different delete operation
        if (statusCode1 == response.getStatusCode()) {
            response.then().statusCode(statusCode1);
        } else if (statusCode2 == response.getStatusCode()) {
            response.then().statusCode(statusCode2);
        } else {
            response.then().statusCode(200);
        }
    }

    @And("^a health care provider who uploads the Document with HTTP details as below$")
    public void headers(Map<String, String> maps) throws Throwable {
        Header[] headersArray = new Header[maps.size()];
        int i = 0;
        for (Map.Entry<String, String> field : maps.entrySet()) {
            headersArray[i] = new Header(field.getKey(), field.getValue());
            i++;
        }

        headers = new Headers((Header[]) ArrayUtils.addAll(defaultHeaders, headersArray));
    }


    @When("^I upload a document (.*)$")
    public void upload_document(String fileName) throws JSONException {
        String accessToken = TestUtil.getCucumberAccessToken();
        String content = velocityWrapper.wrap(params, "data/uploadDocument/" + fileName + ".json");
        response = given().auth().oauth2(accessToken).relaxedHTTPSValidation(PROTOCOL)
                .headers(headers).body(content).when().post(uploadUrlBuilder.build().encode().toString());
        response.prettyPeek();
    }

    @Then("^the status code for record creation response is (\\d+)$")
    public void verify_status_code(int statusCode) throws Throwable {
        json = response.then().statusCode(statusCode);
    }

    @And("^the response header parameter Location exists and have right structure$")
    public void verify_response_header_location() {
        String location = response.getHeader("Location");
        System.out.println(location);
        Assert.assertNotNull(location);
    }

    @And("^the response includes$")
    public void response_includes(Map<String, String> responseFields) throws Throwable {
        for (Map.Entry<String, String> field : responseFields.entrySet()) {
            json.body(field.getKey(), equalTo(field.getValue()));
        }
    }

    @And("^the unknown code table should has records contained in below data table$")
    public void validateUnknownCode(List<UnknownCode> records) {
        records.forEach(record -> {
            Calendar current = Calendar.getInstance();
            current.setTime(new Date());
            int year = current.get(Calendar.YEAR);
            System.out.println("query: " + record);
            List<LinkedTreeMap<String, Object>> unknownCode = dataPrepareService.queryUnknownCode(year, record.getCodeSystem(), record.getCode(),
                    record.getInitialStatus());
            System.out.println("result: " + unknownCode);
            Assert.assertNotNull(unknownCode);
        });
    }

    @And("^the unknown code table should not has records contained in below data table$")
    public void validateNotExistUnknownCode(List<UnknownCode> records) {
        records.forEach(record -> {
            Calendar current = Calendar.getInstance();
            current.setTime(new Date());
            int year = current.get(Calendar.YEAR);
            List<LinkedTreeMap<String, Object>> unknownCode = dataPrepareService.queryUnknownCode(year, record.getCodeSystem(), record.getCode(),
                    null);
            Assert.assertNull(unknownCode);
        });
    }
}
