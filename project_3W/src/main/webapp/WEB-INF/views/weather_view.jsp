<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title> 날씨 </title>
<link href="resources/css/scroll.css" rel="stylesheet">
<script src="resources/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
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
			success: latlngSave,
			error: function(e){
				alert(json.stringify(e));
			}
		});
	}
	
	function latlngSave(con){
		var loc = $(con).find("location").text();
		$.ajax({
			url: 'searchLocationSave',
			type: 'POST',
			data: {loc: loc},
			success: function(){
				history.go(0);
			},
			error: function (e) {
				alert(JSON.stringify(e));
			}
		});
}
}
</script>
</head>
<body>

<!-- 화면 이중분할 -->
<a class="w2" href="weather_RealTime" target="box1"></a>
<a class="w1" href="weather_5Days" target="box2"></a>
	
	<table align="center">
	<tr>
		<td></td>
		<td style="position:relative;">
			날씨 장소 :
			<c:choose>
				<c:when test="${sessionScope.searchLocation == null}">
					${sessionScope.location}
				</c:when>
				<c:otherwise>
					${sessionScope.searchLocation}
				</c:otherwise>
			</c:choose>
		</td>
	</tr>
	<tr>
		<td></td>
		<td style="position:relative;">위치 검색 : <input type="text" id="Search1" placeholder="Enter your location" width= 100%; height=2000; >
		<button type="button" id="bt1" style="background-color: #fff; border: 0px" onclick="locationSearch()">
		<img src="resources/img/search_icon.png" width="18" height="18"></button></td>
	</tr>
	<tr>
		<td rowspan="2"><iframe width="220px" height="400px" src="weather_RealTime" name = "box1" frameborder=0 framespacing=0 marginheight=0 marginwidth=0 scrolling=no vspace=0></iframe></td>
		<td><iframe width="1400px" height="400px" src="weather_5Days" name = "box3" frameborder=0 framespacing=0 marginheight=0 marginwidth=0 scrolling=no vspace=0></iframe></td>
	</tr> 
<!-- 	<tr>

	<td><iframe width="1100px" height="270px" src="weather_5Days" name = "box2" frameborder=0 framespacing=0 marginheight=0 marginwidth=0 scrolling=no vspace=0></iframe></td>
	</tr> -->
	</table>

</body>
</html>