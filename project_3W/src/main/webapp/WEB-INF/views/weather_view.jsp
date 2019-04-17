<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title> 날씨 </title>
<link href="resources/css/scroll.css" rel="stylesheet">
</head>
<body>

<!-- 화면 이중분할 -->
<a class="w2" href="weather_RealTime" target="box1"></a>
<a class="w1" href="weather_5Days" target="box2"></a>
<a class="w3" href="weather_Search" target="box3"></a>

	<table>
	<tr>
		<td rowspan="2"><iframe width="500px" height="310px" src="weather_RealTime" name = "box1" frameborder=0 framespacing=0 marginheight=0 marginwidth=0 scrolling=no vspace=0></iframe></td>
		<td><iframe width="810px" height="155px" src="weather_5Days" name = "box2" frameborder=0 framespacing=0 marginheight=0 marginwidth=0 scrolling=no vspace=0></iframe></td>
	</tr>
	<tr>		
		<td ><iframe width="810px" height="155px" src="weather_Search" name = "box3" frameborder=0 framespacing=0 marginheight=0 marginwidth=0 scrolling=no vspace=0></iframe></td>
	</tr>		
	</table>

</body>
</html>