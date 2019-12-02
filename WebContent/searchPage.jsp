<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

  <script>
	  function checkIfLoggedIn() {
		  console.log("HELLLLLOOOOOOO");
		  var userID = <%=session.getAttribute("userID") %>;
		  console.log(userID);
		  if (userID == -1) { // user is not logged in
			  console.log("equal to -1");
			  document.getElementById("disableLinks").innerHTML = "<style>" +
				"a.disabled { pointer-events: none; cursor: default;}" +
			    "</style>";
			  return;
		  }
		  if (userID != null) { // then user is logged in
			  $("#signIn").empty();
			  $("#signIn").append("<p onclick=\"signOut()\" class=\"links\">Sign Out</p>");
			  document.getElementById("disableLinks").innerHTML = "";

			  console.log("user is signed in");
		  }
	  }
	  function signOut() {
          $.ajax({
      		url: "logOut",
      		data: { },
      		success: function(result) {
      			$("#signIn").empty();
  			    $("#signIn").append("<a href=\"loginForm.jsp\" class=\"links\">Login</a><br><a href=\"registerForm.jsp\" class=\"links\">Register</a>");
      		}
      	});

	 }
  
  </script>
  <head>
    <link rel="stylesheet" href="styles/searchPage.css" />
    <link rel="stylesheet" href="styles/navbar.css" />
    
    <link
      href="https://fonts.googleapis.com/css?family=Nunito&display=swap"
      rel="stylesheet"
    />
    
   <script src="getStockDetails.js"></script>
    
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
    
	    
    </script>
  </head>
  <body onload="checkIfLoggedIn()">
 	
 		 <!-- Nav bar at top -->
     <div id="header">
    
    	<ul class="navBar">
			<li><a href="homePage.jsp" class="title">STOX</a></li>
			<li><a href="profile" class="disabled"><img class="rightNav" src="images/newgraydashboardicon.png"></a></li>
			<li><a href="searchPage.jsp"><img class="rightNav" src="images/newgraysearchicon.png"></a></li>
			<li><a href="screenerTool.jsp" class="disabled"><img class="rightNav" src="images/grayscreenicon.png"></a></li>
			
			<li><div id="signIn"><a href="loginForm.jsp" class="links">Login</a><br>
			<a href="registerForm.jsp" class="links">Register</a></div></li>
			
		</ul>
		
		<div id="border"></div>
		<div id="disableLinks"></div>
	
    </div>

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
