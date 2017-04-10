/* VARIABLES */
var socket = io.connect();
var query = "april prank";

/* sockets */
socket.on('connect', onSocketConnect);
socket.on('error', onSocketError);
socket.on('sendData', function(data){
	console.log(data);
	var results = data.statuses;
	$.each(results, function(i, item){
		console.log(item.text);
		$(".data").append('<p>'+item.text+'</p>');
	});
});


jQuery(document).ready(function($) {


});


/* sockets */
function onSocketConnect() {
	sessionId = socket.io.engine.id;
	console.log('Connected ' + sessionId);
	socket.emit('sendQuery', query);
};

function onSocketError(reason) {
	console.log('Unable to connect to server', reason);
};