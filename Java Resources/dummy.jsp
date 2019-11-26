<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Insert title here</title>
	<script>
	var socket;
	
	function connectToServer() 
	{ 
		 socket = new WebSocket("ws://localhost:8080/Jenny_Final/WebSocket"); 
		 socket.onopen = function(event) 
		 { 
			 document.getElementById("mychat").innerHTML += "Connected!"; 
		 } 
		 socket.onmessage = function(event) 
		 { 
		 	document.getElementById("mychat").innerHTML += event.data + "<br />"; 
		 } 
		 socket.onclose = function(event) 
		 { 
		 	document.getElementById("mychat").innerHTML += "Disconnected!"; 
		 } 
	} 
	function sendMessage() 
	{ 
		 socket.send("Jeff: " + document.chatform.message.value); 
		 return false; 
    }
	</script>
</head>
<body onload="connectToServer()">
	<h1>welcome to my dummy page</h1>
	<form name="chatform" onsubmit="return sendMessage();"> 
	    <input type="text" name="message" value="Type Here!" /><br /> 
		<input type="submit" name="submit" value="Send Message" /> 
	</form>
	<br /> 
	<div id="mychat"></div>
</body>
</html>