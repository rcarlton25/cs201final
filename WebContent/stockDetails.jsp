<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
 <script>
	  function checkIfLoggedIn() {
		  var userID = <%=session.getAttribute("userID") %>;
		  console.log(userID);
		  if (userID == -1 || userID == null) { // user is not logged in
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
		<!-- TODO: need to make error message div -->
		<link rel="stylesheet" href="styles/stockDetails.css">
		<link href="https://fonts.googleapis.com/css?family=Nunito&display=swap" rel="stylesheet">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
		
		<script>
			function showDetails() {
        
        checkIfLoggedIn();
        
				let stockDataJSON = JSON.parse(localStorage["stockDataJSON"]);
				
				// Get user data first
				var userID = <%= session.getAttribute("userID") %>;
				// Query database
				checkForFavorited(stockDataJSON.ticker, userID);
				// Save as variable
				var isFavorited = <%= session.getAttribute("inFav") %>;
				
    			let stockName = document.createElement('p');
    			stockName.className = "stockName";
    			stockName.innerHTML = stockDataJSON.name;
    			
    			let stockPrice = document.createElement('p');
    			stockPrice.className = "stockPrice";
    			stockPrice.innerHTML = stockDataJSON.price;
    			
    			// Build table
    			let optionsTable = document.createElement('table');
    			optionsTable.idName = "options";
    			
    			// Create tr
    			let optionsRow = document.createElement('tr');
    			optionsRow.idName = "optionsRow";
    			
    			// Create td
    			let buyCell = document.createElement('td');
    			buyCell.idName = "buyCell";
    			
    			let sellCell = document.createElement('td');
    			sellCell.idName = "sellCell";
    			
    			let saveCell = document.createElement('td');
    			saveCell.idName = "saveCell";
    			
    			// Create buttons
    			let buyButton = document.createElement('button');
    			buyButton.innerHTML = 'BUY';
    			if (userID != -1) {
    				buyButton.onclick = function() {
    					buyStocks(stockDataJSON.price, stockDataJSON.ticker);
    				};
    			} else {
    				buyButton.onclick = function() {
    					showWarning();
    				};
    			}
    			
    			let sellButton = document.createElement('button');
    			sellButton.innerHTML = 'SELL';
    			if (userID != -1) {
    				sellButton.onclick = function() {
    					sellStocks(stockDataJSON.price, stockDataJSON.ticker);
    				};
    			} else {
    				sellButton.onclick = function() {
    					showWarning();
    				};
    			}
    			
    			let saveButton = document.createElement('button');
    			saveButton.innerHTML = 'SAVE';
    			option = "a";
    			if (userID != -1) {
    				// Handle case where stock is already favorited
    				if ("t" === isFavorited) {
    					saveButton.innerHTML = 'REMOVE';
    					option = "r";
    				}
    				saveButton.onclick = function() {
    					editWatchlist(stockDataJSON.ticker, userID, option);
    				};
    			} else {
    				saveButton.onclick = function() {
    					showWarning();
    				};
    			}
    			
    			// Append elements together
    			
    			buyCell.append(buyButton);
    			sellCell.append(sellButton);
    			saveCell.append(saveButton);
    			optionsRow.append(buyCell, sellCell, saveCell);
    			optionsTable.append(optionsRow);
    			$('#details').append(stockName, stockPrice, optionsTable);
    			
			}
		
			function showWarning() {
				alert("Please login or register to use this feature!");
			}
			
			function checkForFavorited(ticker, userID) {
				// addFav.java request
 				var xhttp = new XMLHttpRequest();
 				xhttp.open("GET", "addFav?ticker=" + ticker + "&userID=" + userID + "&ar=q", false);
 				xhttp.send();
 				if (xhttp.responseText.trim().length > 0) {
 					document.getElementById("error_msg").innerHTML = xhttp.responseText;
 					return false;
 				}
 				return true;
			}
			
			function buyStocks(price, ticker) {
				numToBuy = prompt("How many shares would you like to buy?");
				
				// buySell.java request
				if (numToBuy != null) {
					var xhttp = new XMLHttpRequest();
	 				xhttp.open("POST", "buySell?ticker=" + ticker + "&bs=b&price=" + price    
							+ "&shares=" + numToBuy, false);
	 				xhttp.send();
	 				if (xhttp.responseText.trim().length > 0) {
	 					document.getElementById("error_msg").innerHTML = xhttp.responseText;
	 					return false;
	 				}
	 				return true;
					
					alert("Shares bought.");
				}	
			}
			
			function sellStocks(price, ticker) {
				numToSell = prompt("How many shares would you like to sell?");
				
				// buySell.java request
				if (numToSell != null) {
					var xhttp = new XMLHttpRequest();
	 				xhttp.open("POST", "buySell?ticker=" + ticker + "&bs=s&price=" + price   
							+ "&shares=" + numToSell, false);
	 				xhttp.send();
	 				if (xhttp.responseText.trim().length > 0) {
	 					document.getElementById("error_msg").innerHTML = xhttp.responseText;
	 					return false;
	 				}
	 				return true;
					
					alert("Shares sold.");
				}
			}
			
			function editWatchlist(ticker, userID, option) {
				// addFav.java request
 				var xhttp = new XMLHttpRequest();
 				xhttp.open("POST", "addFav?ticker=" + ticker + "&userID=" + userID + "&ar=" + option, false);
 				xhttp.send();
 				if (xhttp.responseText.trim().length > 0) {
 					document.getElementById("error_msg").innerHTML = xhttp.responseText;
 					return false;
 				} else {
 					alert("Stock saved to your dashboard!");
 				}
 				return true;
			}
		</script>
		
	</head>

	<body onload="showDetails();">

 	
 		 <!-- Nav bar at top -->
	     <div id="header">
	    
	    	<ul class="navBar">
          <li><a href="homePage.jsp" class="title">STOX</a></li>
          <li><a href="userDashboard.jsp" class="disabled"><img class="rightNav" src="images/newgraydashboardicon.png"></a></li>
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
		<div id="details"></div>
		<div id="error_msg"></div>

	</body>
</html>