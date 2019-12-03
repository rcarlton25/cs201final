<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="Screener.StockData" %>
 <%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
  <script>
	  function checkIfLoggedIn() {
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
      			location.href = 'homePage.jsp';
      		}
      	});

	 }
  
  </script>
	<head>
		<link rel="stylesheet" href="styles/screenerPage.css">
		<link rel="stylesheet" href="styles/navbar.css" />
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
		<link
	      href="https://fonts.googleapis.com/css?family=Nunito&display=swap"
	      rel="stylesheet"
	    />
		<script src="getStockDetails.js"></script>

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
        
    <div class="pageContent">
    
        <h1>SCREENER</h1>
        
    	<div class="formDiv">
	    	<form name="screenerForm" class="screenerForm" method="GET" action="ScreeningServlet">
	    		<input type="number" name="min" placeholder="Min Cost"/>
	    		<input type="number" name="max" placeholder="Max Cost"/>
	    		<input type="number" name="marketcap" placeholder="Market Cap"/>
	    		<input type="submit" class="submitButton">
	    	</form>
    	</div>
    	
    	
    	<div class="searchResults" id="searchResults">
 			<% if(request.getAttribute("results") != null){
 				ArrayList<StockData> results = (ArrayList<StockData>) request.getAttribute("results");
 	 			System.out.println("results  = " + results.size());
 	 			
 	 			if(results.size()==0){
 	 				%>
 	 				<div class="errormsg">No results found.</div>
 	 				<%
 	 			}
 	 		
 	 			for(int i = 0; i < results.size(); i++) { 
 	 				String symbol = results.get(i).getSymbol();
 	 				String name = results.get(i).getName();
 	 			
 	 		%>
 	 				<div class="searchResult" id=<%=symbol%> onclick="viewDetails(this);">
	 					<span class="tickerSymbol"><%=symbol%></span> 
	 					<span class="stockName"> <%=name%></span>
	 				</div>
	 		<%
 	 			}
 			}
 			%>
 			
 		</div>
 		
    </div>
 	
  	</body>

</html>
