<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!-- <link href="resources/css/scroll.css" rel="stylesheet"> -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="resources/js/jquery-3.3.1.js"></script>
  <link href="resources/css/weather.css" rel="stylesheet">
<script>
$(document).ready(function(){			
	
	
	var lat = "<%=session.getAttribute("lat")%>";

	var lon = "<%=session.getAttribute("lon")%>";
	
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
	    		$("#time"+ i).html(time);
	    		
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
		    			if(weather3.search(weather2) == -1){
		    				weather3 = weather2 + " " + weather3;
		    			}
		    		}
		    		if(weather >= 300 && weather <= 321){
		    			weather2 = "가랑비";
		    			if(weather3.search(weather2) == -1){
		    				weather3 = weather2 + " " + weather3;
		    			}
		    		}
		    		if(weather >= 500 && weather <= 531){
		    			weather2 = "비";
		    			if(weather3.search(weather2) == -1){
		    				weather3 = weather2 + " " + weather3;
		    			}
		    		}
		    		if(weather >= 600 && weather <= 622){
		    			weather2 = "눈";
		    			if(weather3.search(weather2) == -1){
		    				weather3 = weather2 + " " + weather3;
		    			}
		    		}
		    		if(weather == 701 || weather == 721 || weather == 741){
		    			weather2 = "안개";
		    			if(weather3.search(weather2) == -1){
		    				weather3 = weather2 + " " + weather3;
		    			}
		    		}
		    		if(weather == 711){
		    			weather2 = "연기";
		    			if(weather3.search(weather2) == -1){
		    				weather3 = weather2 + " " + weather3;
		    			}
		    		}
		    		if(weather == 731 || weather == 751 || weather == 761){
		    			weather2 = "모래, 먼지";
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
		    			if(weather3.search(weather2) == -1){
		    				weather3 = weather2 + " " + weather3;
		    			}
		    		}
		    		if(weather == 800){
		    			weather2 = "맑은 하늘";
		    			if(weather3.search(weather2) == -1){
		    				weather3 = weather2 + " " + weather3;
		    			}
		    		}
		    		if(weather == 801){
		    			weather2 = "구름 없는 날씨";
		    			if(weather3.search(weather2) == -1){
		    				weather3 = weather2 + " " + weather3;
		    			}
		    		}
		    		if(weather >= 802 && weather <= 804){
		    			weather2 = "구름 있는 날씨";
		    			if(weather3.search(weather2) == -1){
		    				weather3 = weather2 + " " + weather3;
		    			}
		    		}
		    		$("#weather" + i).html(weather3);
		    	}
	    	}
	    },
		error: function (e) {
			alert(JSON.stringify(e));
		}
		
	});
})

</script>
<title>실시간 날씨 </title>

</head>
<body>

<!-- 생각 할 수 있는 방법  IFRAME을 DIV로 감싸고 IFRAME안에 JSP를 띄워야하니까 IF문으로 돌린다 ??
iframe에 반복문을 씌우면 테이블로 이미지를 띄우는거같은 효과가 나지 않을까...?-->

<table>
	<tr>	
			<c:forEach var="i" begin="0" end="38">
		<td>
					<div class="time" style="color:white" >
					시간 <div id="time${i}" ></div><br>
					</div>
					<c:if test="${time${i} eq 'time${i}+1' }">
					<c:choose>
						<c:when test = "${weather${i} eq '구름 없는 날씨'}">
							<a href="sunicon" target="box1">
							</c:when>
						<c:when test = "${weather${i} eq '구름  있는 날씨'}">
							<a href="cloudyicon" target="box1">
							</c:when>
						<c:when test = "${weather${i} eq '비' || ${weather${i} eq '폭우'}" >
							<a href="rainicon" target="box1">
							</c:when>
						<c:when test = "${weather${i} eq '가랑비'}">
							<a href="rainicon" target="box1">
							</c:when>
						<c:when test = "${weather${i} eq '천둥'}">
							<a href="thundericon" target="box1">
							</c:when>
						<c:when test = "${weather${i} eq '비' || ${weather${i} eq '폭우'}">
							<a href="rainicon" target="box1">
							</c:when>
						<c:overwise>
						<!-- 폭우 -->
						<a href="stormicon" target="box1">
						</c:overwise>
					</c:choose>
					<!-- 첫번째 아이프레임에 값 넘기는 건 끝남 -->
					</c:if>
					
						<c:if test="${time${i} eq 'time${i}+2' }">
					<c:choose>
						<c:when test = "${weather${i} eq '구름 없는 날씨'}">
							<a href="sunicon" target="box2">
							</c:when>
						<c:when test = "${weather${i} eq '구름  있는 날씨'}">
							<a href="cloudyicon" target="box2">
							</c:when>
						<c:when test = "${weather${i} eq '비' || ${weather${i} eq '폭우'}" >
							<a href="rainicon" target="box2">
							</c:when>
						<c:when test = "${weather${i} eq '가랑비'}">
							<a href="rainicon" target="box2">
							</c:when>
						<c:when test = "${weather${i} eq '천둥'}">
							<a href="thundericon" target="box2">
							</c:when>
						<c:when test = "${weather${i} eq '비' || ${weather${i} eq '폭우'}">
							<a href="rainicon" target="box2">
							</c:when>
						<c:overwise>
						<!-- 폭우 -->
						<a href="stormicon" target="box2">
						</c:overwise>
					</c:choose>
					<!-- 첫번째 아이프레임에 값 넘기는 건 끝남 -->
				<%-- 	</c:if> --%>
					
					<iframe width="50px" height="50px" src="sun" name = "box1" frameborder=0 framespacing=0 marginheight=0 marginwidth=0 scrolling=no vspace=0></iframe><br> <!-- 위에가 바뀜 -->		
					<div class="other" style="color:white" >
					평균 기온 <div id="temp${i}"></div><br>
					날씨 <div id="weather${i}"></div><br>
					</div>
		</td>
			</c:forEach>	
	</tr>
</table>
<table>
<tr>
	<td>
		<div class="divi">
				<iframe width="100px" height="400px" src="sun" name = "box1" frameborder=0 framespacing=0 marginheight=0 marginwidth=0 scrolling=no vspace=0></iframe>
				<iframe width="100px" height="400px" src="sun" name = "box2" frameborder=0 framespacing=0 marginheight=0 marginwidth=0 scrolling=no vspace=0></iframe>
				<iframe width="100px" height="400px" src="sun" name = "box3" frameborder=0 framespacing=0 marginheight=0 marginwidth=0 scrolling=no vspace=0></iframe>
				<iframe width="100px" height="400px" src="sun" name = "box4" frameborder=0 framespacing=0 marginheight=0 marginwidth=0 scrolling=no vspace=0></iframe>
				<iframe width="100px" height="400px" src="sun" name = "box5" frameborder=0 framespacing=0 marginheight=0 marginwidth=0 scrolling=no vspace=0></iframe>
				<iframe width="100px" height="400px" src="sun" name = "box6" frameborder=0 framespacing=0 marginheight=0 marginwidth=0 scrolling=no vspace=0></iframe>
				<iframe width="100px" height="400px" src="sun" name = "box7" frameborder=0 framespacing=0 marginheight=0 marginwidth=0 scrolling=no vspace=0></iframe>
				<iframe width="100px" height="400px" src="sun" name = "box8" frameborder=0 framespacing=0 marginheight=0 marginwidth=0 scrolling=no vspace=0></iframe>
				<iframe width="100px" height="400px" src="sun" name = "box9" frameborder=0 framespacing=0 marginheight=0 marginwidth=0 scrolling=no vspace=0></iframe>
				<iframe width="100px" height="400px" src="sun" name = "box10" frameborder=0 framespacing=0 marginheight=0 marginwidth=0 scrolling=no vspace=0></iframe>
		</div>
	</td>
</tr>
</table>


	

	 
	
	
	
	
	

</body>
</html>