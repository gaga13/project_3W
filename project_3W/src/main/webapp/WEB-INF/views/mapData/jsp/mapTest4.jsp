<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>자동차 경로 탐색 test</title>

<script src="resources/js/jquery-3.3.1.min.js"></script>
<script src="https://api2.sktelecom.com/tmap/js?version=1&format=javascript&appKey=99ed5523-2eb1-46fb-8cf0-60d0377b2345"></script>
<script>	
var map;

//1. 지도 띄우기
function initTmap(){
map = new Tmap.Map({
	div : 'map_div',
	width : "100%",
	height : "400px",
});
map.setCenter(new Tmap.LonLat("127.058908811749", "37.52084364186228").transform("EPSG:4326", "EPSG:3857"), 12);
routeLayer = new Tmap.Layer.Vector("route");
map.addLayer(routeLayer);

markerStartLayer = new Tmap.Layer.Markers("start");
markerEndLayer = new Tmap.Layer.Markers("end");
markerWaypointLayer = new Tmap.Layer.Markers("waypoint");
markerWaypointLayer2 = new Tmap.Layer.Markers("waypoint2");
pointLayer = new Tmap.Layer.Vector("point");

//2. 시작, 도착 심볼찍기
//시작
map.addLayer(markerStartLayer);

var size = new Tmap.Size(24, 38);
var offset = new Tmap.Pixel(-(size.w / 2), -size.h);
var icon = new Tmap.IconHtml("<img src='http://tmapapis.sktelecom.com/upload/tmap/marker/pin_r_m_s.png' />", size, offset);
var marker_s = new Tmap.Marker(new Tmap.LonLat("127.02810900563199", "37.519892712436906").transform("EPSG:4326", "EPSG:3857"), icon);
markerStartLayer.addMarker(marker_s);

//도착
map.addLayer(markerEndLayer);

var size = new Tmap.Size(24, 38);
var offset = new Tmap.Pixel(-(size.w / 2), -size.h);
var icon = new Tmap.IconHtml("<img src='http://tmapapis.sktelecom.com/upload/tmap/marker/pin_r_m_e.png' />", size, offset);
var marker_e = new Tmap.Marker(new Tmap.LonLat("127.13281976335786", "37.52130314703887").transform("EPSG:4326", "EPSG:3857"), icon);
markerEndLayer.addMarker(marker_e);

//경유지 마커 제거
markerWaypointLayer.clearMarkers();
markerWaypointLayer2.clearMarkers();


//3. 경유지 심볼 찍기
map.addLayer(markerWaypointLayer);

var size = new Tmap.Size(24, 38);
var offset = new Tmap.Pixel(-(size.w / 2), -size.h); 
var icon = new Tmap.IconHtml("<img src='http://tmapapis.sktelecom.com/upload/tmap/marker/pin_b_m_p.png' />", size, offset);
var marker = new Tmap.Marker(new Tmap.LonLat("127.04724656694417","37.524162226778515").transform("EPSG:4326", "EPSG:3857"), icon);
markerWaypointLayer.addMarker(marker);

var size = new Tmap.Size(24, 38);
var offset = new Tmap.Pixel(-(size.w / 2), -size.h);
var icon = new Tmap.IconHtml("<img src='http://tmapapis.sktelecom.com/upload/tmap/marker/pin_b_m_p.png' />", size, offset);
var marker = new Tmap.Marker(new Tmap.LonLat("127.10887300128256","37.5289781669373").transform("EPSG:4326", "EPSG:3857"), icon);
markerWaypointLayer.addMarker(marker);

markerWaypointLayer2.clearMarkers();
}

//4. 경로 탐색 API 사용요청
var startX = 127.02810900563199;
var startY = 37.519892712436906;
var endX = 127.13281976335786;
var endY = 37.52130314703887;
var passList = "127.04724656694417,37.524162226778515_127.10887300128256,37.5289781669373";
var prtcl;
var headers = {}; 
headers["appKey"]="99ed5523-2eb1-46fb-8cf0-60d0377b2345";
$.ajax({
		method:"POST",
		headers : headers,
		url:"https://api2.sktelecom.com/tmap/routes?version=1&format=xml",//
		async:false,
		data:{
			startX : startX,
			startY : startY,
			endX : endX,
			endY : endY,
			passList : passList,
			reqCoordType : "WGS84GEO",
			resCoordType : "EPSG3857",
			angle : "172",
			searchOption : "0",
			trafficInfo : "Y" //교통정보 표출 옵션입니다.
		},
		success:function(response){
		
			var kmlForm = new Tmap.Format.KML({extractStyles:true}).read(this.responseXML);
			var vectorLayer = new Tmap.Layer.Vector("vectorLayerID");
			vectorLayer.addFeatures(kmlForm);
			map.addLayer(vectorLayer);
			//경로 그리기 후 해당영역으로 줌  
			map.zoomToExtent(vectorLayer.getDataExtent());
		
	},
	error:function(request,status,error){
		console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	}
});
</script>
</head>
<body onload="initTmap()">
	<!-- 맵 -->
	<div id="map_div">
  	</div>
  	
</body>
</html>