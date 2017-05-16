$(document).ready(function(){

// API call format:
// http://api.nytimes.com/svc/news/{version}/content/{source}/{section}[/time-period][.response-format]?api-key={your-API-key}

	var options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
	var today = new Date();
	document.getElementById("today").innerHTML = today.toLocaleDateString("en-US",options);

	var url = "https://api.nytimes.com/svc/news/v3/content/all/all.json";
	var key = config.NYTIMES_KEY;
	url += '?api-key=' + key;

	$.ajax({
	  url: url,
	  method: 'GET',
		success: function (data) {
			console.log(data.results);
			for (var i = 0; i<30; i++){
				if(data.results[i]){
					$(".data").append("<li>")
					$(".data").append("<h1 class='change' data-text='" + data.results[i].title + "'><a href='" + data.results[i].url + "'>" + data.results[i].title + "</a></h1>")
					$(".data").append("<p class='byline'>" + data.results[i].byline + "<p>")
					$(".data").append("<p class='change' data-text='" + data.results[i].abstract + "'>" + data.results[i].abstract + "<p>")
					$(".data").append("</li>")
				}
			}
			$(".data").append("<h3 id='end' class='flip'> That's the newest news. Updated " + today.toLocaleTimeString() + ".</h3>")
		}
	});

});

function printGlitch() {
	// all[0].setAttribute("class", "logo glitch"); // set logo class to glitch
	document.getElementsByClassName("logo")[0].setAttribute("class", "logo glitch");
	document.getElementsByClassName("flip")[0].setAttribute("class", "upsidedown");
	var all = document.getElementsByClassName("change");
	console.log(all);
	console.log(all.length);
	var i;
	for (i = 0; i < all.length; i++) {
		console.log(all[i]);
		var rand = Math.floor((Math.random() * 14));
		var rand2 = Math.floor((Math.random() * 14));
	  all[i].setAttribute("class", "glitch" + rand + " glitch" + rand2);
	}
	window.print();

}
