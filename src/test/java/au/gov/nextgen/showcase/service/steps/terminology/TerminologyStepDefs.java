package au.gov.nextgen.showcase.service.steps.terminology;

import static com.jayway.restassured.RestAssured.given;

import java.util.List;

import org.junit.Assert;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.TestPropertySource;

import com.google.gson.internal.LinkedTreeMap;

import au.gov.myhr.constants.ConstantsUtil;
import au.gov.myhr.dataprepare.DataPrepareServiceImpl;
import au.gov.myhr.dataprepare.SSLConfiguration;
import au.gov.myhr.domain.UnknownCode;
import au.gov.myhr.velocity.VelocityEngineConfig;
import au.gov.myhr.velocity.VelocityWrapper;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;

/**
 * @author xingang.a.wang
 * @create 2017-11-24 8:56 AM
 */
@ContextConfiguration(classes = {SSLConfiguration.class, VelocityEngineConfig.class, VelocityWrapper.class,
        DataPrepareServiceImpl.class
})
@TestPropertySource(locations = {"/application-test.properties"})
public class TerminologyStepDefs {

    @Autowired
    private DataPrepareServiceImpl dataPrepareService;

    private static final String PROTOCOL = "TLSv1.2";

    private static final String ReprocessingURL = ConstantsUtil.TERMINOLOGY_ENDPOINT+"/UnknownCode/$reprocess";

    @Given("^I need to prepare the unknown code data into database$")
    public void prepareUnknownCode(List<UnknownCode> codes) {
    	dataPrepareService.deleteAllCode();
        codes.forEach(code -> dataPrepareService.saveUnknownCode(code));
    }

    @When("^I trigger the execution of reprocessing and the http staus should be (.*)$")
    public void triggerReprocessing(int expectedHttpStausCode) {
        given().relaxedHTTPSValidation(PROTOCOL)
                .post(ReprocessingURL)
                .then()
                .statusCode(expectedHttpStausCode);
    }

    @Then("^the unknown codes shouble be with the expected status as data table$")
    public void validateUnknownCodeStatus(List<UnknownCode> codes) {
        codes.forEach(expected -> {
        	List<LinkedTreeMap<String, Object>> actual = dataPrepareService.queryUnknownCode(expected.getYear(), expected.getCodeSystem(),
                    expected.getCode(),
                    expected.getInitialStatus());
            Assert.assertNotNull(actual);
            Assert.assertEquals(expected.getCurrentStatus(), actual.get(0).get("currentStatus"));
        });
    }
}
