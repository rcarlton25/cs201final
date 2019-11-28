<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
  <head>
    <link rel="stylesheet" href="styles/searchPage.css" />
    <link rel="stylesheet" href="styles/navbar.css" />
    
    
    <link
      href="https://fonts.googleapis.com/css?family=Nunito&display=swap"
      rel="stylesheet"
    />
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
    

	    <h1>
	      SEARCH
	    </h1>
    
    
	    <form class="searchForm">
	    	<input type="search" name="searchValue" class="searchBar" placeholder="Type a stock name here" required>
<!-- 	    	<input type="submit" name="submitButton" class="submitButton" value="SEARCH" required>
 -->	</form>
 
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
