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
var locations = [];
var checkLonlat = [];

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
       map.setCenter(new Tmap.LonLat(lng, lat).transform("EPSG:4326", "EPSG:3857"), 10);
    }
    //map.ctrl_nav.enableZoomWheel();       //지도 확대 축소 기능 활성화 - 효과 없음
    tData = new Tmap.TData();
   
    markerLayer = new Tmap.Layer.Markers();//마커 레이어 생성
      map.addLayer(markerLayer);//map에 마커 레이어 추가
      
      var size = new Tmap.Size(28, 34);//아이콘 크기
      var offset = new Tmap.Pixel(-(size.w / 2), -(size.h));            //아이콘 중심점
      
   for (var i = 0; i< sList.length; i++){         //for문을 통하여 배열 안에 있는 값을 마커 생성
      
      
      var icon = new Tmap.Icon('resources/img/marker/maps-and-flags (2).png',size, offset);//아이콘 설정
      var slat = sList[i].slatitude;
      var slon = sList[i].slongitude;
   
      var loca = sList[i].slocation;
      var content = sList[i].scontent;
      var start = sList[i].startdate;
      var title = sList[i].startdate + '<br>' + sList[i].slocation;
      var sslonlat = slat + ',' + slon;
      
      //팝업을 위한 배열(위치값 , 팝업에 띄울 값)
      locations.push({lonlat:new Tmap.LonLat(slon, slat).transform("EPSG:4326", "EPSG:3857"),
         slocation: loca, 
         stitle: "<div style=' position: relative; padding: 0 2px 2px 0;'>"+
       "<div style='font-size: 16px; text-align:center; font-family:나눔고딕;'>"+
            title     +   "</div>"+ "</div>"});
      
      var a = new Tmap.LonLat(slon, slat).transform("EPSG:4326", "EPSG:3857");
      var b = a.lon + ',' + a.lat;
      
      //확인용 배열
      checkLonlat.push({originLonlat:sslonlat, transLonlat:b, scontent: content, startdate: start, slocation: loca });
      
      var lonlat = locations[i].lonlat; // 마커 위치
      var title = locations[i].stitle; // 마커 타이틀
      marker = new Tmap.Marker(lonlat, icon);//마커 생성
      markerLayer.addMarker(marker); //마커 레이어에 마커 추가
      
      //팝업 생성
      popup = new Tmap.Popup("p1", locations[i].lonlat, new Tmap.Size(120, 50), locations[i].stitle);
      popup.setBorder("1px solid #8d8d8d");//popup border 조절
      popup.autoSize = true;//popup 사이즈 자동 조절
      map.addPopup(popup); // 지도에 팝업 추가
      
      
      popup.hide(); //팝업 숨기기
      
      //마커 이벤트등록
      marker.events.register("click", new MarkerPopup(marker, popup), onClickMarker); // 마커를 클릭했을 때 이벤트 설정
      marker.events.register("mouseover", new MarkerPopup(marker, popup), onOverMarker); // 마커위로 마우스 포인터가 들어왔을 때 이벤트 설정
      marker.events.register("mouseout", new MarkerPopup(marker, popup), onOutMarker); // 마커위에 있던 마우스 포인터가 밖으로 나갔을 때 이벤트 설정

   } 
   // 마커에 마우스가 오버되었을 때 발생하는 이벤트 함수입니다.
   function onOverMarker(evt) {
      this.popup.show(); // 마커에 마우스가 오버되었을 때 팝업이 보입니다. 
      
      markerLayer.removeMarker(this.marker); // 기존의 마커를 지웁니다.
      size = new Tmap.Size(28, 34); // 마커 사이즈 지정
      icon = new Tmap.Icon('resources/img/marker/maps-and-flags (2).png',size, offset); // 마커 아이콘 지정
      marker = new Tmap.Marker(this.marker.lonlat, icon); // 마커 생성
      markerLayer.addMarker(marker); // 마커레이어에 마커 추가
      marker.events.register("mouseout", new MarkerPopup(marker, this.popup), onOutMarker); // 마커위에 있던 마우스 포인터가 밖으로 나갔을 때 이벤트 설정
      marker.events.register("click", new MarkerPopup(marker, this.popup), onClickMarker); // 마커를 클릭했을 때 이벤트 설정
   }
   //마커에 마우스가 아웃되었을 때 발생하는 이벤트 함수입니다.
   function onOutMarker(evt) {
      this.popup.hide(); // 마커에 마우스가 없을땐 팝업이 숨겨집니다.
      
      markerLayer.removeMarker(this.marker); // 기존의 마커를 지웁니다.
      size = new Tmap.Size(28, 34); // 마커 사이즈 지정
      icon = new Tmap.Icon('resources/img/marker/maps-and-flags (2).png',size, offset); // 마커 아이콘 지정
      marker = new Tmap.Marker(this.marker.lonlat, icon); // 마커 생성
      markerLayer.addMarker(marker); // 마커레이어에 마커 추가
      marker.events.register("mouseover", new MarkerPopup(marker, this.popup), onOverMarker); // 마커위로 마우스 포인터가 들어왔을 때 이벤트 설정
      
   }        
   // 마커가 클릭되었을 때 발생하는 이벤트 함수입니다.
   function onClickMarker(evt) {   
      
      this.popup.hide(); // 클릭했을때 팝업이 숨겨집니다.
      var tlonlat = this.popup.lonlat.lon + ',' + this.popup.lonlat.lat;
      
      if( selectMarker ) {
         // 기존 빨간 마커 지우기
         markerLayer.removeMarker(selectMarker);
         // 기존 빨간 마커 파란 마커로 다시 그리기
         
         size = new Tmap.Size(28, 34); // 마커 아이콘 사이즈 지정
         
         icon = new Tmap.Icon('resources/img/marker/maps-and-flags (2).png',size, offset); // 마커 아이콘 생성
         marker = new Tmap.Marker(selectMarker.lonlat, icon); // 마커 생성
         markerLayer.addMarker(marker); // 마커레이어에 마커 추가
         marker.events.register("mouseover", new MarkerPopup(marker, selectPopup), onOverMarker); // 마커위로 마우스 포인터가 들어왔을 때 이벤트 설정
      }
      
      // 빨간 마커 그리기
      markerLayer.removeMarker(this.marker); // 마커 삭제
      size = new Tmap.Size(28, 34); // 마커 아이콘 사이즈 지정
      
      icon = new Tmap.Icon('resources/img/marker/marker_red.png' ,size, offset); // 마커 아이콘 생성
      
      marker = new Tmap.Marker(this.marker.lonlat, icon); // 마커 생성
      selectMarker = marker; // 선택된 마커 저장
      selectPopup = this.popup; // 선택된 팝업 저장 
      markerLayer.addMarker(marker); // 마커레이어에 마커 추가
      
      var olonlat;
      for(var i = 0; i < checkLonlat.length; i++){
         
         if(checkLonlat[i].transLonlat == tlonlat){
             olonlat = checkLonlat[i].originLonlat;
         }
      } 
      console.log(olonlat);
   
      //session에 값 저장
      reverseGeoCording(olonlat);
      
      
      //시간, 제목 띄우기
      for( var i = 0; i < checkLonlat.length; i++ ){
         if(checkLonlat[i].transLonlat == tlonlat){
            var notice = '[ ' + checkLonlat[i].startdate + ' ' + checkLonlat[i].scontent + ' ] 스케쥴이 선택되었습니다.';
            var slocation = checkLonlat[i].slocation;
         }
      }
      
      //session에  searchLocation, searchLocationLat, searchLocationLon   저장
      setSession(olonlat, slocation);
      
      alert(notice);
   }
   
   //맵 확대축소 제어 컨트롤러 삭제
   map.removeZoomControl();
}

// 지도의 줌레벨을 한단계 올리는 함수입니다.
function zoomIn(){
   map.zoomIn(); //지도를 1레벨 올립니다.
}
// 지도의 줌레벨을 한단계 내리는 함수입니다.
function zoomOut(){
   map.zoomOut(); //지도를 1레벨 내립니다.
}

function reverseGeoCording(olonlat){
      
      var seslonlatList = olonlat.split(',');
      var lat = seslonlatList[0];
      var lon = seslonlatList[1];
   
      var latlng = "https://maps.googleapis.com/maps/api/geocode/xml?latlng=" + lat + "," + lon + "&language=ko&sensor=false&key=AIzaSyDBLJ3URwB6HcAHqAJiwwOOqgqwUe2Hu0M"
            
      $.ajax({
         url: latlng,
         type: "POST",
         success: XMLParsing,
         error: function(e){
            alert(JSON.stringify(e));
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
      top.frames["box2"].location.reload();
} 
   
//session에  searchLocation, searchLocationLat, searchLocationLon   저장
function setSession(olonlat, slocation){
   
   var seslonlatList = olonlat.split(',');
   var lat = seslonlatList[0];
   var lon = seslonlatList[1];
   
   $.ajax({
         url: 'setSession',
         type: 'post',
         data: {searchLocationLat: lat, searchLocationLon:lon, searchLocation: slocation},
         dataType: 'text',
         success: function(){
         },
         error: function (e) {
            alert(JSON.stringify(e));
            
         }
      }); 
} 
</script>

<title>Insert title here</title>
</head>
<body>
   <div id="map_div">
</body>
</html>