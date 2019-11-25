<!DOCTYPE html>

<html>
<script>
var socket;
function getNotification() {
	socket = new WebSocket("ws://localhost:8080/201_final_myfeatures/Messages");
	
	socket.onopen= function(event) {
		document.getElementById("test").innerHTML = "OPEN";
	}
	
	socket.onmessage= function(event) {
		/* document.getElementById("test").innerHTML = event.data + "<br/>"; */
		alert(event.data);
	}
	
	socket.onclose = function(event) {
		document.getElementById("test").innerHTML = "CLOSED";
	}
}


</script>


<body onload="gsetNotification()">

	<div id="test">
	</div>

</body>
</html>