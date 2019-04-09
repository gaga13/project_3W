<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="resources/js/jquery-3.3.1.min.js"></script>
<script
	src="https://api2.sktelecom.com/tmap/js?version=1&format=javascript&appKey=99ed5523-2eb1-46fb-8cf0-60d0377b2345"></script>
<script>
function initTmap(){
	if (!navigator.geolocation){
	    alert('사용자의 브라우저는 지오로케이션을 지원하지 않습니다.');
	    return;
	}
	
    navigator.geolocation.getCurrentPosition(success, error, optionCall);
    
    var optionCall = { enableHighAccuracy: true, maximumAge: 0, timeout: 5000 };
	
  	function success(position) {
	    lat = position.coords.latitude;
	    lng = position.coords.longitude;
	    
	    $.ajax({
			url: 'locationSave',
			type: 'POST',
			data: {lat: lat, lng: lng},
			dataType: 'text',
			success: function(){
				alert('성공');
			}
		});
  	};
	
  	function error() {
  	    alert('사용자의 위치를 찾을 수 없습니다.');
  	  };
}

</script>
<title>현재위치 불러와서 session에 저장하기</title>
</head>
<body onload="initTmap()">

</body>
</html>