
$(document).ready(function(){

// API call format:
// http://api.nytimes.com/svc/news/{version}/content/{source}/{section}[/time-period][.response-format]?api-key={your-API-key}

	var url = "https://api.nytimes.com/svc/news/v3/content/all/all.json";
	url += "?YOURAPI";
	console.log('attempting');

	$.ajax({
	  url: url,
	  method: 'GET',
		success: function (data) {
			console.log('success');
			console.log(data.results);
			for (var i = 0; i<30; i++){
				if(data.results[i]){
					$(".data").append("<li>")
					$(".data").append("<h1>" + data.results[i].title + "</h1>")
					$(".data").append("<p>" + data.results[i].byline + "<p>")
					$(".data").append("<p>" + data.results[i].abstract + "<p>")
					$(".data").append("</li>")
				}
			}
		}
	})
	// }).done(function(result) {
	//   console.log(result);
	// 	for (var i = 0; i++){ // might want to limit this
	//
	// 	}
	//
	// }).fail(function(err) {
	//   throw err;
	// });
});
