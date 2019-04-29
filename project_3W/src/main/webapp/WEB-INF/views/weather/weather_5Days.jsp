<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!-- <link href="resources/css/scroll.css" rel="stylesheet"> -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="resources/js/jquery-3.3.1.js"></script>
<link href="resources/css/weather.css" rel="stylesheet">
<script>

$(document).ready(function(){			
	
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

						var apiURI = "http://api.openweathermap.org/data/2.5/forecast?lat="
								+ lat
								+ "&lon="
								+ lon
								+ "&appid="
								+ "c1ae780151cf0ef8cdce02451a0dcc70";

						$
								.ajax({
									url : apiURI,
									dataType : "json",
									type : "GET",
									async : "false",
									success : function(resp) {

										for (var i = 0; i < resp.list.length; i++) {
											//시간
											var time = resp.list[i].dt_txt;
											var timesplit = time.split(' ');
											var year = timesplit[0].split('-');
											var time_s = timesplit[1].split(
													':', 1);

											if (time_s == '06'
													|| time_s == '18') {

												$("#time" + i).html(
														year[1] + " / "
																+ year[2]
																+ "\r\n"
																+ time_s + "시");

												//기온
												var temp = resp.list[i].main.temp - 273.15;
												temp = Math.floor(temp * 10) / 10;
												$("#temp" + i).html(
														temp + "\n℃");

												//날씨 컨디션
												var weather = 0;
												var weather2 = null;
												var weather3 = "";
												for (var j = 0; j < resp.list[i].weather.length; j++) {
													weather = resp.list[i].weather[j].id;
													if (weather >= 200
															&& weather <= 232) {
														weather2 = "천둥";
														
														var div = document.createElement('div');

													    div.innerHTML = document.getElementById('thunder').innerHTML;

													    document.getElementById('weatherImage' + i).appendChild(div);
														
														/* $("#thunder").show(); */
														if (weather3
																.search(weather2) == -1) {
															weather3 = weather2
																	+ " "
																	+ weather3;
														}

													}
													if (weather >= 300
															&& weather <= 321) {
														weather2 = "가랑비";
														
														var div = document.createElement('div');

													    div.innerHTML = document.getElementById('rain').innerHTML;

													    document.getElementById('weatherImage' + i).appendChild(div);
														
														/* $("#rain").show(); */
														if (weather3
																.search(weather2) == -1) {
															weather3 = weather2
																	+ " "
																	+ weather3;
														}
													}
													if (weather >= 500
															&& weather <= 531) {
														weather2 = "비";
														
														var div = document.createElement('div');

													    div.innerHTML = document.getElementById('rain').innerHTML;

													    document.getElementById('weatherImage' + i).appendChild(div);
														
														/* 	$("#rain").show(); */
														if (weather3
																.search(weather2) == -1) {
															weather3 = weather2
																	+ " "
																	+ weather3;
														}
													}
													if (weather >= 600
															&& weather <= 622) {
														weather2 = "눈";
														
														var div = document.createElement('div');

													    div.innerHTML = document.getElementById('snow').innerHTML;

													    document.getElementById('weatherImage' + i).appendChild(div);
														
														/* $("#snow").show(); */
														if (weather3
																.search(weather2) == -1) {
															weather3 = weather2
																	+ " "
																	+ weather3;
														}
													}
													if (weather == 701
															|| weather == 721
															|| weather == 741) {
														weather2 = "안개";
														
														var div = document.createElement('div');

													    div.innerHTML = document.getElementById('cloudy').innerHTML;

													    document.getElementById('weatherImage' + i).appendChild(div);
														
														/* 	$("#cloudy").show(); */
														if (weather3
																.search(weather2) == -1) {
															weather3 = weather2
																	+ " "
																	+ weather3;
														}
													}
													if (weather == 711) {
														weather2 = "연기";
														
														var div = document.createElement('div');

													    div.innerHTML = document.getElementById('cloudy').innerHTML;

													    document.getElementById('weatherImage' + i).appendChild(div);
													    
														/* $("#cloudy").show(); */
														if (weather3
																.search(weather2) == -1) {
															weather3 = weather2
																	+ " "
																	+ weather3;
														}
													}
													if (weather == 731
															|| weather == 751
															|| weather == 761) {
														weather2 = "모래, 먼지";
														
														var div = document.createElement('div');

													    div.innerHTML = document.getElementById('sand').innerHTML;

													    document.getElementById('weatherImage' + i).appendChild(div);
													    
														/* $("#sand").show(); */
														if (weather3
																.search(weather2) == -1) {
															weather3 = weather2
																	+ " "
																	+ weather3;
														}
													}
													if (weather == 762) {
														weather2 = "화산재";
														if (weather3
																.search(weather2) == -1) {
															weather3 = weather2
																	+ " "
																	+ weather3;
														}
													}
													if (weather == 771) {
														weather2 = "스콜스";
														if (weather3
																.search(weather2) == -1) {
															weather3 = weather2
																	+ " "
																	+ weather3;
														}
													}
													if (weather == 781) {
														weather2 = "폭풍";
														
														var div = document.createElement('div');

													    div.innerHTML = document.getElementById('storm').innerHTML;

													    document.getElementById('weatherImage' + i).appendChild(div);
													    
														/* 	$("#storm").show(); */
														if (weather3
																.search(weather2) == -1) {
															weather3 = weather2
																	+ " "
																	+ weather3;
														}
													}
													if (weather == 800) {
														weather2 = "맑은 하늘";
														var a = 'aa';
														
														var div = document.createElement('div');

													    div.innerHTML = document.getElementById('sun').innerHTML;

													    document.getElementById('weatherImage' + i).appendChild(div);
														
														/* 	$("#sun").show(); */
														if (weather3
																.search(weather2) == -1) {
															weather3 = weather2
																	+ " "
																	+ weather3;
														}
													}
													if (weather == 801) {
														weather2 = "구름 없는 날씨";
														
														var div = document.createElement('div');

													    div.innerHTML = document.getElementById('sun').innerHTML;

													    document.getElementById('weatherImage' + i).appendChild(div);

														/* 		$("#sun").show(); */

														if (weather3
																.search(weather2) == -1) {
															weather3 = weather2
																	+ " "
																	+ weather3;
														}
													}
													if (weather >= 802
															&& weather <= 804) {
														weather2 = "구름 있는 날씨";
														var div = document.createElement('div');

													    div.innerHTML = document.getElementById('cloudy').innerHTML;

													    document.getElementById('weatherImage' + i).appendChild(div);

														/* 		$("#cloudy").show(); */

														if (weather3
																.search(weather2) == -1) {
															weather3 = weather2
																	+ " "
																	+ weather3;
														}
													}
													$("#weather" + i).html(
															weather3);
												}
											}
										}
									},
									error : function(e) {
										alert(JSON.stringify(e));
									}
								});
					})
</script>

<style>
#weather {
	position: absolute;
	top: 60px;
	left: 10px;
}

#weathertime {
	position: relative;
	left: -80px;
	top: 40px;
	display: inline-block;
	color: white;
}
#weather_icon{
	display:inline-blick;
}
.weather_out{
		width :100%;
		text-align:center;
		position: relative;
		top: 100px;}
#weather_icon_table{
	position:absolute;
	top:50px;
	left:20px;
}
#weatehrImg{ 
position:relative;
top:50px;
color: #85ccbb;}

#a{
position:absolute;;
top:80px;
left:30px;
}
#5Daysweather{
border-spacing: 10px;
 border-collapse: separate;
}
 
.box:before {
    content: "";
    display: block;
    padding-top: 100%; /* 1:1 비율 */
}
 
.content {
    position: absolute;
    top: 0;
    right: 0;
    bottom: 0;
    left: 0;
}

/* 화면 비율 조정 */
.box {
    height:100%;
    width:100%;
}


</style>
<title>실시간 날씨</title>

</head>
<body>
<div class="box">
	<div id="weather"
		style="height: 300px; width: 1300px;  border: 2px solid white; padding-left: 110px; padding-right: -70px; padding-top: 10px;">
		<table id="5Daysweather">		
			<tr>	
				<c:forEach var="i" begin="0" end="39">		
					<td >
						<div id="weathertime" style="height:40px">
							<div id="time${i}"></div>
							<div id="temp${i}"></div>
							<div id="weather${i}"></div>
							<div id="a">
							<div id="weatehrImg">
							<div id="weatherImage${i}"></div>
							</div>
							</div>
						</div>
					</td>
				</c:forEach>
			</tr>
			
			<tr>
			</tr>
		</table>
	</div>
	
	<table id="weather_icon_table">
	
	<div class="weatehr_out">
		<div id="weather_icon">
			<div id="sun" style="visibility: hidden;">
				<div class="sun">
					<div class="rays"></div>
				</div>
			</div>
			<!-- 비 -->
			<div id="rain" style="visibility: hidden;">
				<div class="icon_rain">
					<div class="cloud"></div>
					<div class="rain"></div>
				</div>
			</div>
		
			<!--구름  -->
			<div id="cloudy" style="visibility: hidden;">
				<div class="icon cloudy">
					<div class="cloud"></div>
					<div class="cloud"></div>
				</div>
			</div>
		
			<!--황사  -->
			<div id="sand" style="visibility: hidden;">
				<div class="icon sand">
					<div class="sand"></div>
					<div class="sand"></div>
				</div>
			</div>
		
			<!-- 폭우 -->
			<div id="storm" style="visibility: hidden;">
				<div class="icon thunder-storm">
					<div class="cloud"></div>
					<div class="lightning">
						<div class="bolt"></div>
						<div class="bolt"></div>
					</div>
				</div>
			</div>
		
			<!-- 천둥번개 -->
			<div id="thunder" style="visibility: hidden;">
				<div class="icon thunder">
					<div class="lightning">
						<div class="bolt"></div>
						<div class="bolt"></div>
					</div>
				</div>
			</div>
		
			<!-- 폭설 -->
			<div id="flurries" style="visibility: hidden;">
				<div class="icon flurries">
					<div class="cloud"></div>
					<div class="snow">
						<div class="flake"></div>
						<div class="flake"></div>
					</div>
				</div>
			</div>
		
			<!-- 눈 -->
			<div id="snow" style="visibility: hidden;">
				<div class="icon snow">
					<div class="flake"></div>
					<div class="flake"></div>
				</div>
			</div>
		</div>
	</div>
</table>
</div>
</body>
</html>