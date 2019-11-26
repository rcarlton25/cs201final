 package thread;
 import java.io.IOException; 
 import java.util.Vector; 
 import javax.websocket.*; // for space 
 import javax.websocket.server.ServerEndpoint; 
 
 @ServerEndpoint(value = "/WebSocket") 
 public class WebSocket 
 { 
	 private static Vector<Session> sessionVector = new Vector<Session>(); 
	 @OnOpen 
	 public void open(Session session) { 
		 System.out.println("Connection made!"); 
		 sessionVector.add(session); 
		 } 
	 @OnMessage 
	 public void onMessage(String message, Session session) 
	 { 
		 System.out.println(message); 
		 try { 
			 for(Session s : sessionVector) 
			 { 
				 
				 // push notification back to user 
				 s.getBasicRemote().sendText(message); 
			 }
		 } catch (IOException ioe) 
		 { 
			  System.out.println("ioe: " + ioe.getMessage()); 
			  close(session); 
		  } 
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
