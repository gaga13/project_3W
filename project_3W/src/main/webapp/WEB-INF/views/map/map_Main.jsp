<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>스케쥴과 맵 연동하여 마커 찍기</title>
<script src="resources/js/jquery-3.3.1.js"></script>
<script
   src="https://api2.sktelecom.com/tmap/js?version=1&format=javascript&appKey=99ed5523-2eb1-46fb-8cf0-60d0377b2345"></script>
<script>
// 페이지가 로딩이 된 후 호출하는 함수입니다.
var selectMarker
$(document).ready(function(){
	getScheduleList();

});


function getScheduleList(){
	$.ajax({
		url:'getScheduleList',
		type: 'post',
		dataType:'json',
		success : function(sList){         
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
    
    function setCenter(lng,lat){   
       map.setCenter(new Tmap.LonLat(lng, lat).transform("EPSG:4326", "EPSG:3857"), 15);
    }
    
    tData = new Tmap.TData();
   
    markerLayer = new Tmap.Layer.Markers();//마커 레이어 생성
   	map.addLayer(markerLayer);//map에 마커 레이어 추가
   	
   	var size = new Tmap.Size(32, 38);//아이콘 크기
   	var offset = new Tmap.Pixel(-(size.w / 2), -(size.h));	//아이콘 중심점
	   
	for (var i = 0; i< sList.length; i++){//for문을 통하여 배열 안에 있는 값을 마커 생성
		if(i == 0){
			var img = 'resources/img/number/one.png';
		}
		if(i == 1){
			var img = 'resources/img/number/two.png';
		}
		if(i == 2){
			var img = 'resources/img/number/three.png';
		}
		if(i == 3){
			var img = 'resources/img/number/four.png';
		}
		if(i == 4){
			var img = 'resources/img/number/five.png';
		}
		if(i == 5){
			var img = 'resources/img/number/six.png';
		}
		if(i == 6){
			var img = 'resources/img/number/seven.png';
		}
		if(i == 7){
			var img = 'resources/img/number/eight.png';
		}
		if(i == 8){
			var img = 'resources/img/number/nine.png';
		}
		if(i == 9){
			var img = 'resources/img/number/ten.png';
		}
		
		
		var icon = new Tmap.Icon(img,size, offset);//아이콘 설정
		var slat = sList[i].slatitude;
		var slon = sList[i].slongitude;
		var slocation = sList[i].slocation;
		console.log(slat +'' +slon+''+slocation);
		var lonlat = new Tmap.LonLat(slon, slat).transform("EPSG:4326", "EPSG:3857");//좌표 지정
		
		marker = new Tmap.Marker(lonlat, icon);//마커 생성
		markerLayer.addMarker(marker); //마커 레이어에 마커 추가
		
		marker.events.register("click", marker, onClickMarker);	//마커 마우스 클릭 이벤트 등록
	} 
   	
   	
	//선 그리기
	var pointList = []; //포인트를 저장할 배열
	for( var i=0; i< sList.length; i++){
		var slat = sList[i].slatitude;
		var slon = sList[i].slongitude;
		pointList.push(new Tmap.Geometry.Point(slon, slat).transform("EPSG:4326", "EPSG:3857"));
	}
	
	//선 스타일
	var style = {
			fillColor:"#56b48c",
			fillOpacity:0.2,
			strokeColor: "#56b48c",
			strokeWidth: 3,	// 선 굵기 지정
			strokeDashstyle: "solid",
			pointRadius: 60
		};
	
	var lineString = new Tmap.Geometry.LineString(pointList); // 라인 스트링 생성 
	var mLineFeature = new Tmap.Feature.Vector(lineString, null, style); // 백터 생성
	 
	var vectorLayer = new Tmap.Layer.Vector("vectorLayerID"); // 백터 레이어 생성
	map.addLayer(vectorLayer); // 지도에 백터 레이어 추가
	 
	vectorLayer.addFeatures([mLineFeature]); // 백터를 백터 레이어에 추가 
   	
	function onClickMarker(){
		alert('a');x
		/* if( selectMarker ) {
			// 기존 빨간 마커 지우기
			markerLayer.removeMarker(selectMarker);
			// 기존 빨간 마커 파란 마커로 다시 그리기
			size = new Tmap.Size(24, 38); // 마커 아이콘 사이즈 지정
			icon = new Tmap.Icon('http://tmapapis.sktelecom.com/upload/tmap/marker/pin_b_m_a.png',size, offset); // 마커 아이콘 생성
			marker = new Tmap.Marker(selectMarker.lonlat, icon); // 마커 생성
			markerLayer.addMarker(marker); // 마커레이어에 마커 추가
			
		}
		
		// 빨간 마커 그리기
		markerLayer.removeMarker(this.marker); // 마커 삭제
		size = new Tmap.Size(24, 38); // 마커 아이콘 사이즈 지정
		icon = new Tmap.Icon('http://tmapapis.sktelecom.com/upload/tmap/marker/pin_r_m_a.png',size, offset); // 마커 아이콘 생성
		marker = new Tmap.Marker(this.marker.lonlat, icon); // 마커 생성
		selectMarker=marker; // 선택된 마커 저장
		selectPopup=this.popup; // 선택된 팝업 저장 
		markerLayer.addMarker(marker); // 마커레이어에 마커 추가
		 */
		
		
	}
   

}
//마커를 클릭했을 때 발생하는 이벤트 함수입니다.

</script>

</head>
<body>
   <div id="map_div"></div>
   <div id="practice"></div>  
</body>
