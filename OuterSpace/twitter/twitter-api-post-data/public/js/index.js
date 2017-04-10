/* VARIABLES */
var socket = io.connect();

/* sockets */
socket.on('connect', onSocketConnect);
socket.on('error', onSocketError);
socket.on('tweetSended', function(){
	alert('Tweet sent');
});

socket.on('tweetNotSended', function(){
	alert('Tweet not sent');
});


jQuery(document).ready(function($) {

 	var data = "testing testing 1 2 3";

	$('button').on('click', function(){
		socket.emit('tweet', data);
	});
});


/* sockets */
function onSocketConnect() {
	sessionId = socket.io.engine.id;
	console.log('Connected ' + sessionId);
};

function onSocketError(reason) {
	console.log('Unable to connect to server', reason);
};
