<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="Screener.StockData" %>
 <%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
	<head>
		<link rel="stylesheet" href="styles/screenerPage.css">
		<link rel="stylesheet" href="styles/navbar.css" />
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
		<link
	      href="https://fonts.googleapis.com/css?family=Nunito&display=swap"
	      rel="stylesheet"
	    />
		<script>
				
			function callServlet(){
				event.preventDefault();
				
				let min = document.screenerForm.min.value;
				let max = document.screenerForm.max.value;
				let marketcap = document.screenerForm.marketcap.value;
				
				console.log("min: " + min);
				console.log("max: " + max);
				console.log("cap: " + marketcap);

				let url = "ScreeningServlet?min=" + min + "&max=" + max + "&cap=" + marketcap;

				$.get(url, function(res){
				});
				
				
				console.log("submitted");
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
    
        <h1>SCREENER</h1>
    
    
    	<form name="screenerForm" class="screenerForm" method="GET" action="ScreeningServlet">
    		<input type="number" name="min" placeholder="Min Cost"/>
    		<input type="number" name="max" placeholder="Max Cost"/>
    		<input type="number" name="marketcap" placeholder="Market Cap"/>
    		<input type="submit" class="submitButton">
    	</form>
    	
    	<div class="searchResults">
 			<% if(request.getAttribute("results") != null){
 				ArrayList<StockData> results = (ArrayList<StockData>) request.getAttribute("results");
 	 			System.out.println("results  = " + results.size());
 	 			
 	 			
 	 			for(int i = 0; i < results.size(); i++) { 
 	 				String symbol = results.get(i).getSymbol();
 	 				String name = results.get(i).getName();
 	 			
 	 		%>
 	 				<div class="searchResult">
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
