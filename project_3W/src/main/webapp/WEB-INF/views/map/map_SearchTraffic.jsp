<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>출발지 도착지 검색해서 대중교통 길찾기</title>
<script src="resources/js/jquery-3.3.1.js"></script>
<script
	src="https://api2.sktelecom.com/tmap/js?version=1&format=javascript&appKey=99ed5523-2eb1-46fb-8cf0-60d0377b2345"></script>
<script>
var map;
var name;
var lng, lat;
var startLat, startLng;
var endLat, endLng;
var lat1, lon1;
var tData;
var markerLayer;
var arrname = [];
var arrlat = [];
var arrlng = [];
var checkNum;
var tDistance;
var marker = null;
var routeLayer;
var vectorLayer;

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
	map = new Tmap.Map({div:'map_div', width:'100%', height:'400px'});
	
	function setCenter(lng,lat){	
		map.setCenter(new Tmap.LonLat(lng, lat).transform("EPSG:4326", "EPSG:3857"), 15);
	}
	
	tData = new Tmap.TData();//REST API 에서 제공되는 경로, 교통정보, POI 데이터를 쉽게 처리할 수 있는 클래스입니다.

}

function search(num){

	if(vectorLayer != null || routeLayer != null){
		map.destroy();
		initTmap();
	}
	
	if(marker!=null){
		markerLayer.clearMarkers();
	}
	
	var startKeyword = $('#startKeyword').val();
	var endKeyword = $('#endKeyword').val();
	var searchKeyword;
	//출발지 입력인지 도착지 입력인지 확인하는 숫자.
	checkNum = num;
	
	switch(checkNum){
	case 1:
		searchKeyword = startKeyword;
		break;
	case 2:
		searchKeyword = endKeyword;
	}
	
	$.ajax({
		method:"GET",
		url:"https://api2.sktelecom.com/tmap/pois?version=1&format=xml&callback=result",// POI 통합검색 api 요청 url입니다.
		async:false,
		data:{
			"searchKeyword" : searchKeyword,//검색 키워드
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
			   	innerHtml+="<div><img src='http://tmapapis.sktelecom.com/upload/tmap/marker/pin_b_m_"+index+".png' style='vertical-align:middle'/><span onclick="+"javascript:nameClick("+ index +")"+">"+name+"</span></div>";
				
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
		$("#searchResult").html(innerHtml);
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
	var name;
	
	switch(checkNum){
	case 1:
		startLng = lonlat.lon;
		startLat = lonlat.lat;
		name = arrname[index];
	
		map.setCenter(new Tmap.LonLat(startLng, startLat).transform("EPSG:4326", "EPSG:3857"), 15);
		
		$('#startKeyword').val(name);
		break;
	case 2:
		endLng = lonlat.lon;
		endLat = lonlat.lat;
		name = arrname[index];
	
		map.setCenter(new Tmap.LonLat(endLng, endLat).transform("EPSG:4326", "EPSG:3857"), 15);
		
		$('#endKeyword').val(name);
		break;
	}
}

function searchRoute(){
	
	markerLayer.clearMarkers();
	
	$('#searchResult').val('');
	
	if(startLng == null || startLat == null || endLng == null || endLat == null){
		alert('출발지와 도착지를 입력하세요');
		return;
	}
	
	else{
		var lonlat1 = new Tmap.LonLat(startLng, startLat).transform("EPSG:3857", "EPSG:4326");
		var size = new Tmap.Size(24, 38);//아이콘 사이즈 설정
		var offset = new Tmap.Pixel(-(size.w/2), -(size.h));//아이콘 중심점 설정
		var icon = new Tmap.Icon('http://tmapapis.sktelecom.com/upload/tmap/marker/pin_b_m_a.png',size, offset);//마커 아이콘 설정
		var marker1 = new Tmap.Marker(lonlat1.transform("EPSG:4326", "EPSG:3857"), icon);//마커 생성

		var lonlat2 = new Tmap.LonLat(endLng, endLat).transform("EPSG:3857", "EPSG:4326");
		var size = new Tmap.Size(24, 38);//아이콘 사이즈 설정
		var offset = new Tmap.Pixel(-(size.w/2), -(size.h));//아이콘 중심점 설정
		var icon = new Tmap.Icon('http://tmapapis.sktelecom.com/upload/tmap/marker/pin_b_m_a.png',size, offset);//마커 아이콘 설정
		var marker2 = new Tmap.Marker(lonlat2.transform("EPSG:4326", "EPSG:3857"), icon);//마커 생성
		
		//REST API 에서 제공되는 경로, 교통정보, POI 데이터를 쉽게 처리할 수 있는 클래스입니다.
		s_lonLat = new Tmap.LonLat(lonlat1.lon, lonlat1.lat); //시작 좌표입니다.   
		e_lonLat = new Tmap.LonLat(lonlat2.lon, lonlat2.lat); //도착 좌표입니다.
		
		optionObj = {
				reqCoordType:"WGS84GEO", //요청 좌표계 옵셥 설정입니다.
				resCoordType:"EPSG3857"  //응답 좌표계 옵셥 설정입니다.
		}
		
		tData.getRoutePlan(s_lonLat, e_lonLat, optionObj);//경로 탐색 데이터를 콜백 함수를 통해 XML로 리턴합니다.
		
		tData.events.register("onComplete", tData, onComplete);//데이터 로드가 성공적으로 완료되었을 때 발생하는 이벤트를 등록합니다.
		tData.events.register("onProgress", tData, onProgress);//데이터 로드중에 발생하는 이벤트를 등록합니다.
		tData.events.register("onError", tData, onError);//데이터 로드가 실패했을 떄 발생하는 이벤트를 등록합니다.
		
		total(lonlat1.lon, lonlat1.lat, lonlat2.lon, lonlat2.lat);
	}
	
	//데이터 로드가 성공적으로 완료되었을 때 발생하는 이벤트 함수 입니다. 
	function onComplete(){
		console.log(this.responseXML); //xml로 데이터를 받은 정보들을 콘솔창에서 확인할 수 있습니다.
			      
		var kmlForm = new Tmap.Format.KML({extractStyles:true}).read(this.responseXML);
		var vectorLayer = new Tmap.Layer.Vector("vectorLayerID");
		vectorLayer.addFeatures(kmlForm);
		map.addLayer(vectorLayer);
		//경로 그리기 후 해당영역으로 줌  
		map.zoomToExtent(vectorLayer.getDataExtent());	
	}

	//데이터 로드중 발생하는 이벤트 함수입니다.
	function onProgress(){
		//alert("onComplete");
	}

	//데이터 로드시 에러가 발생시 발생하는 이벤트 함수입니다.
	function onError(){
		alert("onError");
	}
	
	//길 따라간 거리
	function total(lon1, lat1, lon2, lat2){
		//경로 탐색 출발지점과 도착 지점의 좌표
		//구글 지도에서 나오는 좌표의 x, y를 바꾸면 된다.
		var startX = lon1;
		var startY = lat1;
		var endX = lon2;
		var endY = lat2;
		var passList = null;
		var prtcl;
		var headers = {};

		headers["appKey"]="99ed5523-2eb1-46fb-8cf0-60d0377b2345"; // 발급받은 인증키를 넣어야 한다
		$.ajax({
		 method:"POST",
		 headers : headers,
		 url:"https://api2.sktelecom.com/tmap/routes?version=1&format=xml",
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
		
		 success:function(response){ //API가 제대로 작동할 경우 실행될 코드
		     prtcl = response;
		
		     // 결과 출력 부분
		     var innerHtml ="";
		     var prtclString = new XMLSerializer().serializeToString(prtcl);//xml to String
		     xmlDoc = $.parseXML( prtclString ),
		     $xml = $( xmlDoc ),
		     $intRate = $xml.find("Document");
		
		     tDistance = " 총 거리 : "+($intRate[0].getElementsByTagName("tmap:totalDistance")[0].childNodes[0].nodeValue/1000).toFixed(1)+"km,";
		     var tTime = " 총 시간 : "+($intRate[0].getElementsByTagName("tmap:totalTime")[0].childNodes[0].nodeValue/60).toFixed(0)+"분,";
		     var tFare = " 총 요금 : "+$intRate[0].getElementsByTagName("tmap:totalFare")[0].childNodes[0].nodeValue+"원입니다";
		     
		     $("#result2").text(tDistance+tTime+tFare);
			
		     tDistance = ($intRate[0].getElementsByTagName("tmap:totalDistance")[0].childNodes[0].nodeValue/1000).toFixed(1);
		     
		 	 // 출발 - 도착지점 거리 700m 이하시 다시 찍도록 하기
		     if(tDistance <= 2){
		    	alert('출발지와 도착지가 너무 가까워요! 다시 입력해주세요!');
		    	history.go(0);	//끝까지 다 실행되고 새로고침되네.. 어떻게 해야할까나
		    	return;
		     }
		     
		     // 실시간 교통정보 추가
		     var trafficColors = {
		         extractStyles:true,
		         // 교통 상황에 따라 색깔 바꿔주면 좋을듯.
		         trafficDefaultColor:"#000000", //Default
		         trafficType1Color:"#009900", //원활
		         trafficType2Color:"#8E8111", //지체
		         trafficType3Color:"#FF0000", //정체
		     };    
		     
		     var kmlForm = new Tmap.Format.KML(trafficColors).readTraffic(prtcl);
		     routeLayer = new Tmap.Layer.Vector("vectorLayerID"); //백터 레이어 생성
		     routeLayer.addFeatures(kmlForm); //교통정보를 백터 레이어에 추가   
		
		     map.addLayer(routeLayer); // 지도에 백터 레이어 추가
		
		     // 경로탐색 결과 반경만큼 지도 레벨 조정
		     map.zoomToExtent(routeLayer.getDataExtent());
		 },
		 error:function(request,status,error){ // API가 제대로 작동하지 않을 경우
		 console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		 }
		});
		
		if(tDistance > 0.7){
			//길찾기 API 호출
	    	searchPubTransPathAJAX(lon1, lat1, lon2, lat2);
		}
	}
	
	//ODsay api 호출
	function searchPubTransPathAJAX(lon1, lat1, lon2, lat2) {
		var xhr = new XMLHttpRequest();
		var url = "https://api.odsay.com/v1/api/searchPubTransPath?SX="+lon1+"&SY="+lat1+"&EX="+lon2+"&EY="+lat2+"&apiKey=gDSRLToiMkQzCkBbo6vic9U4gHOXXEJVmikqh6HOVn4";
		xhr.open("GET", url, true);
		xhr.send();
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {		
				//노선그래픽 데이터 호출. 출발지 - 도착지 거리가 700 m 이하일 경우 {"error": {"code": "-98","msg": "radius error"}} 에러 발생.
				$.ajax({
					//url : 어디로 갈지. controller의 경로와 맞아야함. 상대경로로 중간에 ../ 등의 경로가 추가될 수도 있음.
					url: 'traffic',
					//type : 요청을 get방식으로 보낼 것인가, post방식으로 보낼 것인가.
					type: 'post',
					data: {str : xhr.responseText},
					//dataType : 데이터를 가져올 때 어떤 타입으로 가져올지. 보통 text 아니면 json이 들어간다.
					dataType: 'text',
					//요청 성공시 어떻게 할 것인지. 방법 1: 다른 함수로 보내기. 뒤에 ()붙이면 안됨. ()붙이는 것은 그 함수를 지금 이 자리에서 실행한다는 뜻이므로.
					success: function(){
						alert('성공');
					},
					//요청 실패시 어떻게 할 것인가. 방법 2: 안에 함수 넣어버리기(추가할 내용이 짧을 때 유용).
					error: function (e, request, status, error) {
						//에러 발생시 에러 내용을 문자열로 출력하는 명령어.
						alert(JSON.stringify(e));
						alert("status : " + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
					}
				});				
				//callMapObjApiAJAX((JSON.parse(xhr.responseText))["result"]["path"][0].info.mapObj, lon1, lat1, lon2, lat2);
			}
		}
	}

/* 	//폴리라인 부분
 	function callMapObjApiAJAX(mabObj){
		var xhr = new XMLHttpRequest();
		//ODsay apiKey 입력
		var url = "https://api.odsay.com/v1/api/loadLane?mapObject=0:0@"+mabObj+"&apiKey=gDSRLToiMkQzCkBbo6vic9U4gHOXXEJVmikqh6HOVn4";
		xhr.open("GET", url, true);
		xhr.send();
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				//var resultJsonData = JSON.parse(xhr.responseText);
				var kmlForm = new Tmap.Format.KML({extractStyles:true}).read(xhr.responseText);
				var vectorLayer = new Tmap.Layer.Vector("vectorLayerID");
				vectorLayer.addFeatures(kmlForm);
				map.addLayer(vectorLayer);
				//경로 그리기 후 해당영역으로 줌  
				map.zoomToExtent(vectorLayer.getDataExtent());
			}
		}
	} */
}

</script>
</head>

<body onload="initTmap()">
	<!-- 맵 -->
	<div id="map_div"></div>

	<input id="startKeyword" type="text" placeholder="출발지를 입력하세요" onchange="javascript:search(1)"/>
	<input id="endKeyword" type="text" placeholder="도착지를 입력하세요" onchange="javascript:search(2)" />
	<input type="button" value="검색" onclick="javascript:searchRoute()" />
	<p id="result2"></p>
	<div style="height:400px; overflow-y:scroll; " id="searchResult" name="searchResult">검색결과</div>
	
</body>
</html>