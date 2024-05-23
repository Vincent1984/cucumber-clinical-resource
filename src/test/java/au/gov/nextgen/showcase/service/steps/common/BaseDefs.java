package au.gov.nextgen.showcase.service.steps.common;

import java.util.HashMap;
import java.util.Map;
import org.springframework.web.util.UriComponentsBuilder;
import com.jayway.restassured.response.Response;

public abstract class BaseDefs {
	protected static UriComponentsBuilder uriComponentsBuilder;
	protected static Map<String, String> headers;
	protected static Map<String, String> querys;
	protected static Map<String, String> paths;
	protected static String body;
	protected static Response response;
	protected static String dataTemplatePath;
	protected static Boolean hasTestData;
	protected static final String PROTOCOL = "TLSv1.2";
	
	public static void initForAll(){
		headers = new HashMap<String, String>();
		querys = new HashMap<String, String>();
		paths = new HashMap<String, String>();
		body = "";
	}
	
	public static void cleanForAll(){
		headers = null;
		querys = null;
		paths = null;
		body = null;
	}
	
	public static void initForDataPrepare(){
		dataTemplatePath = "";
		hasTestData = Boolean.FALSE;
	}
	
	public static void cleanForDataPrepare(){
		dataTemplatePath = null;
		hasTestData = Boolean.FALSE;
	}
	
	public abstract void beforeScenario();
	
	public abstract void afterScenario();

}