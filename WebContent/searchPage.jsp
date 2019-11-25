<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
  <head>
    <link rel="stylesheet" href="styles/searchPage.css" />
    <link rel="stylesheet" href="styles/navbar.css" />
    
    <link
      href="https://fonts.googleapis.com/css?family=Nunito&display=swap"
      rel="stylesheet"
    />
    
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    
    
    <script>
	    function makeApiCall(){
	    	event.preventDefault();
	    	
	/*     	below code makes API call previously done in Search.java and correctly recieves JSON data as response */    	 
				
	 		let url = "https://www.alphavantage.co/query?function=SYMBOL_SEARCH"
				+ "&keywords="
				+ document.searchForm.searchValue.value
				+ "&apikey=JG4Q2Y4CORWL03SQ";
	    	 
	    	 $.get(url, function(data) {
	/*     		delete previous results before rendering new results
	 */    		$("#searchResults").empty();
	
	    		let resultsArray = data.bestMatches;
	    		
	    		if(resultsArray.length === 0){
	        		$("#searchResults").text("No results for " + document.searchForm.searchValue.value + ".");
	
	    		}
	    		
	    		resultsArray.forEach(function(result){
	    			
	    			let resultDiv = document.createElement('div');
	    			resultDiv.className = "searchResult";
	/*     			set div id to stock ticker symbol for use later in api call in viewDetails()
	 */    			resultDiv.id = result["1. symbol"];
	/* set onclick function to fetch stock details and redirect to details page */
					resultDiv.onclick = function(){
						viewDetails(this);
					};
	    			
	    			let tickerSymbol = document.createElement('span');
	    			tickerSymbol.className = "tickerSymbol";
	    			tickerSymbol.innerHTML = result["1. symbol"];
	    			
	    			let stockName = document.createElement('span');
	    			stockName.className = "stockName";
	    			stockName.innerHTML = result["2. name"];
	    			
	    			resultDiv.append(tickerSymbol, stockName);
	    			
	    			$("#searchResults").append(resultDiv);
	    		});
	   		}); 
    	}
    
	    function viewDetails(result){
	    	let symbol = result.id;
	    	let url = "https://api.worldtradingdata.com/api/v1/stock?symbol=" + symbol + "&api_token=BLj5qqwiK1mbeAy32nSMUNDbrJaTiNoFTBm89tEHpJx3IZ9ysAnETDUdK2rv";
	    	$.get(url, function(response){
	    		
	    		let stock = response.data[0];
	         	let stockDataJSON = {};
	         	
	         	stockDataJSON["name"] = stock.name;
	         	stockDataJSON["ticker"] = stock.symbol;
	         	stockDataJSON["price"] = stock.price;
	    		stockDataJSON["isGreen"] = parseFloat(stock.day_change) > 0 ? true : false;
	         	stockDataJSON["cap"] = stock.market_cap;
	         	stockDataJSON["yearlyHigh"] = stock["52_week_high"];
	         	stockDataJSON["yearlyLow"] = stock["52_week_low"];
	         	stockDataJSON["exchange"] = stock.stock_exchange_short;
	         	
	         	localStorage["stockDataJSON"] = JSON.stringify(stockDataJSON);
	        	
				window.location.href = "stockDetails.jsp";
	    	});
   		}    
    </script>
  </head>
  <body>
    <!-- Nav bar at top -->
    <ul>
      <li>
        <a href="userDashboard.jsp"
          ><img class="leftNav" src="images/newgraydashboardicon.png"
        /></a>
      </li>
      <li>
        <a href="searchPage.jsp"
          ><img class="leftNav" src="images/newgraysearchicon.png"
        /></a>
      </li>
      <li>
        <a href="screenerTool.jsp"
          ><img class="rightNav" src="images/grayscreenicon.png"
        /></a>
      </li>
      <li>
        <a href="userProfile.jsp"
          ><img class="rightNav" src="images/newgrayprofileicon.png"
        /></a>
      </li>
    </ul>

    <div id="border"></div>
    
    <div class="pageContent">
    
	    <h1>
	      SEARCH
	    </h1>
    
	    <form name="searchForm" class="searchForm" action="" onsubmit="makeApiCall();">
	    	<input type="search" name="searchValue" class="searchBar" placeholder="Type a stock name or ticker symbol here (ie. Facebook or FB)" required>
		</form>
 
 		<div class="searchResults" id="searchResults"></div>
 		
    </div>
    
  </body>
</html>
