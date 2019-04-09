<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0ea65279ab9874eb15c5fd98582cf9af&libraries=services,clusterer,drawing"></script>
<script>
    var map;
    
    window.onload = function () {
        // 페이지 로드시 나의 현재 위치의 위도와 경도 얻기
        // 현재 위치정보 딱 한번 얻기
        navigator.geolocation.watchPosition(sucCall);
    };

    // 위치정보 얻기 성공시 자동으로 호출되는 콜백함수. 인자는 Position 객체
    var sucCall = function (position) {
        // 위도, 경도 얻기
        var lat = position.coords.latitude;
        var lng = position.coords.longitude;

        // 지도표시
        displayMap(lat, lng);
    };

    function displayMap(lat, lng) {
        // 지도 표시
        var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
        var options = { //지도를 생성할 때 필요한 기본 옵션
            center: new daum.maps.LatLng(lat, lng), //지도의 중심좌표.
            level: 3 //지도의 레벨(확대, 축소 정도)
        };

        map = new daum.maps.Map(container, options); //지도 생성 및 객체 리턴
        
        var mapTypeControl = new daum.maps.MapTypeControl(); //일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성
		
	     // 지도에 컨트롤을 추가해야 지도위에 표시됩니다
	     // daum.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
	     map.addControl(mapTypeControl, daum.maps.ControlPosition.TOPRIGHT);
        
		 // 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
	     var zoomControl = new daum.maps.ZoomControl();
	     map.addControl(zoomControl, daum.maps.ControlPosition.RIGHT);
        
        // 마커 표시
        setMarker(lat, lng, "<div style='padding:5px;'>현재 나의 위치</div>");
    }

    function setMarker(lat, lng, content) {
        // 마커가 표시될 위치입니다 
        var markerPosition = new daum.maps.LatLng(lat, lng);

        // 마커를 생성합니다
        var marker = new daum.maps.Marker({
            position: markerPosition,
            clickable: true
        });

        // 마커가 지도 위에 표시되도록 설정합니다
        marker.setMap(map);

        // 마커에 클릭이벤트 등록하기
        setMarkerClick(marker, content);
    }

    function setMarkerClick(marker, content) {
        // 인포윈도우를 생성합니다
        var infowindow = new daum.maps.InfoWindow({
            content: content,
            removable: true
        });

        // 마커에 클릭이벤트를 등록합니다
        daum.maps.event.addListener(marker, 'click', function () {
            // 마커 위에 인포윈도우를 표시합니다
            infowindow.open(map, marker);
        });
    }

    function codeAddress() {
        var address = document.getElementById("address").value;

        // 주소-좌표 변환 객체를 생성합니다
        var geocoder = new daum.maps.services.Geocoder();

        // 주소로 좌표를 검색합니다
        geocoder.addressSearch(address, function (result, status) {
            // 정상적으로 검색이 완료됐으면 
            if (status === daum.maps.services.Status.OK) {
                var lat = result[0].y;
                var lng = result[0].x;

                setMarker(lat, lng, "<div style='padding:5px;'>"+ address+"</div>");

                // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
                map.setCenter(new daum.maps.LatLng(lat, lng));
            }
        });    
    }
</script>
</head>
<body>
	<fieldset>
        <legend>현재 위치를 지도에 표시하기</legend>
    </fieldset>
    <div id="map" style="width:500px;height:400px;"></div>
    <!-- 로드뷰를 표시할 div 입니다 -->
	
    
    <fieldset>
        <legend>주소로 위치 찾기</legend>
        <div>
            <input id="address" type="text">
            <input type="button" value="주소명" onclick="codeAddress()">
        </div>
    </fieldset>
</body>
</html>