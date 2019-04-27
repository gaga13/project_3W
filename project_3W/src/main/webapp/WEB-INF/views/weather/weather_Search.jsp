<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="resources/css/scroll.css" rel="stylesheet">
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<script src="resources/js/jquery-3.3.1.js"></script>
<link href="resources/css/weather.css" rel="stylesheet">
<script>
$(document).ready(function(){
	$('#bt1').on('click', locationSearch);
 	
});

function locationSearch(){
	var location = document.getElementById("Search1");
	var lat;
	var lon;
	
	$.ajax({
		url: 'translate',
		type: "GET",
		data: {country : location.value},
		dataType: "text",
		success: Conversion,
		error: function(e){
			alert(json.stringify(e));
		}
	});
	
	function Conversion(country){
		var latlng = "https://maps.googleapis.com/maps/api/geocode/xml?address=" + 
				country + "&language=ko&sensor=false&key=AIzaSyDBLJ3URwB6HcAHqAJiwwOOqgqwUe2Hu0M"
		
		$.ajax({
			url: latlng,
			dataType: "xml",
			type: "GET",
			async: "false",
			success: split,
			error: function(e){
				alert(json.stringify(e));
			}
		});
	}
	
 	function split (con) {
		var loc = $(con).find("location").text();
		$.ajax({
			url: 'split',
			type: 'POST',
			data: {loc: loc},
			dataType: 'json',
			success: function(hash){
				var lon = hash.lng;
				var lat = hash.lat;
				
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
				    			/*  $("#thunder").show(); */
				    			if(weather3.search(weather2) == -1){
				    				weather3 = weather2 + " " + weather3;
				    			}
				    		}
				    		if(weather >= 300 && weather <= 321){
				    			weather2 = "가랑비";
				    			/*  $("#rain").show(); */
				    			if(weather3.search(weather2) == -1){
				    				weather3 = weather2 + " " + weather3;
				    			}
				    		}
				    		if(weather >= 500 && weather <= 531){
				    			weather2 = "비";
				    			/*  $("#rain").show(); */
				    			if(weather3.search(weather2) == -1){
				    				weather3 = weather2 + " " + weather3;
				    			}
				    		}
				    		if(weather >= 600 && weather <= 622){
				    			weather2 = "눈";
				    			/*  $("#snow").show(); */
				    			if(weather3.search(weather2) == -1){
				    				weather3 = weather2 + " " + weather3;
				    			}
				    		}
				    		if(weather == 701 || weather == 721 || weather == 741){
				    			weather2 = "안개";
				    			/*  $("#cloudy").show(); */
				    			if(weather3.search(weather2) == -1){
				    				weather3 = weather2 + " " + weather3;
				    			}
				    		}
				    		if(weather == 711){
				    			weather2 = "연기";
				    			/*  $("#cloudy").show(); */
				    			if(weather3.search(weather2) == -1){
				    				weather3 = weather2 + " " + weather3;
				    			}
				    		}
				    		if(weather == 731 || weather == 751 || weather == 761){
				    			weather2 = "모래, 먼지";
				    			/*  $("#sand").show(); */
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
				    			if(weather3.search(weather2) == -1){
				    				weather3 = weather2 + " " + weather3;
				    			}
				    		}
				    		if(weather == 781){
				    			weather2 = "폭풍";
				    		/* 	 $("#storm").show(); */
				    			if(weather3.search(weather2) == -1){
				    				weather3 = weather2 + " " + weather3;
				    			}
				    		}
				    		if(weather == 800){
				    			weather2 = "맑은 하늘";
				    		/* 	 $("#sun").show(); */
				    			if(weather3.search(weather2) == -1){
				    				weather3 = weather2 + " " + weather3;
				    			}
				    		}
				    		if(weather == 801){
				    			weather2 = "구름 없는 날씨";
				    			/*  $("#sun").show(); */
				    			if(weather3.search(weather2) == -1){
				    				weather3 = weather2 + " " + weather3;
				    			}
				    		}
				    		if(weather >= 802 && weather <= 804){
				    			weather2 = "구름 있는 날씨";
				    			/*  $("#cloudy").show(); */
				    			if(weather3.search(weather2) == -1){
				    				weather3 = weather2 + " " + weather3;
				    			}
				    		}
				    		$('#outputDiv2').html(weather3);
				    	}
				    }
				});
				
				var apiURI = "http://api.openweathermap.org/data/2.5/forecast?lat=" + lat + "&lon=" + lon + "&appid="+"c1ae780151cf0ef8cdce02451a0dcc70";
				
				$.ajax({
					url: apiURI,
				    dataType: "json",
				    type: "GET",
				    async: "false",
				    success: function(resp) {
				    	
				    	for(var i = 0; i < resp.list.length; i++){
				    		//시간
				    		var time = resp.list[i].dt_txt;
				    		var timesplit = time.split(' ');
				    		var year = timesplit[0].split('-');
				    		var time_s = timesplit[1].split(':',1);
				    		/* 	alert(time_s); */
				    		
				    		if(time_s == '06' || time_s =='18'){
	    		
			    			$("#time"+ i).html(year[1]+" / "+year[2]+"\r\n"+time_s+"시");
							/*  alert(time);  */
				    		
					    	//기온
					    	var temp = resp.list[i].main.temp- 273.15;
					    	temp = Math.floor(temp*10)/10;
					    	$("#temp" + i).html(temp);
					    	
					    	//날씨 컨디션
					    	var weather = 0;
					    	var weather2 = null;
					    	var weather3 = "";
					    	for(var j = 0; j < resp.list[i].weather.length; j++){
					    		weather = resp.list[i].weather[j].id;
					    		if(weather >=200 && weather <= 232){
					    			weather2 = "천둥";
					    			 /* $("#thunder").show(); */
					    			if(weather3.search(weather2) == -1){
					    				weather3 = weather2 + " " + weather3;
					    			}
					    		}
					    		if(weather >= 300 && weather <= 321){
					    			weather2 = "가랑비";
					    			 /* $("#rain").show(); */
					    			if(weather3.search(weather2) == -1){
					    				weather3 = weather2 + " " + weather3;
					    			}
					    		}
					    		if(weather >= 500 && weather <= 531){
					    			weather2 = "비";
					    	/* 		 $("#rain").show(); */
					    			if(weather3.search(weather2) == -1){
					    				weather3 = weather2 + " " + weather3;
					    			}
					    		}
					    		if(weather >= 600 && weather <= 622){
					    			weather2 = "눈";
					    	/* 		 $("#snow").show(); */
					    			if(weather3.search(weather2) == -1){
					    				weather3 = weather2 + " " + weather3;
					    			}
					    		}
					    		if(weather == 701 || weather == 721 || weather == 741){
					    			weather2 = "안개";
					    			 /* $("#cloudy").show(); */
					    			if(weather3.search(weather2) == -1){
					    				weather3 = weather2 + " " + weather3;
					    			}
					    		}
					    		if(weather == 711){
					    			weather2 = "연기";
					    			 /* $("#cloudy").show(); */
					    			if(weather3.search(weather2) == -1){
					    				weather3 = weather2 + " " + weather3;
					    			}
					    		}
					    		if(weather == 731 || weather == 751 || weather == 761){
					    			weather2 = "모래, 먼지";
					    			 /* $("#sand").show(); */
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
					    			if(weather3.search(weather2) == -1){
					    				weather3 = weather2 + " " + weather3;
					    			}
					    		}
					    		if(weather == 781){
					    			weather2 = "폭풍";
					    			 /* $("#storm").show(); */
					    			if(weather3.search(weather2) == -1){
					    				weather3 = weather2 + " " + weather3;
					    			}
					    		}
					    		if(weather == 800){
					    			weather2 = "맑은 하늘";
					    			 /* $("#sun").show(); */
					    			if(weather3.search(weather2) == -1){
					    				weather3 = weather2 + " " + weather3;
					    			}
					    		}
					    		if(weather == 801){
					    			weather2 = "구름 없는 날씨";
					    			 /* $("#sun").show(); */
					    			if(weather3.search(weather2) == -1){
					    				weather3 = weather2 + " " + weather3;
					    			}
					    		}
					    		if(weather >= 802 && weather <= 804){
					    			weather2 = "구름 있는 날씨";
					    			/*  $("#cloudy").show(); */
					    			if(weather3.search(weather2) == -1){
					    				weather3 = weather2 + " " + weather3;
					    			}
					    		}
					    		$("#weather" + i).html(weather3);
					    	}
				    	}
				    }
				  },
					error: function (e) {
						alert(JSON.stringify(e));
					}
				});
				
			}
		});
	}
}

</script>
<style>
.searchbar{ width: 300px;
  vertical-align: middle;
  white-space: nowrap;
  position: relative;}

</style>

<title>실시간 날씨</title>

</head>
<body>

<div class = "searchbar">
<input type="text" id="Search1" placeholder="Enter your location">
 <button type="button" id="bt1" style="background-color:#85ccbb; border:0px"><img src="resources/img/search_icon.png" width="30" height="30"></button>
</div>
	
<table style="border-spacing: 500px;">
	<tr>
		<c:forEach var="i" begin="0" end="38">
				<td>
					<table>
						 <tr>
						 	<td>
								<div id="tem" class="tem" style="color:white" >
								시간  <div id="time${i}"></div>
								지역  <div id="outputDiv0"></div><br>
								날씨  <div id="outputDiv2"> </div><br>
								</div>
							</td>
						</tr>
					
						<tr>
							<td>
								<div id="tem_1" class="tem_1" style="color:white">
								날씨 : <div id="weather${i}"></div><br>
								평균 기온  <div id="temp${i}"></div>
								</div>
							</td>
						</tr>
					</table>
				</td>
		</c:forEach>
	</tr>		
</table>


<input type="hidden" id="lng" value="${sessionScope.loginLon}"/>
<input type="hidden" id="lat" value="${sessionScope.loginLat}"/>

</body>
</html>