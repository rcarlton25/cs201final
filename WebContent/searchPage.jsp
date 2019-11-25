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
    		/* delete previous results before rendering new results */
    		$("#searchResults").empty();

    		let resultsArray = data.bestMatches;
    		
    		resultsArray.forEach(function(result){
    			
    			let resultDiv = document.createElement('div');
    			resultDiv.className = "searchResult";
    			
    			let tickerSymbol = document.createElement('span');
    			tickerSymbol.className = "tickerSymbol";
    			tickerSymbol.innerHTML = result["1. symbol"];
    			
    			let stockName = document.createElement('span');
    			stockName.className = "stockName";
    			stockName.innerHTML = result["2. name"];
    			
    			resultDiv.append(tickerSymbol, stockName);
    			
    			$("#searchResults").append(resultDiv);
    		
    		}) ;
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
	    	<input type="search" name="searchValue" class="searchBar" placeholder="Type a stock ticker symbol here (ie. FB)" required>
		</form>
 
 
 		<div class="searchResults" id="searchResults"></div>
 		
	    
    </div>
    
    
  </body>
</html>
