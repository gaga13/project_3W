<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="resources/js/jquery-3.3.1.js"></script>
<style>
 body{
overflow:hidden;
}
</style> 
<script
	src="https://api2.sktelecom.com/tmap/js?version=1&format=javascript&appKey=99ed5523-2eb1-46fb-8cf0-60d0377b2345"></script>
<script>
var map;
var offset1, offset2;
var map, marker1, marker2, markerLayer, s_lonLat, e_lonLat, optionObj, lonlat1, lonlat2;
var cnt = 1;
var lat, lng;
var tData; 
var tDistance;
var start_name;
var end_name;
var count = 0;
var taxi = "";
// 페이지가 로딩이 된 후 호출하는 함수입니다.
$(document).ready(function (){
	initTmap();
});

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
	
		markerLayer = new Tmap.Layer.Markers();//맵 레이어 생성
    	map.addLayer(markerLayer);//map에 맵 레이어를 추가합니다.
    	
   	map.events.register("click", map, onClick);//map 클릭 이벤트를 등록합니다.
   	
	tData = new Tmap.TData();//REST API 에서 제공되는 경로, 교통정보, POI 데이터를 쉽게 처리할 수 있는 클래스입니다.

}


function onClick(e){
	//markerLayer.removeMarker(marker); // 기존 마커 삭제
	switch(cnt){
		case 1 :
			lonlat = map.getLonLatFromViewPortPx(e.xy).transform("EPSG:3857", "EPSG:4326");//클릭 부분의 ViewPortPx를 LonLat 좌표로 변환합니다.
			
			lonlat1 = map.getLonLatFromViewPortPx(e.xy).transform("EPSG:3857", "EPSG:4326");
			
			var size = new Tmap.Size(24, 38);//아이콘 사이즈 설정
			offset1 = new Tmap.Pixel(-(size.w/2), -(size.h));//아이콘 중심점 설정
			var icon = new Tmap.Icon('http://tmapapis.sktelecom.com/upload/tmap/marker/pin_b_m_a.png',size, offset1);//마커 아이콘 설정
			marker1 = new Tmap.Marker(lonlat.transform("EPSG:4326", "EPSG:3857"), icon);//마커 생성
			markerLayer.addMarker(marker1);//마커 레이어에 마커 추가
			cnt++;
			break;
		
		case 2 :
			lonlat = map.getLonLatFromViewPortPx(e.xy).transform("EPSG:3857", "EPSG:4326");//클릭 부분의 ViewPortPx를 LonLat 좌표로 변환합니다.
			lonlat2 = map.getLonLatFromViewPortPx(e.xy).transform("EPSG:3857", "EPSG:4326");
		
			var size = new Tmap.Size(24, 38);//아이콘 사이즈 설정
			offset2 = new Tmap.Pixel(-(size.w/2), -(size.h));//아이콘 중심점 설정
			var icon = new Tmap.Icon('http://tmapapis.sktelecom.com/upload/tmap/marker/pin_b_m_b.png',size, offset2);//마커 아이콘 설정
			marker2 = new Tmap.Marker(lonlat.transform("EPSG:4326", "EPSG:3857"), icon);//마커 생성
			markerLayer.addMarker(marker2);//마커 레이어에 마커 추가
			lola(lonlat1, lonlat2);
			cnt++;
			break;
	}	
}

function lola(lonlat1, lonlat2){
	
    //REST API 에서 제공되는 경로, 교통정보, POI 데이터를 쉽게 처리할 수 있는 클래스입니다.
	s_lonLat = new Tmap.LonLat(lonlat1.lon, lonlat1.lat); //시작 좌표입니다.   
	e_lonLat = new Tmap.LonLat(lonlat2.lon, lonlat2.lat); //도착 좌표입니다.
	
	optionObj = {
			reqCoordType:"WGS84GEO", //요청 좌표계 옵셥 설정입니다.
			resCoordType:"EPSG3857"  //응답 좌표계 옵셥 설정입니다.
	}
	
	tData.getRoutePlan(s_lonLat, e_lonLat, optionObj);//경로 탐색 데이터를 콜백 함수를 통해 XML로 리턴합니다.
	
	total(lonlat1.lon, lonlat1.lat, lonlat2.lon, lonlat2.lat);
	
	
	if(tDistance > 2){
		tData.events.register("onComplete", tData, onComplete);//데이터 로드가 성공적으로 완료되었을 때 발생하는 이벤트를 등록합니다.
		tData.events.register("onProgress", tData, onProgress);//데이터 로드중에 발생하는 이벤트를 등록합니다.
		tData.events.register("onError", tData, onError);//데이터 로드가 실패했을 떄 발생하는 이벤트를 등록합니다.
	}
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
		     tDistance = ($intRate[0].getElementsByTagName("tmap:totalDistance")[0].childNodes[0].nodeValue/1000).toFixed(1);
 		     
/*		     var taxi = '<b>택시</b><br><table border="1"><tr><td>거리</td><td>시간(분)</td><td>요금</td></tr>';
		     taxi+='<tr><td>'+tDistance+'</td>';
		     taxi+='<td text-align="center">'+($intRate[0].getElementsByTagName("tmap:totalTime")[0].childNodes[0].nodeValue/60).toFixed(0)+'</td>';
		     var tFare = " 총 요금 : "+$intRate[0].getElementsByTagName("tmap:totalFare")[0].childNodes[0].nodeValue+"원,";
		     taxi+='<td>'+$intRate[0].getElementsByTagName("tmap:taxiFare")[0].childNodes[0].nodeValue+'</td></tr>';
			taxi+='</table>'; */
			
			 taxi += '<b>택시</b><br>';
		     taxi+='<span>거리 : '+tDistance+"km, ";
		     taxi+='시간 : '+($intRate[0].getElementsByTagName("tmap:totalTime")[0].childNodes[0].nodeValue/60).toFixed(0)+'분, ';
		     taxi+='요금 : '+$intRate[0].getElementsByTagName("tmap:taxiFare")[0].childNodes[0].nodeValue+'원</span>';
			
		     // 출발 - 도착지점 거리 700m 이하시 다시 찍도록 하기
		     if(tDistance <= 2){
		    	alert('출발지와 도착지가 너무 가까워요! 다시 입력해주세요!');
		    	history.go(0);	//끝까지 다 실행되고 새로고침되네.. 어떻게 해야할까나
		    	return;
		     }
		     else{
			     
			
			     // 실시간 교통정보 추가
			     var trafficColors = {
			         extractStyles:true,
			         /* 실제 교통정보가 표출되면 아래와 같은 Color로 Line이 생성됩니다. */
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
			 }
		 },
		 error:function(request,status,error){ // API가 제대로 작동하지 않을 경우
			 if(tDistance > 1){
			 console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);	 
			 }
		 }
	});
	
    //길찾기 API 호출
 	if(tDistance > 1){
	    searchPubTransPathAJAX(lon1, lat1, lon2, lat2);
 	}
}

//ODsay api 호출
function searchPubTransPathAJAX(lon1, lat1, lon2, lat2) {
	var str = '<b>대중교통</b><br><table border=1><tr><td width="40px" align="center" >추천</td><td align="center" width="345px">경로</td><td width="35px" align="center" >시간(분)</td><td>요금</td><td>경로등록</td></tr>';
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
				dataType: 'json',
				//요청 성공시 어떻게 할 것인지. 방법 1: 다른 함수로 보내기. 뒤에 ()붙이면 안됨. ()붙이는 것은 그 함수를 지금 이 자리에서 실행한다는 뜻이므로.
				success: function(e){
				    reverseGeoCording({s_lonLat:s_lonLat});
					reverseGeoCording({e_lonLat:e_lonLat});
					if(e.searchType == 0){
						var ph=e.path;
						for(var i = 0 ; i<3 ; i++){	
							str+='<tr id="bus'+i+'"><td align="center">'+(i+1)+'</td><td>'
							
							for(var n = 0; n<ph[i].subPath.length;n++){
								
								if(ph[i].subPath[n].trafficType==3){
									str+='도보';		
								} 
								if(ph[i].subPath[n].trafficType==2){
									str+=ph[i].subPath[n].startName+'->';
									str+=ph[i].subPath[n].lane[0].busNo;
									str+='->'+ph[i].subPath[n].endName;
								} 
								if(ph[i].subPath[n].trafficType==1){
									str+=ph[i].subPath[n].startName+'->';
									str+=ph[i].subPath[n].lane[0].name;
									str+='->'+ph[i].subPath[n].endName;
								}
								str+=((n<ph[i].subPath.length-1)? '->':'</td>');

							}
							str+='<td align="center">'+ph[i].info.totalTime+'</td>';
							if(ph[i].info.payment ==0){
								str+='<td align="center">가격 미정</td>';
								
							}else{
							str+='<td align="center">'+ph[i].info.payment+'</td>';
							}
							str+='<td><button type="button" style="background-color:white; border:0px;" class="setsub" datanum='+i+'><img src="resources/img/checked.png" width="20" height="20"></button></td></tr>';
						}
					}else {
			
						for(var i = 0 ; i<e.length ; i++){
							str+='<tr><td>추천'+(i+1)+'</td>';
							str+='<td>'+e[i].startSTN+'->'+e[i].endSTN+'</td>';
							str+='<td align="center">'+e[i].time+'</td>';
							if(e[i].payment == 0){
								str+='<td align="center">가격 미정</td>';	
								str+='<td><button type="button" style="background-color:white; border:0px;"><img src="resources/img/checked.png" width="20" height="20"></button></td></tr>';
							}else{
							str+='<td align="center">'+e[i].payment+'</td>';
							str+='<td><button type="button" style="background-color:white; border:0px;"><img src="resources/img/checked.png" width="20" height="20"></button></td></tr>';
							}
						}
						
					}
					
						str+='</table>';
					$("#result_taxi", parent.document).html(taxi);
					$('#result_sub', parent.document).html(str);

					$('.setsub', parent.document).on('click',{sub:e},set_subPath);
				},
				//요청 실패시 어떻게 할 것인가. 방법 2: 안에 함수 넣어버리기(추가할 내용이 짧을 때 유용).
				error: function (e, request, status, error) {
					//에러 발생시 에러 내용을 문자열로 출력하는 명령어.
					alert(JSON.stringify(e));
					alert("status : " + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
				}
			});				
			callMapObjApiAJAX((JSON.parse(xhr.responseText))["result"]["path"][0].info.mapObj, lon1, lat1, lon2, lat2);
		}
	}

}

 function callMapObjApiAJAX(mabObj){
	var xhr = new XMLHttpRequest();
	//ODsay apiKey 입력
	var url = "https://api.odsay.com/v1/api/loadLane?mapObject=0:0@"+mabObj+"&apiKey=gDSRLToiMkQzCkBbo6vic9U4gHOXXEJVmikqh6HOVn4";
	xhr.open("GET", url, true);
	xhr.send();
	xhr.onreadystatechange = function() {
		if (xhr.readyState == 4 && xhr.status == 200) {
			var resultJsonData = JSON.parse(xhr.responseText);
			var kmlForm = new Tmap.Format.KML({extractStyles:true}).read(resultJsonData);
			var vectorLayer = new Tmap.Layer.Vector("vectorLayerID");
			vectorLayer.addFeatures(kmlForm);
			map.addLayer(vectorLayer);
		}
	}
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

function reverseGeoCording(location){
	var reverse_lat;
	var reverse_lon;
	if(location.s_lonLat != null){
	reverse_lat = location.s_lonLat.lat;
	reverse_lon = location.s_lonLat.lon;
	}else{
	reverse_lat = location.e_lonLat.lat;
	reverse_lon = location.e_lonLat.lon;
	}
	
	var latlng = "https://maps.googleapis.com/maps/api/geocode/xml?latlng=" + reverse_lat + "," + reverse_lon + "&language=ko&sensor=false&key=AIzaSyDBLJ3URwB6HcAHqAJiwwOOqgqwUe2Hu0M";
	         
	   $.ajax({
	      url: latlng,
	      type: "POST",
	      success: function(xml){	    	  
	    		var xmlDoc = xml.getElementsByTagName("formatted_address");	
	    		loca = xmlDoc[0].childNodes[0].nodeValue;
	    		
	    		if(location.s_lonLat!=null){
	    			$('#start', parent.document).html('시작 위치: '+loca);
	    		}else{
	    			$('#end', parent.document).html('도착 위치: '+loca);
	    		}
	   
	      },
	      error: function(e){
	         alert(json.stringify(e));
	      }
	   });

	}
	
	function set_subPath(e){

		var rain = "";
		var num = $(this).attr('datanum');
		var ph =e.data.sub.path[num].subPath;
		console.log(ph);
		for(var i = 0 ; i<ph.length; i++){
			
			if(ph[i].trafficType==3){
				rain+='도보';
			} 
			if(ph[i].trafficType==2){
				rain+=ph[i].startName+'->';
				rain+=ph[i].lane[0].busNo;
				rain+='->'+ph[i].endName;
			} 
			if(ph[i].trafficType==1){
				rain+=ph[i].startName+'->';
				rain+=ph[i].lane[0].name;
				rain+='->'+ph[i].endName;
			}
			if(i<ph.length-1){
				rain+='->';
			}
		}
		$('#subroute', parent.document).val(rain);
	
		for(var m=0; m<ph.length;m++){
			
			if(ph[m].trafficType==3){
				continue;
			}else if(ph[m].trafficType==2){
				$('#input_sub', parent.document).val(ph[m].lane[0].busNo);
				break;
			}else if(ph[m].trafficType==1){
				$('#input_sub', parent.document).val(ph[m].lane[0].name);
				break;
			}
			
		}
		parent.subMapClose();
		location.reload();
		$('#result_sub', parent.document).html("");
		$('#result_taxi', parent.document).html("");
	}

</script>
</head>
<body>
	<!-- 맵 -->
	<div id="map_div"></div>
</body>
</html>