
$(document).ready(function(){

// http://api.nytimes.com/svc/news/{version}/content/{source}/{section}[/time-period][.response-format]?api-key={your-API-key}
// http://api.nytimes.com/svc/news/v3/content/all/all.json?api-key=bb61482c14134196b907cea6abe3e8e2

	var url = "https://api.nytimes.com/svc/news/v3/content/all/all.json";
	url += '?api-key=bb61482c14134196b907cea6abe3e8e2';
	console.log('attempting');

	$.ajax({
	  url: url,
	  method: 'GET',
		success: function (data) {
			console.log('success');
			console.log(data.results);
			for (var i = 0; i<30; i++){
				if(data.results[i]){
					$(".data").append("<li>" + data.results[i].title + "</li>")
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

	// var apiKey = "bb61482c14134196b907cea6abe3e8e2";
	//
	// $.ajax({
	// 	type: 'GET',
	// 	// url: "http://api.giphy.com/v1/gifs/search?q="
	// 	// 		 +request+"&api_key="+apiKey+"&limit="+limit,
	// 	url: "http://api.nytimes.com/svc/news/v3/content/all/all?limit=15&api-key=" + apiKey,
	// 	dataType: 'json',
	// // 	success: function (data) {
	// // 		console.log(data)
	// // 		// console.log(data.data[0]);
	// // 		// for(var i = 0; i<limit; i++){
	// // 		// 	if(data.data[i]){
	// // 		// 		$(".data").append('<li class="col col-m-6 col-4"><img src="'
	// // 		// 							+data.data[i].images.downsized_large.url+'"></li>');
	// // 		// 	}
	// // 		// }
	// //
	// // 	},
	// // 	error: function() { alert('Failed!'); },
	// // });
	// }).done(function(result) {
	// console.log(result);
	// }).fail(function(err) {
	// throw err;
	// });
});
