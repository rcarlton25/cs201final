<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <link rel="stylesheet" href="styles/forms.css">
  <link rel="stylesheet" href="styles/navbar.css" />
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <head>
  <meta charset="UTF-8">
  <title>Register</title>
  </head>
  <body>
  	ERROR MESSAGE:
	<div id= "error">
	</div>
    <div id="header">
      <span class="a">
	      <h1>(name of website)</h1>
	  </span>
	  <span class="b">
	      <a href="loginForm.jsp">Login</a>
	  </span>
	  <span class="c">
	      <a href="registerForm.jsp">Register</a>
      </span>
    </div>
    <div id="navBar">
      <p>nav bar will go here</p>
    </div>

    <div id="formDiv">
      <form name="loginForm" method="GET" action="homePage.jsp" onsubmit="return validate()">
      	<h3>Register</h3>
      	<div id="usernameDiv">
	        <h2>Username</h2>
	        <input type="text" id="username"/>
	        <div id="userErr"></div>
        </div>
        <div id="passwordDiv">
        	<h2>Password</h2>
	        <input type="text" id="password" />
	        <div id="passErr"></div>
		</div>
		<div id="confirmPasswordDiv">
        	<h2>Confirm Password</h2>
	        <input type="text" id="confirmPassword" />
	        <div id="confirmPassErr"></div>
		</div>
		<input class="button" id="sign" type="submit" value="signup">
      </form>
    </div>
    
	<script>

	function validate() {
		var username = document.getElementById('username').value;
		var password = document.getElementById('password').value;
		var confirmPassword = document.getElementById('confirmPassword').value;
		var errors = false;
		
		
		$("#userErr").empty();
		$("#passErr").empty();
		$("#confirmPassErr").empty();
	
		// if no errors (the user entered something in both fields) then send to backend
		if (!errors) {
			/* code to talk to backend */
			var v = new XMLHttpRequest();
			v.open("GET", "signup?username=" + document.getElementById("username").value
					+ "&password=" + document.getElementById("password").value
					+ "&confirmPassword=" + document.getElementById("confirmPassword").value, false);
			v.send();
			if(v.responseText.trim().length > 0) {
				document.getElementById("error").innerHTML = v.responseText;
				//TODO: take returned error and print properly
				return false;
				}
			return true;
		}
	}
	</script>
    
  </body>


</html>
