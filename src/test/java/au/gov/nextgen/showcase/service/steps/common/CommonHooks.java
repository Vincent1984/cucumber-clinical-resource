package au.gov.nextgen.showcase.service.steps.common;

import com.jayway.restassured.RestAssured;
import com.jayway.restassured.config.SSLConfig;
import cucumber.api.java.After;
import cucumber.api.java.Before;

public class CommonHooks {
	
	private static final String PROTOCOL = "TLSv1.2";
	
	@Before
	public void beforeAllScenarios() {
		RestAssured.config = RestAssured.config().sslConfig(new SSLConfig().allowAllHostnames().relaxedHTTPSValidation(PROTOCOL));
		BaseDefs.initForAll();
	}

	@After
	public void afterAllScenarios() {
		BaseDefs.cleanForAll();
	}

}
