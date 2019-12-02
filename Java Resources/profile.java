import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class profile
 */
@WebServlet("/profile")
public class profile extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public profile() { super(); }
    
    //FRONTEND: in front get attributes stockData, watchlistData, and cash
    protected void service (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	Connection co = null; 
		PreparedStatement ps = null;
		ResultSet rs = null;
		int i = 0;
		int j = 0;
		double cash = 0;
		String[][] fav = new String[30][1];
		String[][] buy = new String[30][3];
		try {
			HttpSession session = request.getSession(true);
			int userID = (int)session.getAttribute("userID");
			
			co = DriverManager.getConnection("jdbc:mysql://google/csfinal?cloudSqlInstance=cs-final-258501:us-central1:csfinal&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false&user=csfinal&password=csfinal");
			
			//Get user's cash amount
			ps = co.prepareStatement("select cash from users where userID=?");
			ps.setInt(1, userID);
			rs = ps.executeQuery();
			while(rs.next()) {
				cash = rs.getDouble("cash");
			}
			System.out.println("cash" + cash);
			
			//Get shares owned by user
			ps = co.prepareStatement("select * from profile where userID=? order by profID");
			rs = ps.executeQuery();
			while(rs.next()) {
				buy[i][0] = rs.getString("ticker");
				buy[i][1] = String.valueOf(rs.getInt("shares"));
				buy[i][2] = String.valueOf(rs.getDouble("price"));
				i++;
			}
			
			//Get favorite shares
			ps = co.prepareStatement("select * from fav where userID=?");
			rs = ps.executeQuery();
			while(rs.next()) {
				fav[j][0] = rs.getString("ticker");
				j++;
			}
			
			co.close();
			ps.close();
			rs.close();
			request.setAttribute("stockData", buy);
			request.setAttribute("watchlistData", fav);
			request.setAttribute("cash", cash);
			String next = "/userDashboard.jsp";
			RequestDispatcher dispatch = getServletContext().getRequestDispatcher(next);
			dispatch.forward(request, response);
		}
		catch (SQLException sqle){
			sqle.printStackTrace();
		}
		finally {
		}
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);}
}

