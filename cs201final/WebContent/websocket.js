var ws;

function connect() {
    
    var host = document.location.host;
    var pathname = document.location.pathname;

    ws = new WebSocket("ws://localhost:9080/Jenny_Final/WebSocket");

    ws.onmessage = function(event) {
    var log = document.getElementById("log");
        console.log(event.data);
        var message = JSON.parse(event.data);
        log.innerHTML += message.from + " : " + message.content + "\n";
    };
}

function send() {
    var content = document.getElementById("msg").value;
    var json = JSON.stringify({
        "content":content
    });

    ws.send(json);
}

