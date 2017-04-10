// day || night
// experiment by Gaby Clarke, Spring 2017
// Parsons Paris Art, Media, and Technology
// Core Lab: Spatial

// This experiment makes use of HTML5 Geolocation
// (https://www.w3schools.com/html/html5_geolocation.asp) and the Sunrise Sunset
// API (http://sunrise-sunset.org/api).

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
	var angle;

  if (!navigator.geolocation){
    output.innerHTML = "<p>Geolocation is not supported by your browser.</p>";
    return;
  }

  function success(position) {
    lat = position.coords.latitude.toFixed(8);
    long = position.coords.longitude.toFixed(8);

		$.ajax({
			type: 'GET',
			url: "http://api.sunrise-sunset.org/json?lat="+lat+"&lng="+long+"&date=today&formatted=0",
			dataType: 'json',
			success: function (data) {
				rise = data.results.sunrise.slice(11,19);
				set = data.results.sunset.slice(11,19);
				h = ('0'+h).slice(-2);
				m = ('0'+m).slice(-2);
				s = ('0'+s).slice(-2);
				now = h+":"+m+":"+s;
				angle = Math.atan($(document).height()/$(document).width())/(Math.PI / 180);

				if (now > rise && now < set){
					document.body.style.background = "#F4B908";
				} else if (now == rise) {
					document.body.style.background= "linear-gradient("+angle+"deg, #051F2B 50%, #F4B908 50%)";
				} else if (now == set) {
					document.body.style.background= "linear-gradient("+angle+"deg, #F4B908 50%, #051F2B 50%)";
				} else {
					document.body.style.background = "#051F2B";
				}
			},
			error: function() { alert('Failed!'); },
		});
  }

  function error() {
    output.innerHTML = "Unable to retrieve your location";
  }

	navigator.geolocation.getCurrentPosition(success, error);

});
