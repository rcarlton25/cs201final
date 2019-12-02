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
		<link rel="stylesheet" href="styles/stockDetails.css">
		<link rel="stylesheet" href="styles/navbar.css">
		<link href="https://fonts.googleapis.com/css?family=Nunito&display=swap" rel="stylesheet">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
		
		<script>
			function showWarning() {
				alert("Please login or register to use this feature!");
			}
			
			function buyStocks() {
				numToBuy = prompt("How many shares would you like to buy?");
				// send with Ajax to backend
				alert("Shares bought.");
			}
			
			function sellStocks() {
				numToSell = prompt("How many shares would you like to sell?");
				// send with Ajax to backend
				alert("Shares sold.");
			}
			
			function saveToWatchlist() {
				alert("Stock saved to your dashboard!");
				// send with Ajax to backend
			}
		</script>
		
	</head>
	<body onload="checkIfLoggedIn()">
		<!-- Save user preferences from the backend -->
		<!-- using dummy data in 2D arrays and boolean for now  -->
		<!-- Later: use Stock and User object -->
		<% 
			String[] stockData = {
				"Facebook, Inc.", "190.00", "false"
			};
		
			boolean user = true;
			
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
		
	    </div>
	    
	    <div id="disableLinks"></div>
		
		<h1>
			DETAILS
		</h1>
		
		<table>
			<tr id="stockName">
				<td><%= stockData[0] %></td>
			</tr>
			<tr>
				<% if ("true".equals(stockData[2])) {%>
					<td class="upStock">
				<%} else { %>
					<td class="downStock">
				<%} %>	
					<%= stockData[1]%>
				</td>
			</tr>
		</table>
		<table>
			<tr>
				<!-- Disable buttons if not logged in -->
				<td>
					<% if (user != true) {%> 
						<button onclick="showWarning()">BUY</button>
					<% } else { %>
						<button onclick="buyStocks()">BUY</button>
					<% } %>
				</td>
				<td>
					<% if (user != true) {%> 
						<button onclick="showWarning()">SELL</button>
					<% } else { %>
						<button onclick="sellStocks()">SELL</button>
					<% } %>
				</td>
				<td>
					<% if (user != true) {%> 
						<button onclick="showWarning()">SAVE</button>
					<% } else { %>
						<button onclick="saveToWatchlist()">SAVE</button>
					<% } %>
				</td>
			</tr>
		</table>
		
	</body>
</html>