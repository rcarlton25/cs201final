import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/*** Servlet implementation class addFav*/
@WebServlet("/addFav")
public class addFav extends HttpServlet {
	private static final long serialVersionUID = 1L;
    /*** @see HttpServlet#HttpServlet()*/
    public addFav() { super(); }

    
    //FRONTEND: pass in ticker(string), ar ("a"=add "r"=remove q="query if in fav")
    protected void service (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	Connection co = null;
		PreparedStatement ps = null;
		PreparedStatement pss = null;
		ResultSet rs = null;
		String tf = "";
		try {
			HttpSession session = request.getSession(true);
			//int userID = (int)session.getAttribute("userID");
			String username = (String) session.getAttribute("username");
			String ticker = request.getParameter("ticker");
			String ar = request.getParameter("ar");
	
			co = DriverManager.getConnection("jdbc:mysql://google/csfinal?cloudSqlInstance=cs-final-258501:us-central1:csfinal&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false&user=csfinal&password=csfinal");
			
			ps = co.prepareStatement("select * from users where username=?");
			ps.setString(1, username);
			rs = ps.executeQuery();
			int userID = -1;
			while(rs.next()) {
				userID = rs.getInt("userID");
			}
			
			if(ar.equals("a")) { //Add to favorites
				ps = co.prepareStatement("INSERT INTO fav (userID, ticker) SELECT ?, ? WHERE NOT EXISTS (SELECT  * FROM fav where userId = ? and ticker = ?)");
				ps.setInt(1, userID);
				ps.setString(2, ticker);
				ps.setInt(3, userID);
				ps.setString(4, ticker);
				ps.executeUpdate();
			}
			else if(ar.equals("q")) { //Query if it's in favorites
				pss = co.prepareStatement("select * from fav where userID=? and ticker=?");
				pss.setInt(1, userID);
				pss.setString(2, ticker);
				rs = pss.executeQuery();
				if(rs.next()) {
					tf = "t";
					session.setAttribute("inFav", tf);
				}
				else {
					tf = "f";
					session.setAttribute("inFav", tf);
				}
			}
			else { //Remove from favorites
				pss = co.prepareStatement("delete from fav where userID=? and ticker=?");
				pss.setInt(1, userID);
				pss.setString(2, ticker);
				pss.executeUpdate();
			}
			co.close();
			ps.close();	
		}
		catch (SQLException sqle){
			sqle.printStackTrace();
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
