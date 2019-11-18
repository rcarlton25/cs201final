<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <link rel="stylesheet" href="styles/forms.css">
  <link rel="stylesheet" href="styles/navbar.css" />
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script>

	window.onload=function(){
	  document.getElementById('btn').addEventListener('click', validate, false)
	};

    function validate() {
      var username = document.getElementById('username').value;
      var password = document.getElementById('password').value;
      var confirmPassword = document.getElementById('confirmPassword').value;

      var errors = false;

      $("#userErr").empty();
      $("#passErr").empty();
      $("#confirmPassErr").empty();


      // if no username entered
      if (username == null || username == "") {
        $("#userErr").append("<p>Error: Please enter a username.</p>");
        errors = true;
      }
      // if no password entered
      if (password == null || password == "") {
        $("#passErr").append("<p>Error: Please enter a password.</p>");
        errors = true;
      }
      // if no confirm password entered
      if (confirmPassword == null || confirmPassword == "") {
        $("#confirmPassErr").append("<p>Error: Please confirm your password.</p>");
        errors = true;
      }
      // if passwords dont match
      if (confirmPassword != password) {
    	 $("#confirmPassErr").empty();
         $("#confirmPassErr").append("<p>Error: Passwords do not match.</p>");
         errors = true;
      }

      // if no errors (the user entered something in both fields) then send to backend
      if (!errors) {
        /* code to talk to backend */

      }

    }

  </script>
  <head>
  <meta charset="UTF-8">
  <title>Register</title>
  </head>
  <body>
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
      <form name="loginForm" method="GET" >
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
		<div id="btnDiv">
        	<input class="button" type="button" value="Register" id="btn" />
        </div>
      </form>
    </div>
  </body>


</html>
