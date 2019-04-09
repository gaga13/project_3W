<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>뉴스</title>
<script src="<c:url value='resources/jquery/jquery-3.3.1.min.js'/>"></script>
<script>
$(document).ready(function (){
	list();
});

function list(){
	var local= "광주광역시 북구";
	$.ajax({
		url:'news',
		type:'post',
		data:{local:local},
		dataType:'json',
		success: outnews,
		error:function(e){
			alert('뉴스가 존재하지 않습니다.');
		}
	});
}

function outnews(json){
	var str = '<table>';
		str +='<tr><th>제목</th>';
		str +='<th>날짜</th></tr>';
	$.each(json, function(key,item){		
		str += '<tr>';
		str += '<th><a href='+item.link+' target="_blank">'+item.title+'</a></th>';
		str += '<td>'+item.pubDate+'</td>';
		str += '</tr>';
		});
	str += '</table>';
	
	$('#news').html(str);
}
</script>
</head>
<body>
<div id = "news"></div>
</body>
</html>