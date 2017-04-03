
$(document).ready(function(){

	// For documentation check : https://github.com/Giphy/GiphyAPI
	var apiKey = "dc6zaTOxFJmzC";
	var request = "rad";
	var limit = 12;

	$.ajax({
		type: 'GET',
		url: "http://api.giphy.com/v1/gifs/search?q="
				 +request+"&api_key="+apiKey+"&limit="+limit,
		dataType: 'json',
		success: function (data) {
			console.log(data.data[0]);
			for(var i = 0; i<limit; i++){
				if(data.data[i]){
					$(".data").append('<li class="col col-m-6 col-4"><img src="'
										+data.data[i].images.downsized_large.url+'"></li>');
				}
			}

		},
		error: function() { alert('Failed!'); },
	});
});
