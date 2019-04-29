<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="resources/css/scroll.css" rel="stylesheet">
  <link href="resources/css/weather.css" rel="stylesheet">
  
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="resources/js/jquery-3.3.1.js"></script>

<script>
$(document).ready(function(){	
	
//애니메이션 숨김
	 $("#sun").hide();
	 $("#rain").hide();
	 $("#cloudy").hide();
	 $("#sand").hide();
	 $("#flurries").hide();
	 $("#snow").hide();
	 $("#storm").hide();
	 $("#thunder").hide();
	 
	var lat;
	var lon;
	
	if(<%=session.getAttribute("searchLocationLat")%> == null){
		lat = "<%=session.getAttribute("lat")%>";
	}
	else{
		lat = "<%=session.getAttribute("searchLocationLat")%>";
	}
	
	if(<%=session.getAttribute("searchLocationLon")%> == null){
		lon = "<%=session.getAttribute("lon")%>";
	}
	else{
		lon = "<%=session.getAttribute("searchLocationLon")%>";
	}
	
	var apiURI = "http://api.openweathermap.org/data/2.5/weather?lat=" + lat + "&lon=" + lon + "&appid="+"c1ae780151cf0ef8cdce02451a0dcc70";
	
	$.ajax({
	    url: apiURI,
	    dataType: "json",
	    type: "GET",
	    async: "false",
	    success: function(resp) {
	    	//지역
	    	var country = resp.sys.country;
	    	var name = resp.name;
	    	$("#outputDiv0").html(country + " - " + name);
	    	
	    	//기온
	    	var temp = resp.main.temp- 273.15;
	    	temp = Math.floor(temp*10)/10;
	    	$("#outputDiv1").html(temp);
	        
	    	//날씨 컨디션
	    	var weather = 0;
	    	var weather2 = null;
	    	var weather3 = "";
	    	
			
			
	    	
	    	
	    	for(var i = 0; i < resp.weather.length; i++){
	    		weather = resp.weather[i].id;
	    		if(weather >=200 && weather <= 232){
	    			weather2 = "천둥";
	    		
	    			 $("#thunder").show();
	    	
	    			if(weather3.search(weather2) == -1){
	    				weather3 = weather2 + " " + weather3;
	    			}
	    		}
	    		if(weather >= 300 && weather <= 321){
	    			weather2 = "가랑비";
	    			
	    			 $("#rain").show();
	    			
	    			if(weather3.search(weather2) == -1){
	    				weather3 = weather2 + " " + weather3;
	    			}
	    		}
	    		if(weather >= 500 && weather <= 531){
	    			weather2 = "비";
	    			 
	    			$("#rain").show();
	    	
	    			if(weather3.search(weather2) == -1){
	    				weather3 = weather2 + " " + weather3;
	    			}
	    		}
	    		if(weather >= 600 && weather <= 622){
	    			weather2 = "눈";
	    			
	    			$("#snow").show();
	    			
	    			if(weather3.search(weather2) == -1){
	    				weather3 = weather2 + " " + weather3;
	    			}
	    		}
	    		if(weather == 701 || weather == 721 || weather == 741){
	    			weather2 = "안개";
			
	    			 $("#cloudy").show();
	    		
	    			if(weather3.search(weather2) == -1){
	    				weather3 = weather2 + " " + weather3;
	    			}
	    		}
	    		if(weather == 711){
	    			weather2 = "연기";

	    			 $("#cloudy").show();
	    			
	    			if(weather3.search(weather2) == -1){
	    				weather3 = weather2 + " " + weather3;
	    			}
	    		}
	    		if(weather == 731 || weather == 751 || weather == 761){
	    			weather2 = "모래, 먼지";
	    			
	    			 $("#sand").show();
	    			
	    			if(weather3.search(weather2) == -1){
	    				weather3 = weather2 + " " + weather3;
	    			}
	    		}
	    		if(weather == 762){
	    			weather2 = "화산재";
	    			if(weather3.search(weather2) == -1){
	    				weather3 = weather2 + " " + weather3;
	    			}
	    		}
	    		if(weather == 771){
	    			weather2 = "스콜스";
	    			
	    			 $("#rain").show();
	    			 
	    			if(weather3.search(weather2) == -1){
	    				weather3 = weather2 + " " + weather3;
	    			}
	    		}
	    		if(weather == 781){
	    			weather2 = "폭풍";
	    			 $("#storm").show();
	    			if(weather3.search(weather2) == -1){
	    				weather3 = weather2 + " " + weather3;
	    			}
	    		}
	    		if(weather == 800){
	    			weather2 = "맑은 하늘";
	    			 $("#sun").show();
	    			if(weather3.search(weather2) == -1){
	    				weather3 = weather2 + " " + weather3;
	    			}
	    		}
	    		if(weather == 801){
	    			weather2 = "구름 없는 날씨";
	    			$("#sun").show();
	    			
	    			if(weather3.search(weather2) == -1){
	    				weather3 = weather2 + " " + weather3;
	    			}
	    		}
	    		if(weather >= 802 && weather <= 804){
	    			weather2 = "구름 있는 날씨";
	    			
	    			$("#cloudy").show();
	    			
	    			
	    			if(weather3.search(weather2) == -1){
	    				weather3 = weather2 + " " + weather3;
	    			}
	    		}
	    		$('#outputDiv2').html(weather3);
	    	}
	    }
	});
	
	
})

</script>
<style>
#cloudy{position:relative;
	top:30px;
	left:30px;
}
.tem{display:inline-block;}
.weatherinfo{text-align:center;}

</style>

<title>실시간 날씨 - 현재위치 자동으로 받아와서</title>
</head>
<body>
<!-- 
현재 기온 : <div id="outputDiv1"></div><br>
날씨 : <div id="outputDiv2"> </div><br> -->

<!-- <h3 color="white">오늘의 날씨 정보</h3> -->
<!-- 날씨별 css -->

<table  style="border-spacing: 400px;">

	<tr>
	<div class="weatherinfo">
	  <div class="tem" style="color:white" >
	  <div id="outputDiv2"> </div><br>
		</div>
		</div>
	</tr>
	
	<tr>
		<div id="sun">
		 <div class="sun">
		    <div class="rays"></div>
		  </div>  
		</div>
		
		<!-- 비 -->
		<div id="rain">
		  	<div class="icon_rain">
		  	<div class="cloud"></div>
		  	<div class="rain"></div>
			</div>  
		</div>
		
		<!--구름  -->
		<div id="cloudy">
		<div class="icon cloudy">
		  <div class="cloud"></div>
		  <div class="cloud"></div>
		</div> 
		 </div>
		 
		<!--황사  -->
		<div id="sand">
		   <div class="icon sand">
		  <div class="sand"></div>
		  <div class="sand"></div>
		</div> 
		</div>
		
		<!-- 폭우 -->
		<div id="storm">
		<  <div class="icon thunder-storm">
		  <div class="cloud"></div>
		  <div class="lightning">
		    <div class="bolt"></div>
		    <div class="bolt"></div>
		  </div>
		</div> 
		</div>
		
		<!-- 천둥번개 -->
		<div id="thunder">
		  <div class="icon thunder">
			 <div class="lightning">
		    <div class="bolt"></div>
		    <div class="bolt"></div>
		  </div>
		</div>  
		</div>
		
		<!-- 폭설 -->
		<div id="flurries">
		  <div class="icon flurries">
		  <div class="cloud"></div>
		  <div class="snow">
		    <div class="flake"></div>
		    <div class="flake"></div>
		  </div>
		</div>  
		</div>
		
		<!-- 눈 -->
		<div id="snow">
		  <div class="icon snow">
		    <div class="flake"></div>
		    <div class="flake"></div>
		</div>  
		</div>
	</tr>
	 <tr><img src="resources/img/weatherbg.png" height="150px"></tr>   
	
		<tr>
		<div class="tem" style="color:white">
		현재 기온  <div id="outputDiv1"></div>
		</div>
		</tr>
	
</table>
</body>
</html>