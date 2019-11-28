
var ws;

function connect() {
	//the websocket file actually belongs in the java folder
	//Change path name! 
    ws = new WebSocket("ws://localhost:9080/Jenny_Final/WebSocket");

    ws.onmessage = function(event) 
				    {
				        console.log(event.data);
				        var message = event.data;
				        log.innerHTML += message+ "\n";
				    };
}

function send() {
	console.log("sending");
	var message = "message";
	ws.send(message);
}

