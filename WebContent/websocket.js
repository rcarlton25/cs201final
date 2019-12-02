function connect() {
	//the websocket file actually belongs in the java folder
	//Change path name! 
	ws = new WebSocket("ws://localhost:9081/cs201final_personal_new/WebSocket");

	ws.onmessage = function(event) 
	{
		console.log(event.data);
		var message = event.data;

		$("#notification").append("<div class=" + "alert alert-info alert-dismissible" + ">" + message +  "<button type=" + "button "  + "class=" + "close " + " data-dismiss=" + "alert" + ">&times;</button></div>");
	};
}




function send() {
	console.log("sending");
	var message = "message";
	ws.send(message);
}