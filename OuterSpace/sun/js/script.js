
// Documentation: http://sunrise-sunset.org/api

$(document).ready(function(){

	var lat;
	var long;
	var rise;
	var set;
	var d = new Date();
	var h = d.getHours();
	var m = d.getMinutes();
	var s = d.getSeconds();
	var now;

	var output = document.getElementById("out");

  if (!navigator.geolocation){
    output.innerHTML = "<p>Geolocation is not supported by your browser.</p>";
    return;
  }

  function success(position) {
    lat = position.coords.latitude.toFixed(8);
    long = position.coords.longitude.toFixed(8);
    // output.innerHTML = '<p>Latitude is ' + lat + '° <br>Longitude is ' + long + '°</p>';
		$.ajax({
			type: 'GET',
			url: "http://api.sunrise-sunset.org/json?lat="+lat+"&lng="+long+"&date=today&formatted=0",
			dataType: 'json',
			success: function (data) {
				rise = data.results.sunrise.slice(11,19);
				console.log(rise);
				set = data.results.sunset.slice(11,19);
				now = h+":"+m+":"+s;

				if (now > rise && now < set){
					document.body.style.background = "#F4B908";
				} else {
					document.body.style.background = "#051F2B";
				}
				//
				// $(".data").append('<p>'+rise+'</p>');
				// $(".data").append('<p>'+set+'</p>');
				// $(".data").append('<p>'+h+":"+m+":"+s+'</p>');

			},
			error: function() { alert('Failed!'); },
		});
  }

  function error() {
    output.innerHTML = "Unable to retrieve your location";
  }

  // output.innerHTML = "<p>Locating…</p>";

	navigator.geolocation.getCurrentPosition(success, error);

});