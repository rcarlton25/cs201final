<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
	<head>
		<link rel="stylesheet" href="styles/userDashboard.css">
		<link rel="stylesheet" href="styles/navbar.css" />
		<link href="https://fonts.googleapis.com/css?family=Nunito&display=swap" rel="stylesheet">
	</head>
	<body>
		<!-- Save user preferences from the backend -->
		<!-- using dummy data in 2D arrays for now -->
		<% 
			String[][] stockData = {
				{"FB", "2", "190.00", "false"},
				{"GOOGL", "1", "1308.00", "true"},
				{"AAPL", "2", "260.00", "false"},
			};
			
			String[][] watchlistData = {
				{"AMZN", "190.00", "true"},
				{"DOWJ", "130000.00", "true"}
			};
			
		%>
		
		<!-- Nav bar at top -->
		<ul>
			<li><a href="userDashboard.jsp"><img class="leftNav" src="images/newgraydashboardicon.png"></a></li>
			<li><a href="searchPage.jsp"><img class="leftNav" src="images/newgraysearchicon.png"></a></li>
			<li><a href="screenerTool.jsp"><img class="rightNav" src="images/grayscreenicon.png"></a></li>
			<li><a href="userProfile.jsp"><img class="rightNav" src="images/newgrayprofileicon.png"></a></li>
		</ul>
		
		<div id="border"></div>
		
		<h1>
			PORTFOLIO
		</h1>
		
		<!-- Stocks -->
		<h2>Stocks</h2>
		<table>
			<% for (int i = 0; i < stockData.length; i++) {%>
			
				<% if ("true".equals(stockData[i][3])) {%>
					<tr class="upStock">
				<%} else {%>
					<tr class="downStock">
				<% } %>
					<!-- To redirect to details page for the stock, use a form -->
					<td>
						<form name="stockDetails" method="GET" action="stockDetails.jsp">
							<input name="tickerSymbol" value=<%= stockData[i][0] %> hidden>
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
				<% if ("true".equals(watchlistData[i][2])) {%>
					<tr class="upStock">
				<%} else {%>
					<tr class="downStock">
				<% } %>
					<td><%= watchlistData[i][0]%></td>
					<td><%= watchlistData[i][1]%></td>
				</tr>
			<% } %>
		</table>
	</body>
</html>
