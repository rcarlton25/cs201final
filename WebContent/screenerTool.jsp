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
				
				$.get(url, function(res)){
					
				}
				
				<%-- $.get(url, function(res){
					
				/* 	response in results attribute*/		
				/* data is made up of StockData objects */
 					let data = <%= request.getAttribute("results")%>;
					for (let i=0; i<data.length; i++){
						console.log(data[1].getPrice());
						
					}
				});
				 --%>
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
    
    
    	<form name="screenerForm" class="screenerForm" action="" onsubmit="callServlet();">
    		<input type="number" name="min" placeholder="Min Cost"/>
    		<input type="number" name="max" placeholder="Max Cost"/>
    		<input type="number" name="marketcap" placeholder="Market Cap"/>
    		<input type="submit" class="submitButton">
    	</form>
    	
    	<div class="searchResults">
 			<div class="searchResult">
 				<span class="tickerSymbol"></span> <span class="stockName"></span>
 			</div>
 			<%-- <% ArrayList<StockData> results = (ArrayList<StockData>) request.getAttribute("results");
 			 for(int i = 0; i < results.size(); i++) { %>
	 			<div class="searchResult">
	 				<span class="tickerSymbol"><%= results.get(i).getSymbol() %></span> <span class="stockName"> <%=results.get(i).getName() %></span>
	 			</div>
 			<% } %>
 			 --%>
 			
 			
 		</div>
 		
    </div>
 	
  	</body>


</html>