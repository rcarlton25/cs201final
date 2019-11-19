package Screener;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

public class ScreenData {
	
	public static String getData(List<String> search_params, Map<String, String> paramsMap) {
//		build url
		String url = "https://api.worldtradingdata.com/api/v1/stock_search?";
		
		for (String p : search_params) {
			String searchVal = paramsMap.get(p);
			if(searchVal != null && !searchVal.isEmpty()) {
				url = url + p + "="+ searchVal + "&";
			}
		}
		System.out.println("Final URL: " + url);
		
		// GET request
		String jsonString = createJsonStringFromURL(url);
		
		GsonBuilder builder = new GsonBuilder();
		builder.setPrettyPrinting();
		Gson gson = builder.create();
		
		StockResult results = gson.fromJson(jsonString, StockResult.class);
		String json = gson.toJson(results);
		
		return json;
	}
	
	private static String createJsonStringFromURL(String desiredUrl) throws Exception {
		URL url = null;
		BufferedReader reader = null;
		StringBuilder stringBuilder;
		
		try {
			url = new URL(desiredUrl);
			HttpURLConnection connection = (HttpURLConnection)url.openConnection();
			connection.setRequestMethod("GET");
			connection.setReadTimeout(15*1000);
		    connection.connect();
		    
		    reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
		    stringBuilder = new StringBuilder();
		    
		    String line = null;
		    while ((line = reader.readLine()) != null)
		    {
		    	stringBuilder.append(line + "\n");
		    }
			
		    return stringBuilder.toString();
		}
		catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		finally {
			//close your reader!
			reader.close();
		}
	}

	
	
}
