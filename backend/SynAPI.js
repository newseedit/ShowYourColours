var SynAPI = (function(){
	var baseApiUrl = 'http://10.12.74.110/';
	var lon = 0;
	var lat = 0;

	function init(){
		getLocation();
	}

	function getHashtag(hashtag,cbSuccess,cbFail){
		$.ajax({
		  url: baseApiUrl+'hashtag/'+hashtag,
		  type: 'GET',
		  data: '',
		  success: cbSuccess,
		  fail: cbFail
		});
	}

	function searchHashtag(partial,cbSuccess,cbFail){
		$.ajax({
		  url: baseApiUrl+'hashtag/',
		  type: 'GET',
		  data: 'partial='+partial,
		  success: cbSuccess,
		  fail: cbFail
		});
	}

	function putColour(hashtag,colour,cbSuccess,cbFail){
		$.ajax({
		  url: baseApiUrl+'hashtag/'+hashtag+'/',
		  type: 'POST', // TODO: should be PUT but PHP is obnoxious...  
		  data: 'colour='+colour+'&lat='+lat+'&lon='+lon,
		  success: cbSuccess,
		  fail: cbFail
		});
	}

	function addPreset(hashtag,colour,cbSuccess,cbFail){
		$.ajax({
		  url: baseApiUrl+'hashtag/'+hashtag+'/preset/',
		  type: 'POST',  
		  data: 'colour='+colour,
		  success: cbSuccess,
		  fail: cbFail
		});
	}

	function getLocation() {
	    if (navigator.geolocation) {
	        navigator.geolocation.getCurrentPosition(setPosition);
	    }
	}

	function setPosition(pos){
		lon = pos.coords.latitude;
		lat = pos.coords.longitude;
		console.log(pos.coords);
	}

	return {
		init: init,
		getHashtag: getHashtag,
		putColour: putColour,
		searchHashtag: searchHashtag
	};

})();