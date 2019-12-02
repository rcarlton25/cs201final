import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.Random;
import java.util.Timer;
import java.util.TimerTask;
import java.util.Vector; 
import javax.websocket.*; // for space
import javax.websocket.server.ServerEndpoint;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
 
 @ServerEndpoint(value = "/WebSocket") 
 public class WebSocket 
 { 
	 private static Vector<Session> sessionVector = new Vector<Session>();
	 
	 @OnOpen 
	 public void open(Session session) { 
		 System.out.println("Connection madedkdk!"); 
		 sessionVector.add(session); 
		 } 
	 @OnMessage 
	 public void onMessage(String message, Session session) 
	 {
		 //these are keywords that we can search for- in the run function I randomly generate a
		 //number and I choose which keyword to search for
		 String[] keyword = {"bitcoin", "stocks", "finance", "interest rate", "investment", "revenue",
				 	"cash outflow", "collateral", "mortgage", "credit rating", "bull market",
				 	"bear market", "corporate finance", "capital", "business", "investment",
				 	"liability", "insurance", "debt", "stock market"};
		 
		 Random r = new Random();
		 TimerTask timerTask = new TimerTask() {
	     Gson gson = null;
	     GsonBuilder builder = null;
			 @Override
	         public void run() {
				 try {
					 int keywordIndex = r.nextInt((19 - 0) + 1);
					 
					 String desiredUrl = "https://newsapi.org/v2/top-headlines?"
					 					+ "q="
					 					+ "bitcoin"//keyword[keywordIndex]
					 					+ "&apiKey=e6474870100341b68e1328b6a9cc838f";
					 
					 System.out.print(desiredUrl);
					 
					 URL url = new URL(desiredUrl);
					 HttpURLConnection connection = (HttpURLConnection)url.openConnection();
					 connection.setRequestMethod("GET");
					 connection.setReadTimeout(15*1000);
					 connection.connect();
					    
					 BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
					 StringBuilder stringBuilder = new StringBuilder();
					    
					 String line = null;
					 while ((line = reader.readLine()) != null)
					 {
						 stringBuilder.append(line + "\n");
					 }
					 String jsonString = stringBuilder.toString();
					 builder = new GsonBuilder();
					 builder.setPrettyPrinting();
					 gson = builder.create();
					 System.out.println(jsonString);
					 SearchResult results = gson.fromJson(jsonString, SearchResult.class);
					 //FOR TESTING PURPOSES JUST PRINT OUT THE TITLE
					 String firstTitle = results.articles[0].title;
					 session.getBasicRemote().sendText(firstTitle);
					 
					 //FOR JENNA YOU PROBABLY WANT TO RETURN THE ENTIRE CLASS
					 //String jsonNews = gson.toJson(results);
					 //session.getBasicRemote().sendText(jsonNews);
	             } catch (IOException ex) {
	                 System.out.println("there has been an error");
	             }
	         }
	     };
	     //CHANGE THIS- FOR LONGER DELAY MAKE THE TIME LONGER
	     Timer timer = new Timer(true);
	     timer.scheduleAtFixedRate(timerTask, 0, 3 * 100000); 
     }
	 
	 @OnClose 
	 public void close(Session session) 
	 { 
		 System.out.println("Disconnecting!"); 
		 sessionVector.remove(session); 
	 }
	 
	 @OnError 
	 public void error(Throwable error)
	 { 
		 System.out.println("Error!"); 
	 } 
 }
 
class SearchResult 
{
	String status, totalResults;
	Articles[] articles;
}

class Articles {
	String author, title, description, url, urlToImage, publishedAt, content;
	Source source;
}

class Source {
	String id;
	String name;
}