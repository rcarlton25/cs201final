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

/*** Servlet implementation class login*/
@WebServlet("/login")
public class login extends HttpServlet {
	private static final long serialVersionUID = 1L;
    /*** @see HttpServlet#HttpServlet()*/
    public login() {
        super();}
    
    
    //FRONTEND: pass in username and password - this will set Session's UserID
    protected void service (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	Connection co = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String dbPass = null;
		int userID = -1;
		int cnt = 0;
		String nextPage = "/loginForm.jsp";
		String username = request.getParameter("username");
		String loginPass = request.getParameter("password");
		try {
			HttpSession session = request.getSession(true);
			co = DriverManager.getConnection("jdbc:mysql://google/csfinal?cloudSqlInstance=cs-final-258501:us-central1:csfinal&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false&user=csfinal&password=csfinal");
			ps = co.prepareStatement("SELECT * FROM users WHERE username=?");
			ps.setString(1, username); 
			//System.out.println(ps);
			rs = ps.executeQuery();

			while (rs.next()) {
				cnt=cnt+ 1;
				dbPass = rs.getString("password");
				userID = rs.getInt("userID");
			}
			
			System.out.println("cnt: " + cnt + " dbPass: " + dbPass + " userID: " +userID);
			if(cnt == 0) { //Invalid username
				request.setAttribute("loginErr", "Invalid Username");
				nextPage ="/loginForm.jsp";
				System.out.println("Invalid username");
			}
			else if( (cnt == 1) && !loginPass.contentEquals(dbPass) ) { //Incorrect password
				request.setAttribute("loginErr", "Incorrect Password");
				nextPage ="/loginForm.jsp";
				System.out.println("Incorrect Password");
			}
			else { //Valid login
				nextPage ="/homePage.jsp";
				session.setAttribute("userID", userID);
			}
			
			co.close();
			ps.close();
			rs.close();
			System.out.println("nextPage: " + nextPage);
			RequestDispatcher dispatch = getServletContext().getRequestDispatcher(nextPage);
			dispatch.forward(request, response);
		}
		catch (SQLException sqle){
			System.out.println("SQLException: " + sqle.getMessage());
		}
		finally {
		}
    }

    
	/*** @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)*/
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}
	/*** @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)*/
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
