<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Insert title here</title>
	<link rel="stylesheet" href="styles/userDashboard.css">
	<link rel="stylesheet" href="styles/navbar.css" />
	<link href="https://fonts.googleapis.com/css?family=Nunito&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
		
	<script>
		function connect() {
			//the websocket file actually belongs in the java folder
			//Change path name! 
		    ws = new WebSocket("ws://localhost:9080/jennyWillDie/WebSocket");
	
		    ws.onmessage = function(event) 
						    {
						        console.log(event.data);
						        var message = event.data;
						        log.innerHTML += message+ "\n";
						        
								$("#notification").append("<div class=" + "alert alert-info alert-dismissible" + ">" + message +  "<button type=" + "button "  + "class=" + "close " + " data-dismiss=" + "alert" + ">&times;</button></div>");

						        
						        
						    };
		}
	
		function send() {
			console.log("sending");
			var message = "message";
			ws.send(message);
		}
	</script>
	<table>
            <tr>
                <td>
                    <button type="button" onclick="connect();" >Connect</button>
                </td>
            </tr>
            <tr>
<!--                 <td> -->
<!--                     <textarea readonly="true" rows="10" cols="80" id="log"></textarea> -->
<!--                 </td> -->
            </tr>
            <tr>
                <td>
                    <button type="button" onclick="send();" >Would you like to see tips from bloomberg</button>
                </td>
            </tr>
            <tr>
            	<td>
            		<div id = "log"></div>
            	</td>
            </tr>
        </table>
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
			
			<div id="notification">
			</div>
			
			<!-- Nav bar at top -->
			<ul>
				<li><a href="userDashboard.jsp"><img class="leftNav"
						src="images/newgraydashboardicon.png"></a></li>
				<li><a href="searchPage.jsp"><img class="leftNav"
						src="images/newgraysearchicon.png"></a></li>
			
				<li><a href="screenerTool.jsp"><img class="rightNav"
						src="images/grayscreenicon.png"></a></li>
				<li><a href="userProfile.jsp"><img class="rightNav"
						src="images/newgrayprofileicon.png"></a></li>
			</ul>
			
			<div id="border"></div>
			
			<h1>PORTFOLIO</h1>
			
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
				
				<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
			<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
			<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
			</html>
			    </body>
					</head></ht
	ml>
