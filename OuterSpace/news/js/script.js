
$(document).ready(function(){

// API call format:
// http://api.nytimes.com/svc/news/{version}/content/{source}/{section}[/time-period][.response-format]?api-key={your-API-key}

	var options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
	var today = new Date();
	document.getElementById("today").innerHTML = today.toLocaleDateString("en-US",options);

	var url = "https://api.nytimes.com/svc/news/v3/content/all/all.json";
	url += '?api-key=bb61482c14134196b907cea6abe3e8e2';

	$.ajax({
	  url: url,
	  method: 'GET',
		success: function (data) {
			console.log(data.results);
			for (var i = 0; i<30; i++){
				if(data.results[i]){
					$(".data").append("<li>")
					// $(".data").append("<img src='" + data.results[i].thumbnail_standard + "'>")
					$(".data").append("<h1><a href='" + data.results[i].url + "'>" + data.results[i].title + "</a></h1>")
					$(".data").append("<p class='byline'>" + data.results[i].byline + "<p>")
					$(".data").append("<p>" + data.results[i].abstract + "<p>")
					$(".data").append("</li>")
				}
			}
			$(".data").append("<h3 id='end'> That's the newest news. </h3>")
		}
	})
});
