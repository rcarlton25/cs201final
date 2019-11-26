<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <link rel="stylesheet" href="styles/forms.css">
  <link rel="stylesheet" href="styles/navbar.css" />
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script>
	  function checkIfLoggedIn() {
		  var userID = <%=session.getAttribute("userID") %>;
		  console.log(userID);
		  if (userID == -1) { // user is not logged in
			  console.log("equal to -1");
			  return;
		  }
		  if (userID != null) { // then user is logged in
			  $("#signIn").empty();
			  $("#signIn").append("<p onclick=\"signOut()\" class=\"links\">Sign Out</p>");
			  
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
  <meta charset="UTF-8">
  <title>Login</title>
  </head>
  <body onload="checkIfLoggedIn()">
    <!-- This is a header comment -->
    <div id="header">
    	<ul class="navBar">
			<li><a href="homePage.jsp" class="title">STOX</a></li>
			<li><a href="userDashboard.jsp"><img class="rightNav" src="images/newgraydashboardicon.png"></a></li>
			<li><a href="searchPage.jsp"><img class="rightNav" src="images/newgraysearchicon.png"></a></li>
			<li><a href="screenerTool.jsp"><img class="rightNav" src="images/grayscreenicon.png"></a></li>
			
			<li><div id="signIn"><a href="loginForm.jsp" class="links">Login</a><br>
			<a href="registerForm.jsp" class="links">Register</a></div></li>
			
		</ul>
		
		<div id="border"></div>
    

    </div>
 

    <div id="formDiv">
      <form name="loginForm" method="GET" action="homePage.jsp" onsubmit="return validate()">
      	<h3>Login</h3>
      	<div id="usernameDiv">
	        <h2>Username</h2>
	        <input type="text" id="username" />
	        <div id="userErr"></div>
        </div>
        <div id="passwordDiv">
        	<h2>Password</h2>
	        <input type="text" id="password" />
	        <div id="passErr"></div>
	        <div id= "error"></div>
	   
		</div>
		<input class="button" id="btn" type="submit" value="Login">
      </form>
    </div>
    
	<script>

	function validate() {
		var username = document.getElementById('username').value;
		var password = document.getElementById('password').value;
		var errors = false;
		
		$("#error").empty();
		$("#userErr").empty();
		$("#passErr").empty();

	    // if no username entered
	    if (username == null || username == "") {
	        $("#userErr").append("<p>Error: Please enter a username.</p>");
	        errors = true;
	        return false;

	    }
	    // if no password entered
	    if (password == null || password == "") {
	        $("#passErr").append("<p>Error: Please enter a password.</p>");
	        errors = true;
	        return false;

	    }
	
		// if no errors (the user entered something in both fields) then send to backend
		if (!errors) {
			/* code to talk to backend */
			var v = new XMLHttpRequest();
			v.open("GET", "login?username=" + document.getElementById("username").value
					+ "&password=" + document.getElementById("password").value, false);
			v.send();
			if(v.responseText.trim().length > 0) {
				//document.getElementById("error").innerHTML = v.responseText;
				$("#error").append("Error: " + v.responseText);
				console.log(v.responseText);
				return false;
				}
			return true;
		}
	}
	</script>
    
  </body>


</html>
