<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
  <script>
	  function checkIfLoggedIn() {
		  var userID = <%=session.getAttribute("userID") %>;
		  console.log(userID);
		  if (userID == -1) { // user is not logged in
			  console.log("equal to -1");
			  return;
		  }
		  if (userID != null) { // then user is logged in
			  $("#signIn").empty();
			  $("#signIn").append("<p onclick=\"signOut()\" class=\"links\">Sign Out</p>");
			  
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
				<li><a href="userDashboard.jsp"><img class="rightNav" src="images/newgraydashboardicon.png"></a></li>
				<li><a href="searchPage.jsp"><img class="rightNav" src="images/newgraysearchicon.png"></a></li>
				<li><a href="screenerTool.jsp"><img class="rightNav" src="images/grayscreenicon.png"></a></li>
				
				<li><div id="signIn"><a href="loginForm.jsp" class="links">Login</a><br>
				<a href="registerForm.jsp" class="links">Register</a></div></li>
				
			</ul>
			
			<div id="border"></div>
		
	    </div>
		
		<h1>
			PORTFOLIO
		</h1>
		
		<!-- Stocks -->
		<h2>Stocks</h2>
		<table>
			<% for (int i = 0; i < stockData.length; i++) {%>
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
			<% } %>
		</table>
		
		
		<!-- Watchlist -->
		<h2>Watchlist</h2>
		<table>
			<% for (int i = 0; i < watchlistData.length; i++) {%>
				<tr class ="upStock">
					<td><%= watchlistData[i][0]%></td>
				</tr>
			<% } %>
		</table>
	</body>
</html>