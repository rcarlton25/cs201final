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

/** Servlet implementation class buySell*/
@WebServlet("/buySell")
public class buySell extends HttpServlet {
	private static final long serialVersionUID = 1L;  
    /*** @see HttpServlet#HttpServlet()*/
    public buySell() { super(); }
    
    //TODO: frontend needs to check if logged in/setAttribute UserID (line 33 in buySell does this for now)
    //FRONTEND PASSES IN VIA request: string(ticker), string(bs) *"b"=buy "s"=sell*, int(shares), double(price) *current price of stock*
    //This will buy/sell shares checking for 1. enough money to buy and 2. enough shares to sell (does nothing in either error case)
    protected void service (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	System.out.println("abc");
    	Connection co = null;
		PreparedStatement ps = null;
		PreparedStatement pss = null;
		PreparedStatement psss = null;
		ResultSet rs = null;
		ResultSet rsss = null;
		try {
			HttpSession session = request.getSession(true);
			session.setAttribute("userID", 1); //Remove later
			int userID = (int)session.getAttribute("userID");
		
			String ticker = request.getParameter("ticker");
			String bs = request.getParameter("bs");
			int shares = Integer.valueOf(request.getParameter("shares"));
			double price = Double.valueOf(request.getParameter("price"));
			int sharesOwned = 0;
			double cash = 0;
	
			co = DriverManager.getConnection("jdbc:mysql://google/csfinal?cloudSqlInstance=cs-final-258501:us-central1:csfinal&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false&user=csfinal&password=csfinal");
			
			//Get user's cash amount
			psss = co.prepareStatement("select cash from users where userID=?");
			psss.setInt(1, userID);
			rsss = psss.executeQuery();
			while(rsss.next()) {
				cash = rsss.getDouble("cash");
			}
			System.out.println("cash" + cash);
			
			//Get current owned shares (if any)
			pss = co.prepareStatement("select * from profile where userID=? and ticker=?");
			pss.setInt(1, userID);
			pss.setString(2, ticker);
			rs = pss.executeQuery();
			while (rs.next()) {
				sharesOwned = rs.getInt("shares");
				price = rs.getDouble("price");
			}
			System.out.println("sharesowned: " + sharesOwned + " price: " + price);
			
			
			if(bs.equals("b")) { //Buy a stock
				if(cash >= shares*price) { //Check you have enough money
					if(sharesOwned > 0) { //Already own some shares
						ps = co.prepareStatement("update profile set shares=? where userID=? and ticker=?");
						ps.setInt(1, sharesOwned + shares);
						ps.setInt(2, userID);
						ps.setString(3, ticker);
						ps.executeUpdate();
						System.out.println("Bought extra");
					}
					else { //Owns no shares already 
						ps = co.prepareStatement("insert into profile(userID, ticker, shares, price, date) values (?, ?, ?, ?, ?)");
						ps.setInt(1, userID);
						ps.setString(2, ticker);
						ps.setInt(3, shares);
						ps.setDouble(4, price);
						ps.setString(5, "20190814");
						ps.executeUpdate();
						System.out.println("Bought new");
					}
					pss = co.prepareStatement("update users set cash=? where userID=?");
					pss.setDouble(1, cash-shares*price);
					pss.setInt(2, userID);
					pss.executeUpdate();
				}
			}
			else { //Sell a stock
				if(shares < sharesOwned) { //Selling some shares
					//TODO: Change date?
					ps = co.prepareStatement("update profile set shares=? where userID=? and ticker=?");
					ps.setInt(1, sharesOwned - shares);
					ps.setInt(2, userID);
					ps.setString(3, ticker);
					ps.executeUpdate();
					System.out.println("Sold some stock");
				}
				else if(shares > sharesOwned) { //Selling error
					System.out.println("ERROR: selling more shares than owned");
				}
				else { //selling all shares
					ps = co.prepareStatement("delete from profile where userID=? and ticker=?");
					ps.setInt(1, userID);
					ps.setString(2, ticker);
					ps.executeUpdate();
					System.out.println("Sold all stock");
				}
				ps = co.prepareStatement("update users set cash=? where userID=?");
				ps.setDouble(1, cash+shares*price);
				ps.setInt(2, userID);
				ps.executeUpdate();
			}
			
			co.close();
			ps.close();
			pss.close();
			psss.close();
			rs.close();
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

