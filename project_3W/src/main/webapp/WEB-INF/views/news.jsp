<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>뉴스</title>
<script src="<c:url value='resources/js/jquery-3.3.1.js'/>"></script>
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
      <link rel="stylesheet" href="resources/css/table.css">
		<link href='https://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'>
 <style type="text/css">
a:link{text-decoration:none; color:#2b686e;}
a:visited{text-decoration:none; color:#2b686e;}
a:hover{text-decoration:none; color:#ce2f78;}
a:active{text-decoration:none; color:#2b686e;}
</style>
<!--하이퍼링크 색 없애기 , 뉴스 뒤에 테이블 깔기 -->
<script>
$(document).ready(function (){
	list();
});

function list(){
	$.ajax({
		url:'news',
		type:'post',
		dataType:'json',
		success: outnews,
		error:function(e){
			alert('뉴스가 존재하지 않습니다.');
		}
	});
}

function outnews(json){
	var str = '<table>';
		str +='<tr><td width="550px">제목</td>';
		str +='<td width="110px" text-align="center">날짜</td>';
		str +='<td width="550px">제목</td>';
		str +='<td width="110px" text-align="center">날짜</td></tr>';
		str += '<tr>';
	$.each(json, function(key,item){	
		str += '<td><a href='+item.link+' target="_blank">'+item.title+'</a></td>';
		str += '<td>'+item.pubDate+'</td>';
		str += (key%2==0? "":'</tr>');
		str += (key==json.length? '<tr>':"");
		});
	str += '</table>';
	
	$('#news').html(str);
}
</script>
</head>
<body>
<div id = "news" div style= "width:1000px; height:800px; margin:auto;"></div>

<input type="hidden" id="lng" value="${sessionScope.loginLon}"/>
<input type="hidden" id="lat" value="${sessionScope.loginLat}"/>

</body>
</html>