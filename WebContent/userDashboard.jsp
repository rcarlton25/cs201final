<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
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
		<link rel="stylesheet" href="styles/userDashboard.css">
		<link rel="stylesheet" href="styles/navbar.css" />
		<link href="https://fonts.googleapis.com/css?family=Nunito&display=swap" rel="stylesheet">
	</head>
	<body onload="checkIfLoggedIn()">		
	
	<!-- Save user preferences from the backend -->
		<% 
			String[][] stockData = (String[][])request.getAttribute("stockData");
			
			String[][] watchlistData = (String[][])request.getAttribute("watchlistData");
			
		%>
				
 	
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
		
		<h1>
			PORTFOLIO
		</h1>
		<h2>Cash</h2>
		<%System.out.println("HEY");
		System.out.println(request.getAttribute("cash"));
		%>
		<% if (request.getAttribute("cash") == null) {%>
			<h3>$0</h3>
		<%} else { %>
			<h3>$<%= request.getAttribute("cash") %></h3>
		<%} %>
		
		<!-- Stocks -->
		<h2>Stocks</h2>
		
		<% if (stockData != null ) {%>
		<table>
			<% for (int i = 0; i < stockData.length; i++) {%>
				<%if (stockData[i][0] != null || stockData[i][1] != null || stockData[i][2] != null) {%>
				<tr class="upStock">
				<!-- To redirect to details page for the stock, use a form -->
					<td>
						<form name="stockDetails" method="GET" action="stockDetails.jsp">
							<input hidden=true name="tickerSymbol" value=<%= stockData[i][0] %>>
								<button type="submit">
									<%=  stockData[i][0]%>
								</button>
						</form>
					</td>
					<td><%= stockData[i][1]%><%= stockData[i][1] == "1" ? " share" : " shares"%></td>
					<td>$<%= stockData[i][2]%></td>
				</tr>
				<%} %>
			<% } %>
			</table>
		<% } else { %>
			<h3>You have no purchased stocks.</h3>
		<%} %>
		
		
		<!-- Watchlist -->
		<h2>Watchlist</h2>
		<% if ( watchlistData != null ) {%>
		<table>
			<% for (int i = 0; i < watchlistData.length; i++) {%>
				<%if (watchlistData[i][0] != null) {%>
			
			<%System.out.println(watchlistData); %>
				<tr class ="upStock">
					<td><%= watchlistData[i][0]%></td>
				</tr>
			<% } %>
			<%} %>
		</table>
		<%} else { %>
			<h3>You have no saved stocks.</h3>
		<%} %>
	</body>
</html>