package _Final_Project;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Database 
{
	private static final long serialVersionUID = 1L;
	
	public static void check(String username, String password, int cash) throws ClassNotFoundException
	{
		//connect to database
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		//SQL Queries
		String sql = "jdbc:mysql://google/csfinal"
					+ "?cloudSqlInstance=cs-final-258501:us-central1:csfinal"
					+ "&socketFactory=com.google.cloud.sql.mysql.SocketFactory"
					+ "&useSSL=false"
					+ "&user=csfinal"
					+ "&password=csfinal";

		
		//get all rows from pagevisited
		String insert_name = "INSERT INTO users (username, password, cash) VALUES(?,?, ?)";
		

		try {
			conn = DriverManager.getConnection(sql);
			
		
			//if the username does not already exist
			ps = conn.prepareStatement(insert_name);
			ps.setString(1, username);
			ps.setString(2, password);
			ps.setInt(3, cash);
			ps.executeUpdate();
		}
			
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		finally {
			//close connections
			try{
				if(rs != null)
				{
					rs.close();
				}
				if(ps != null)
				{
					ps.close();
				}
				if(conn != null)
				{
					conn.close();
				}
			}
			catch(SQLException sqle)
			{
				System.out.println("sqle: " + sqle.getMessage());
			}
		}
	}
	
	public static void main(String[] args) throws ClassNotFoundException
	{
		check("jenny", "lee", 300);
	}
}