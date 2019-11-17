<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
	<head>
		<link rel="stylesheet" href="styles/stockDetails.css">
		<link href="https://fonts.googleapis.com/css?family=Nunito&display=swap" rel="stylesheet">
	</head>
	<body>
		<!-- Save user preferences from the backend -->
		<!-- using dummy data in 2D arrays for now -->
		<% 
			String[] stockData = {
				"Facebook, Inc.", "190.00", "false"
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
				<td><button>BUY</button></td>
				<td><button>SELL</button></td>
				<td><button>SAVE</button></td>
			</tr>
		</table>
		
	</body>
</html>