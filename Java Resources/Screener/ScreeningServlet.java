package Screener;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Screener.StockResult;
import Screener.StockData;
import Screener.ScreenData;

/**
 * Servlet implementation class ScreeningServlet
 */
@WebServlet("/ScreeningServlet")
public class ScreeningServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ScreeningServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
				
		// make GET request to screening API
		ArrayList<StockData> results = null;
		try {
			// # of batches
			int numGroups = 1;
			results = ScreenData.getData(numGroups);
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println(results.size());
		
		// set attributes (results = arraylist of StockData objects)
		request.setAttribute("results", results);
//		session.setAttribute("data", jsonResults);
					
		// send to screening page here (FILL THIS OUT!)
		RequestDispatcher dispatch = getServletContext().getRequestDispatcher("/test.jsp");
        dispatch.forward(request, response);
		
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

}