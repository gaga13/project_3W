<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="resources/js/jquery-3.3.1.js"></script>
<script
   src="https://api2.sktelecom.com/tmap/js?version=1&format=javascript&appKey=99ed5523-2eb1-46fb-8cf0-60d0377b2345"></script>
<script>
var map, marker, popup, markerLayer;
var lonlat, size, offset, icon, index, img;
var selectMarker, selectPopup;
var arrMarkerPopup = [];

//마커와 팝업을 세팅합니다.
function MarkerPopup(marker, popup) {
	this.marker = marker;
	this.popup = popup;
}
//페이지가 로딩이 된 후 호출하는 함수입니다.
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
   	
   	var size = new Tmap.Size(28, 34);//아이콘 크기
   	var offset = new Tmap.Pixel(-(size.w / 2), -(size.h));				//아이콘 중심점
	   
	for (var i = 0; i< sList.length; i++){			//for문을 통하여 배열 안에 있는 값을 마커 생성
		
		
		var icon = new Tmap.Icon('resources/img/marker/maps-and-flags (2).png',size, offset);//아이콘 설정
		var slat = sList[i].slatitude;
		var slon = sList[i].slongitude;
		
		console.log(slat +',' +slon);
		
		var lonlat = new Tmap.LonLat(slon, slat).transform("EPSG:4326", "EPSG:3857");//좌표 지정
		
		//팝업을 위한 배열(위치값 , 팝업에 띄울 값)
		var positions = new Array();
		positions[i] = lonlat;
		var locations = new Array(); 	//db에서 받아온 '위도,경도' 배열 
		locations[i] = slat + ',' + slon + '!' + i;
		
		marker = new Tmap.Marker(lonlat, icon);//마커 생성
		markerLayer.addMarker(marker); //마커 레이어에 마커 추가
		//팝업 생성
		popup = new Tmap.Popup("p1", positions[i], new Tmap.Size(120, 30), locations[i]);
		map.addPopup(popup); // 지도에 팝업 추가
		popup.hide(); // 팝업 숨기기
		
		//마커 이벤트등록
		marker.events.register("click", new MarkerPopup(marker, popup), onClickMarker); // 마커를 클릭했을 때 이벤트 설정
		
	} 
   	
	// 마커가 클릭되었을 때 발생하는 이벤트 함수입니다.
	function onClickMarker(evt) {	
		
		this.popup.hide(); // 클릭했을때 팝업이 숨겨집니다.
		var img, red_img;
		var all = this.popup.contentHTML.split('!');
		var index = all[1]; 	//현재 마커 번호 - 1
		
		var seslonlat = all[0];		//현재 마커 위치(위도경도)
		if( selectMarker ) {
			// 기존 빨간 마커 지우기
			markerLayer.removeMarker(selectMarker);
			// 기존 빨간 마커 파란 마커로 다시 그리기
			
			size = new Tmap.Size(28, 34); // 마커 아이콘 사이즈 지정
			
			icon = new Tmap.Icon('resources/img/marker/maps-and-flags (2).png',size, offset); // 마커 아이콘 생성
			marker = new Tmap.Marker(selectMarker.lonlat, icon); // 마커 생성
			markerLayer.addMarker(marker); // 마커레이어에 마커 추가
			marker.events.register("click", new MarkerPopup(marker, this.popup), onClickMarker); // 마커를 클릭했을 때 이벤트 설정
		}
		
		// 빨간 마커 그리기
		markerLayer.removeMarker(this.marker); // 마커 삭제
		size = new Tmap.Size(28, 34); // 마커 아이콘 사이즈 지정
		
		icon = new Tmap.Icon('resources/img/marker/marker_red.png' ,size, offset); // 마커 아이콘 생성
		
		marker = new Tmap.Marker(this.marker.lonlat, icon); // 마커 생성
		selectMarker=marker; // 선택된 마커 저장
		
		markerLayer.addMarker(marker); // 마커레이어에 마커 추가
		marker.events.register("click", new MarkerPopup(marker, this.popup), onClickMarker); // 마커를 클릭했을 때 이벤트 설정
		//session에 값 저장
		reverseGeoCording(seslonlat);
		
	}
		
}

function reverseGeoCording(seslonlat){
		
		var seslonlatList = seslonlat.split(',');
		var lat = seslonlatList[0];
		var lon = seslonlatList[1];
	
	   var latlng = "https://maps.googleapis.com/maps/api/geocode/xml?latlng=" + lat + "," + lon + "&language=ko&sensor=false&key=AIzaSyDBLJ3URwB6HcAHqAJiwwOOqgqwUe2Hu0M"
	         
	   $.ajax({
	      url: latlng,
	      type: "POST",
	      success: XMLParsing,
	      error: function(e){
	         alert(json.stringify(e));
	      }
	   });
	}

	function XMLParsing(xml){
	   var xmlDoc = xml.getElementsByTagName("formatted_address");   
	   loca = xmlDoc[5].childNodes[0].nodeValue;
	   $.ajax({
	      url: 'reverseGeoCording',
	      type: 'post',
	      data: {loca : loca},
	      dataType: 'text',
	      success: function(){
	      },
	      error: function (e) {
	         alert(JSON.stringify(e));
	         alert("현재위치에 따른 주소명 session 저장 실패");
	      }
	   }); 
} 


</script>
<title>Insert title here</title>
</head>
<body>
<div id="map_div"></div>
</body>
</html>