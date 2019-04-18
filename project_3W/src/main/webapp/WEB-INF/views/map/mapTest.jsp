<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="resources/js/jquery-3.3.1.js"></script>
<script
   src="https://api2.sktelecom.com/tmap/js?version=1&format=javascript&appKey=99ed5523-2eb1-46fb-8cf0-60d0377b2345"></script>
<script>

$(document).ready(function(){
	getScheduleList();

});

function getScheduleList(){
	$.ajax({
		url:'getScheduleList',
		type: 'post',
		dataType:'json',
		success : function(sList){         
										
				alert('스케쥴 리스트 가져오기 성공');
		
				
				initTmap(sList);
				
		},
		error: function(er){
			alert(JSON.stringify(er));
		}
	});
}

function initTmap(sList){
	
	if (!navigator.geolocation){
	       alert('사용자의 브라우저는 지오로케이션을 지원하지 않습니다.');
	       return;
	   }
	   
	   // 현재 위치정보 딱 한번 얻기
	    navigator.geolocation.getCurrentPosition(success, error, optionCall);
	    
	     //geolocation 옵션. accuracy - true 일시 정확성 높아짐. 대신 응답 느려질 수 있음 / maximumage - 캐시된 위치값의 유효시간 / timeout - 위치를 받아올 때 까지의 대기시간.
	    var optionCall = { enableHighAccuracy: true, maximumAge: 0, timeout: 5000 };
	   
	    // 위치정보 얻기 성공시 자동으로 호출되는 콜백함수. 인자는 Position 객체
	     function success(position) {
	       lat = position.coords.latitude;
	       lng = position.coords.longitude;
	       
	       setCenter(lng, lat);
	     };
	   
	     function error() {
	         alert('사용자의 위치를 찾을 수 없습니다.');
	       }; 
	
	// map 생성
	// Tmap.map을 이용하여, 지도가 들어갈 div, 넓이, 높이를 설정합니다.
	map = new Tmap.Map({div:'map_div', // map을 표시해줄 div
						width:'100%',  // map의 width 설정
						height:'400px' // map의 height 설정
						}); 
	markerLayer = new Tmap.Layer.Markers();//마커 레이어 생성
	map.addLayer(markerLayer);//map에 마커 레이어 추가
	
	var size = new Tmap.Size(24, 38);//아이콘 크기
	var offset = new Tmap.Pixel(-(size.w / 2), -(size.h));	//아이콘 중심점

	
	 for (var i = 0; i< sList.length; i++){//for문을 통하여 배열 안에 있는 값을 마커 생성
		var icon = new Tmap.Icon('http://tmapapis.sktelecom.com/upload/tmap/marker/pin_b_m_a.png',size, offset);//아이콘 설정
		var slat = sList[i].slatitude;
		var slon = sList[i].slongitude;
		console.log(slat +'' +slon);
		var lonlat = new Tmap.LonLat(slon, slat).transform("EPSG:4326", "EPSG:3857");//좌표 지정
		
		marker = new Tmap.Marker(lonlat, icon);//마커 생성
		markerLayer.addMarker(marker); //마커 레이어에 마커 추가
	} 
	

}  


</script>
<title>Insert title here</title>
</head>
<body>
<div id="map_div"></div>
</body>
</html>