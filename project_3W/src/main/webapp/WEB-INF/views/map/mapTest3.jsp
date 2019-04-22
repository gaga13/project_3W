<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="resources/js/jquery-3.3.1.js"></script>
<script>
$(document).ready(function(){
	$('#mapBtn').on('click', changeIframe);
});
function changeIframe(){
	if($('#iframe2').attr('src') == 'map_Basic'){
		$('#iframe2').attr("src", "map_Main"); 
	}
	else{
		$('#iframe2').attr("src", "map_Basic");
	}
 

}
</script>
<title>Insert title here</title>
</head>
<body>
<input type="button" id="mapBtn" value="맵 전환">
<iframe width="100%" height="400px" src="map_Basic" name = "box1" frameborder=0 framespacing=0 marginheight=0 marginwidth=0 scrolling=no vspace=0 id="iframe2"></iframe><br>
</body>
</html>