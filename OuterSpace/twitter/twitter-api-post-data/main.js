var fs = require('fs-extra'),
	glob = require("glob"),
	path = require("path");


var Twit = require('twit'); // this is how we import the twit package
var T = new Twit({
	consumer_key:         'CONSUMER KEY',
  consumer_secret:      'CONSUMER SECRET',
  access_token:         'ACCESS TOKEN',
  access_token_secret:  'ACCESS TOKEN SECRET'
}); //this is the object of twit which will help us to call functions inside it



module.exports = function(app, io){

	console.log("main module initialized");

	io.on("connection", function(socket){

		socket.on('tweet', function(tweet){
			var tweet = {
				status: tweet 
			} // this is the tweet message

				T.post('statuses/update', tweet, tweeted); // this is how we actually post a tweet ,again takes three params 'statuses/update' , tweet message and a call back function

				function tweeted(err, data, response) {

					if(err){
						io.sockets.emit('tweetNotSended');
						console.log("Something went wrong!");

					}

					else{
						io.sockets.emit('tweetSended');
						console.log("Voila It worked!");

					}

				} // this is the call back function which does something if the post was successful or unsuccessful.
		});


	});


// ------------- F U N C T I O N S -------------------



// - - - END FUNCTIONS - - - 
};
