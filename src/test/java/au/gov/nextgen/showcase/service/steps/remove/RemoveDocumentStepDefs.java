package au.gov.nextgen.showcase.service.steps.remove;

import static com.jayway.restassured.RestAssured.given;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.TestPropertySource;
import org.springframework.web.util.UriComponentsBuilder;

import au.gov.myhr.constants.ConstantsUtil;
import au.gov.myhr.dataprepare.DataPrepareServiceImpl;
import au.gov.myhr.dataprepare.SSLConfiguration;
import au.gov.myhr.util.TestUtil;
import au.gov.myhr.velocity.VelocityEngineConfig;
import au.gov.myhr.velocity.VelocityWrapper;
import au.gov.nextgen.showcase.service.steps.common.BaseDefs;
import cucumber.api.java.After;
import cucumber.api.java.Before;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.When;

@ContextConfiguration(classes = {SSLConfiguration.class, VelocityEngineConfig.class, VelocityWrapper.class,
        DataPrepareServiceImpl.class
})
@TestPropertySource(locations = {"/application-test.properties"})
public class RemoveDocumentStepDefs extends BaseDefs {

	@Autowired
	DataPrepareServiceImpl dataPrepareService;

	@Given("^The document type is \"([^\"]*)\" and uri is \"([^\"]*)\"$")
	public void the_document_type_is_something_and_uri_is_something(String docType, String uri) throws Throwable {
		uriComponentsBuilder = UriComponentsBuilder.fromUriString(ConstantsUtil.CLINICAL_RESOURCE_ENDPOINT + uri);
	}

	@When("^I try to remove the document$")
	public void i_try_to_remove_the_document() throws Throwable {
		String accessToken = TestUtil.getCucumberAccessToken();
		response = given().auth().oauth2(accessToken).relaxedHTTPSValidation(PROTOCOL)
				.headers(headers).queryParams(querys).pathParams(paths).body(body).when()
				.delete(uriComponentsBuilder.build().encode().toString());
		response.prettyPrint();
	}

	@And("^Use channel \"([^\"]*)\" in header$")
	public void use_channel_something_in_header(String channel) throws Throwable {
		headers.put("channel", channel);
	}

	@Given("^Prepare remove document data in \"([^\"]*)\"$")
    public void prepare_remove_document_data_in_something(String dataFilePath) throws Throwable {
		dataTemplatePath = dataFilePath;
		dataPrepareService.createDocument(dataTemplatePath);
		hasTestData = Boolean.TRUE;
	}

	@Before("@RemoveDataPrepare")
	public void beforeScenario() {
		dataPrepareService.deleteAll();
		initForDataPrepare();
	}

	@After("@RemoveDataPrepare")
	public void afterScenario() {
//		if (hasTestData) {
//			dataPrepareService.deleteDocument(dataTemplatePath);
//		}
//		cleanForDataPrepare();
	}
}
