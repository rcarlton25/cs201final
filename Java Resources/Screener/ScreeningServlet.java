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
		// make sure the 'name' attrs are exactly as follows:
		// define all possible search parameters
		List<String> search_params = Arrays.asList("search_term", "api_token", "search_by", "stock_exchange", "currency", "limit", "page", "sort_by", "sort_order", "output");
		
		// build dictionary to keep track of search parameters and corresponding user input
		Map<String, String> params = new HashMap<String, String>();
		
		for (String p : search_params) {
			String userInput = request.getParameter(p);
			
			// user entered valid input for search param, p
			if(userInput != null && !p.isEmpty()) {
				params.put(p, userInput);
				
			// user did not enter input for search param, p
			// non-entered values = null
			} else {
				params.put(p, null);
			}
		}
		
		// make GET request to screening API
		String jsonResults = ScreenData.getData(search_params, params);
		
		// set attributes
		request.setAttribute("data", jsonResults);
//		session.setAttribute("data", jsonResults);
					
		// send to screening page here (FILL THIS OUT!)
		RequestDispatcher dispatch = getServletContext().getRequestDispatcher("???????????");
        dispatch.forward(request, response);
		
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

}
