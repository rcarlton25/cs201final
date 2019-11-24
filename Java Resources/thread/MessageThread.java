package thread;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.ArrayList;

public class MessageThread implements Runnable
{
	private int balance = 0; 
	ArrayList<String> messageList;
	PrintWriter pw;
	
	public MessageThread(Socket s)
	{
		try {
			pw = new PrintWriter(s.getOutputStream());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		ArrayList<String> messageList = new ArrayList<String>();
		for(int j = 0; j < 10; j++)
		{
			messageList.add(j+"");
		}
		this.messageList = messageList;
	}
	
	synchronized public void send(String message)
	{
		pw.println(message);
		pw.flush();
	}

	synchronized public void run() 
	{ 
		for(int i=0; i < 10; i++) 
		{ 
			System.out.println(messageList.get(i));
			try { 
				Thread.sleep((long)(Math.random() * 10000));
				send(messageList.get(i));
			} catch (InterruptedException ie) { 
				System.out.println("interrupted"); 
			}  
		System.out.println(""); 
		}
	} 
}
