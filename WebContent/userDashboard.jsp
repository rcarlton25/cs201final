<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
   <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">

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
  
  /*  var ws;*/

  function connect() {
  	//the websocket file actually belongs in the java folder
  	//Change path name! 
  	ws = new WebSocket("ws://localhost:8081/cs201final_personal_new/WebSocket");
  	ws.onmessage = function(event) 
  	{
  		console.log(event.data);
  		var message = event.data;

  		$("#notification").append("<div class=" + "alert alert-success alert-dismissible" + ">" + message +  "<button type=" + "button "  + "class=" + "close " + " data-dismiss=" + "alert" + ">&times;</button></div>");
  	};
  }



  function send() {
  	console.log("sending");
  	var message = "message";
  	ws.send(message);
  }
  
	


  
  
  
  

  </script>
	<head>
		<link rel="stylesheet" href="styles/userDashboard.css">
		<link rel="stylesheet" href="styles/navbar.css" />
		<link href="https://fonts.googleapis.com/css?family=Nunito&display=swap" rel="stylesheet">
	</head>
	<body onload="checkIfLoggedIn()">		
	
	<button type="button" onclick="connect();">Subscribe</button>
	<button type="button" onclick="send();">Get News</button>
	<!-- Save user preferences from the backend -->
		<% 
			String[][] stockData = (String[][])request.getAttribute("stockData");
			
			String[][] watchlistData = (String[][])request.getAttribute("watchlistData");
			
		%>
		
		<div id="notification">
		
		</div>
				
 	
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
		
		<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
	</body>
</html>