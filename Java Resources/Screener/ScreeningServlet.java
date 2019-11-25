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
		
		System.out.println("HELLO");
		
		// make GET request to screening API
		ArrayList<StockData> results = null;
		try {
			// # of batches
			int numGroups = 1;
			results = ScreenData.getData(numGroups);
		} catch (Exception e) {
			e.printStackTrace();
		}
		// get input parameters from user form
		String minPriceStr 			= request.getParameter("min");
		String maxPriceStr			= request.getParameter("max");
		String inputMarketCapStr	= request.getParameter("marketcap");
		
		double min = 0;
		double max = 0;
		double mcap = 0;
		
		try {
			min = Double.parseDouble(minPriceStr);
		} catch (Exception e) {
			min = 0;
		}
		
		try {
			max = Double.parseDouble(maxPriceStr);
		} catch (Exception e) {
			max = 99999999999.99;
		}
		
		try {
			mcap = Double.parseDouble(inputMarketCapStr);
		} catch (Exception e) {
			mcap = 0.0;
		}
		
		ArrayList<StockData> finalData = new ArrayList<StockData>();
		for(int i = 0; i < results.size(); i++) {
			StockData data = results.get(i);
			
			double dataPrice = 0.0;
			double dataMCap = 0.0;
			
			try {
				dataPrice = Double.parseDouble(data.getPrice());
			} catch(Exception e ) {
				dataPrice = 0.0;
			}
			try {
				dataMCap = Double.parseDouble(data.getMarketCap());
			} catch(Exception e ) {
				dataMCap = 0.0;
			}
						
			// check user input
			if(dataPrice >= min && dataPrice <= max) {
				// market cap  set
				if(mcap != 0.0) {
					if(dataMCap >= mcap) {
						finalData.add(data);
					}
				// market cap not set
				} else {
					finalData.add(data);
				}
				
			}
			
		}

		System.out.println("servlet: " + minPriceStr + " " + maxPriceStr + " " + inputMarketCapStr);
		
		// set attributes (results = arraylist of StockData objects)
		request.setAttribute("results", finalData);
//		session.setAttribute("data", jsonResults);
					
		// send to screening page here (FILL THIS OUT!)
		RequestDispatcher dispatch = getServletContext().getRequestDispatcher("/screenerTool.jsp");
        dispatch.forward(request, response);
		
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

}