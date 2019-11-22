package backend;
import java.io.BufferedReader;
import java.lang.reflect.Type;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Date;
import java.text.SimpleDateFormat;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.internal.LinkedTreeMap;
import com.google.gson.stream.JsonReader;
import com.google.gson.stream.JsonToken;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.text.html.HTMLDocument.Iterator;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;

@WebServlet("/Search") 
public class Search extends HttpServlet
{
	private static String search_stock(String ticker) throws Exception {
		String desiredUrl = "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY"
					+ "&symbol="
					+ ticker
					+ "&interval=5min"
					+ "&apikey=JG4Q2Y4CORWL03SQ";
		
		//String desiredUrl=java.net.URLEncoder.encode(url_search,"UTF-8");
		
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
			
		    GsonBuilder builder = new GsonBuilder();
			builder.setPrettyPrinting();
		    Gson gson = builder.create();
		    String jsonString = stringBuilder.toString();
		  
		    String timeSeries = jsonString.substring(jsonString.indexOf("Time Series (Daily)") + 23, jsonString.length() - 2).trim();
		    timeSeries = "{\n\t" + timeSeries;
		    timeSeries = timeSeries.trim();
		    
		    SimpleDateFormat formatter= new SimpleDateFormat("yyyy-MM-dd");
		    Date date = new Date(System.currentTimeMillis());
		    String currDate = formatter.format(date);
		    System.out.println(timeSeries);
		    
		    
		    Map<String,Object> map = new HashMap<String,Object>();
		    map = (Map<String,Object>) gson.fromJson(timeSeries, map.getClass());
		    
		   // System.out.println(map);
		    
		    Map<String, Stock> mappy = new HashMap<String, Stock>();
		    
		    for(Object objectName : map.keySet()) 
		    {
		    	   System.out.println(objectName);
		    	   System.out.println(map.get(objectName));
		    	   String jsonStock = gson.toJson(map.get(objectName));
		    	   Stock stocky = gson.fromJson(jsonStock, Stock.class);
		    	   String strKey = objectName + "";
		    	   mappy.put(strKey, stocky);
		    }
		    
		    String sendToFront = gson.toJson(mappy);
		    return sendToFront;
		    
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

	protected void service(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException 
	{
		 String username = request.getParameter("username");
		 String sendToFront = "";
		try {
			sendToFront = search_stock("GM");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 PrintWriter print = response.getWriter();
		 print.println(sendToFront);
		 print.flush();
		 print.close();
	}
}