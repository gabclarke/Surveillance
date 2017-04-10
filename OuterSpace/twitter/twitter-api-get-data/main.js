var fs = require('fs-extra'),
	glob = require("glob"),
	path = require("path");


var Twit = require('twit'); // this is how we import the twit package
var T = new Twit({
	// consumer_key:         sensitive.CONSUMER_KEY,
  // consumer_secret:      sensitive.CONSUMER_SECRET,
  // access_token:         sensitive.ACCESS_TOKEN,
  // access_token_secret:  sensitive.ACCESS_TOKEN_SECRET
	consumer_key:         'CONSUMER KEY',
	consumer_secret:      'CONSUMER SECRET',
	access_token:         'ACCESS TOKEN',
	access_token_secret:  'ACCESS TOKEN SECRET'
}); //this is the object of twit which will help us to call functions inside it



module.exports = function(app, io){

	console.log("main module initialized");

	io.on("connection", function(socket){

		socket.on('sendQuery', function(query){
			var params = {
				q: query,
				count: 20
			} // this is the param variable which will have key and value ,the key is the keyword which we are interested in searching and count is the count of it

			T.get('search/tweets', params,searchedData); // get is the function to search the tweet which three paramaters 'search/tweets',params and a callback function.

			function searchedData(err, data, response) {
				console.log(data);
				io.sockets.emit('sendData', data);
			} // searchedData function is a callback function which returns the data when we make a search

		});


	});


// ------------- F U N C T I O N S -------------------



// - - - END FUNCTIONS - - -
};
