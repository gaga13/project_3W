<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Tmap 활용 최단경로 길찾기</title>
<script src="resources/js/jquery-3.3.1.min.js"></script>
<script
	src="https://api2.sktelecom.com/tmap/js?version=1&format=javascript&appKey=99ed5523-2eb1-46fb-8cf0-60d0377b2345"></script>
<script>
// 페이지가 로딩이 된 후 호출하는 함수입니다.
function initTmap(){
	// map 생성
	// Tmap.map을 이용하여, 지도가 들어갈 div, 넓이, 높이를 설정합니다.
	var map = new Tmap.Map({div:'map_div', // map을 표시해줄 div
							width:'100%',  // map의 width 설정
							height:'400px' // map의 height 설정
	});
	
	map.addControl(new Tmap.Control.KeyboardDefaults());
    map.addControl(new Tmap.Control.MousePosition());
    map.addControl(new Tmap.Control. OverviewMap());
	
    // 경로 탐색 출발지점과 도착 지점의 좌표
    // 구글 지도에서 나오는 좌표의 x, y를 바꾸면 된다.
    var startX = 126.808866;
    var startY = 35.165443599999996;
    var endX = 127.028131;
    var endY = 37.239072;
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

            // 결과 출력 부분 - 여기는 잘 모르겠음.
            var innerHtml ="";
            var prtclString = new XMLSerializer().serializeToString(prtcl);//xml to String
            xmlDoc = $.parseXML( prtclString ),
            $xml = $( xmlDoc ),
            $intRate = $xml.find("Document");

            var tDistance = " 총 거리 : "+($intRate[0].getElementsByTagName("tmap:totalDistance")[0].childNodes[0].nodeValue/1000).toFixed(1)+"km,";
            var tTime = " 총 시간 : "+($intRate[0].getElementsByTagName("tmap:totalTime")[0].childNodes[0].nodeValue/60).toFixed(0)+"분,";
            var tFare = " 총 요금 : "+$intRate[0].getElementsByTagName("tmap:totalFare")[0].childNodes[0].nodeValue+"원,";
            var taxiFare = " 예상 택시 요금 : "+$intRate[0].getElementsByTagName("tmap:taxiFare")[0].childNodes[0].nodeValue+"원";

            $("#result").text(tDistance+tTime+tFare+taxiFare);

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
        },
        error:function(request,status,error){ // API가 제대로 작동하지 않을 경우
        console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
        }
    });
} 
</script>

</head>
<body onload="initTmap()">
	<div id="map_div"></div>
	<p id="result">결과 표시</p>
</body>
</html>