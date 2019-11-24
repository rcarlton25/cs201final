<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
				/* $.get("", function(data) {
			        console.log(data);
			    }); */
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
 				<span class="tickerSymbol">GOOG</span> <span class="stockName">Alphabet</span>
 			</div>
 			<div class="searchResult">
 				<span class="tickerSymbol">GOOGL</span> <span class="stockName">Alphabet</span>
 			</div>
 			<div class="searchResult">
 				<span class="tickerSymbol">GOOS</span> <span class="stockName">Canadian Goose</span>
 			</div>
 		</div>
    </div>
 	
  	</body>


</html>
