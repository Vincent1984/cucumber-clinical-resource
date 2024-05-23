package au.gov.nextgen.showcase.service;

import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootContextLoader;
import org.springframework.test.context.ContextConfiguration;

import au.gov.myhr.velocity.VelocityEngineConfig;
import au.gov.myhr.velocity.VelocityWrapper;
import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;

/**
 * @author brijesh.thakkar
 *
 */
@RunWith(Cucumber.class)
@CucumberOptions(glue = {"au.gov.nextgen.showcase.service.steps"},
				features = {
						"src/test/resources/features"
		        },
				plugin ="pretty")
@ContextConfiguration(
		classes =  {VelocityEngineConfig.class, VelocityWrapper.class},
		loader = SpringBootContextLoader.class)
public class FeaturesTest {
}
