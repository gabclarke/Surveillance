
$(document).ready(function(){

	// Documentation: http://sunrise-sunset.org/api
	var lat = 48.864716;
	var long = 2.349014;
	var rise;
	var set;
	var d = new Date();
	var h = d.getHours();
	var m = d.getMinutes();
	var s = d.getSeconds();
	var now;

	$.ajax({
		type: 'GET',
		url: "http://api.sunrise-sunset.org/json?lat="+lat+"&lng="+long+"&date=today&formatted=0",
		dataType: 'json',
		success: function (data) {
			rise = data.results.sunrise.slice(11,19);
			set = data.results.sunset.slice(11,19);
			now = h+":"+m+":"+s;

			if (now > rise ){
			document.body.style.background = "#F4B908";
			}


			if (now>set) {
				document.body.style.background = "#051F2B";
			}

			$(".data").append('<p>'+rise+'</p>');
			$(".data").append('<p>'+set+'</p>');
			$(".data").append('<p>'+h+":"+m+":"+s+'</p>');

			// console.log(data.results.sunset)
		},
		error: function() { alert('Failed!'); },
	});
});
