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

/*** Servlet implementation class signup*/
@WebServlet("/signup")
public class signup extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /*** @see HttpServlet#HttpServlet()*/
    public signup() {
        super(); }

    //FRONTEND: error called "registerErr" can be displayed in frontend
    //FRONTEND: send "username", "password", and "confirmPassword"
    protected void service (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection co = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String confirmPassword = request.getParameter("confirmPassword");
		String nextPage = "/registerForm.jsp";
		String dbUsername = "";
		try {	
			HttpSession session = request.getSession(true);
			co = DriverManager.getConnection("jdbc:mysql://google/csfinal?cloudSqlInstance=cs-final-258501:us-central1:csfinal&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false&user=csfinal&password=csfinal");
			ps = co.prepareStatement("SELECT username FROM users WHERE username=?");
			ps.setString(1, username);
			rs = ps.executeQuery();
			while (rs.next()) {
				dbUsername = rs.getString("username");
			}
		
			if(dbUsername.contentEquals(username)) { //If username already exists
				System.out.println("username taken");
				request.setAttribute("registerErr", "Username is already taken");
			}
			else if(!password.contentEquals(confirmPassword) ){ //if passwords don't match
				System.out.println("passwords dont match");
				request.setAttribute("registerErr", "Passwords don't match");
			}
			else { //create new user, add to database, forward to home
				System.out.println("new user made");
				nextPage = "/homePage.jsp";
				ps = co.prepareStatement("insert into users (username, password, cash) values (?, ?, 10000.000)");
				ps.setString(1, username);
				ps.setString(2, confirmPassword);
				ps.executeUpdate(); 
				ps = co.prepareStatement("select userID from users where username=? and password=?");
				ps.setString(1, username);
				ps.setString(2, password);
				rs = ps.executeQuery();
				while(rs.next()) {
					session.setAttribute("userID", Integer.toString(rs.getInt("userID")));
				}
			}
			co.close();
			ps.close();
			rs.close();
			
			System.out.println(nextPage);
			RequestDispatcher dispatch = request.getRequestDispatcher(nextPage);         
	        dispatch.forward(request, response);
		} catch (SQLException sqle){
			System.out.println("SQLException: " + sqle.getMessage());
			
		} finally {
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
