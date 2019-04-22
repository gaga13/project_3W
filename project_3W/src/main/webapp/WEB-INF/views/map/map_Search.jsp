<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>장소검색부분. 키워드로 장소 검색하고 목록으로 표출하기</title>
<script src="resources/js/jquery-3.3.1.js"></script>
<script
	src="https://api2.sktelecom.com/tmap/js?version=1&format=javascript&appKey=99ed5523-2eb1-46fb-8cf0-60d0377b2345"></script>
<script>
var map;
var name;
var lat, lng;
var lat1, lon1;
var tData;
var markerLayer;
var arrname = [];
var arrlat = [];
var arrlng = [];

$(document).ready(function (){
	initTmap();
});
// 페이지가 로딩이 된 후 호출하는 함수입니다.
function initTmap(){
	
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
	map = new Tmap.Map({div:'map_div', width:'100%', height:'350px'});
	
	function setCenter(lng,lat){	
		map.setCenter(new Tmap.LonLat(lng, lat).transform("EPSG:4326", "EPSG:3857"), 15);
	}
	
	tData = new Tmap.TData();//REST API 에서 제공되는 경로, 교통정보, POI 데이터를 쉽게 처리할 수 있는 클래스입니다.

}

function search(search){

	var keyword = search;

	$.ajax({
		method:"GET",
		url:"https://api2.sktelecom.com/tmap/pois?version=1&format=xml&callback=result",// POI 통합검색 api 요청 url입니다.
		async:false,
		data:{
			"searchKeyword" : keyword,//검색 키워드
			"resCoordType" : "EPSG3857",//응답 좌표계 유형
			//검색타입
			//all:통합 검색
			//name:명칭 검색
			//telno:전화번호 검색
			"searchType" : "all",
			//거리순,정확도순 검색
			//A:정확도순
			//R:거리순
			"searchtypCd" : "A",
			"radius" : 0,//검색반경
			"reqCoordType" : "WGS84GEO",//요청 좌표계 유형
			"centerLon" : lng,
			"centerLat" : lat,
			"multiPoint" : "N",
			"appKey" : "99ed5523-2eb1-46fb-8cf0-60d0377b2345",// 실행을 위한 키입니다. 발급받으신 AppKey(서버키)를 입력하세요.
			"count" : 10//페이지당 출력되는 개수를 지정
		},
		//데이터 로드가 성공적으로 완료되었을 때 발생하는 함수입니다.
		success:function(response){
			prtcl = response;
			
			// 2. 기존 마커, 팝업 제거
			if(markerLayer != null) {
				markerLayer.clearMarkers();
				map.removeAllPopup();
			}
			
			// 3. POI 마커 표시
			markerLayer = new Tmap.Layer.Markers();//마커 레이어 생성
			map.addLayer(markerLayer);//map에 마커 레이어 추가
			var size = new Tmap.Size(24, 38);//아이콘 크기 설정
			var offset = new Tmap.Pixel(-(size.w / 2), -(size.h));//아이콘 중심점 설정
			var maker;
			var popup;
			var prtclString = new XMLSerializer().serializeToString(prtcl);//xml to String	
			xmlDoc = $.parseXML( prtclString ),
			$xml = $( xmlDoc ),
			$intRate = $xml.find("poi");
			var innerHtml ="";
			$intRate.each(function(index, element) {
			   	name = element.getElementsByTagName("name")[0].childNodes[0].nodeValue;
			   	var id = element.getElementsByTagName("id")[0].childNodes[0].nodeValue;
				lon1 = element.getElementsByTagName("noorLon")[0].childNodes[0].nodeValue;
				lat1 = element.getElementsByTagName("noorLat")[0].childNodes[0].nodeValue;
				
				//이름 클릭할 때 쓰는 배열
				arrname[index] = name;
				arrlng[index] = lon1;
				arrlat[index] = lat1;
				
			   	var content ="<div style=' position: relative; border-bottom: 1px solid #dcdcdc; line-height: 18px; padding: 0 35px 2px 0;'>"+
							    "<div style='font-size: 12px; line-height: 15px;'>"+
							        "<span style='display: inline-block; width: 14px; height: 14px; background-image: url(/resources/images/common/icon_blet.png); vertical-align: middle; margin-right: 5px;'></span>"+name+
							    "</div>"+
							 "</div>";
			   	innerHtml+="<div><img src='http://tmapapis.sktelecom.com/upload/tmap/marker/pin_b_m_"+index+".png' style='vertical-align:middle'/><span onclick="+"javascript:slocationMap.nameClick("+ index +")"+">"+name+"</span></div>";
				
				var icon = new Tmap.Icon('http://tmapapis.sktelecom.com/upload/tmap/marker/pin_b_m_'+index+'.png',size, offset);//마커 아이콘 설정
				var lonlat = new Tmap.LonLat(lon1, lat1);//좌표설정 
				marker = new Tmap.Marker(lonlat, icon);//마커생성
				markerLayer.addMarker(marker);//마커레이어에 마커 추가
								
				popup = new Tmap.Popup("p1", lonlat, new Tmap.Size(120, 50), content, false);//마우스 오버 팝업
				popup.autoSize = true;//Contents 내용에 맞게 Popup창의 크기를 재조정할지 여부를 결정
				map.addPopup(popup);//map에 popup추가
				popup.hide();//마커에 마우스가 오버되기 전까진 popup을 숨김
				//마커 이벤트등록
			    marker.events.register("mouseover", popup, onOverMarker);
			    //마커에 마우스가 오버되었을 때 발생하는 이벤트 함수입니다.
			    function onOverMarker(evt) {
			      this.show(); //마커에 마우스가 오버되었을 때 팝업이 보입니다. 
			    }
			    //마커 이벤트 등록
			    marker.events.register("mouseout", popup, onOutMarker);
			    //마커에 마우스가 아웃되었을 때 발생하는 함수입니다.
			    function onOutMarker(evt) {
			      this.hide(); //마커에 마우스가 없을땐 팝업이 숨겨집니다.
			    }
			  
		   });
			//$("#searchResult").html(innerHtml);
			$('#result_loc',parent.document).html("<위치 검색 결과>" + "\n" + innerHtml);
			map.zoomToExtent(markerLayer.getDataExtent());//마커레이어의 영역에 맞게 map을 zoom합니다.
		},
		//요청 실패시 콘솔창에서 에러 내용을 확인할 수 있습니다.
		error:function(request,status,error){
			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
}

function nameClick(index){
	var lonlat = new Tmap.LonLat(arrlng[index], arrlat[index]).transform("EPSG:3857", "EPSG:4326");
	var keyword = document.getElementById('keyword');	
	var lon = lonlat.lon;
	var lat = lonlat.lat;
	var name = arrname[index];
	var slon = arrlng[index];
	var slat = arrlat[index];
	var slonlat; 
	map.setCenter(new Tmap.LonLat(lon, lat).transform("EPSG:4326", "EPSG:3857"), 15);
	
	slonlat = new Tmap.LonLat(slon, slat).transform("EPSG:3857", "EPSG:4326");
	slon = slonlat.lon;
	slat = slonlat.lat;
	
	$('#keyword').val(name);
	$('#inslocation', parent.document).val(name);
	$('#slat', parent.document).val(slat);
	$('#slon', parent.document).val(slon);
}
</script>
</head>
<body>
	<!-- 맵 -->
	<div id="map_div"></div>
	
</body>
</html>