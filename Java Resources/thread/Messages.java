package thread;
import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.ArrayList;
import java.util.concurrent.ExecutorService; 
import java.util.concurrent.Executors;

public class Messages extends Thread
{	
	public Messages(int port) throws IOException 
	{ 
		System.out.println("Binding to port " + port);
		ServerSocket ss = new ServerSocket(port);
		Socket s = ss.accept(); // blocking
		System.out.println("Connection from: " + s.getInetAddress());
		
		System.out.println("Bound to port " + port);
		ExecutorService executor = Executors.newCachedThreadPool(); 
		MessageThread thread = new MessageThread(s); 
		executor.execute(thread);  
		executor.shutdown(); 
		while(!executor.isTerminated()) 
		{ 
			Thread.yield(); 
		} 
		return;
	}
	
	public static void main(String [] args) throws IOException {
		Messages cr = new Messages(6111);
	}
 }