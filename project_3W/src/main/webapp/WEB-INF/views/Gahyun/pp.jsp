<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script src="resources/jquery/jquery-3.3.1.min.js"></script>
<script>
//서버에서 하루스케쥴 목록 불러오기
$(document).ready(function(){
	$('#twitterBtn').on('click', twittBtn);		
});
//트위터 인증 창
function twittBtn(){
	
	//인증된 사용자인지 체크하기
	$.ajax({
		url:'twitterTokenCheck',
		type:'get',
		dateType: 'json',
		success: function(check){
			//인증됨
			if(check){
			  
			  
			}
			//인증안됨
			else{
				window.open('twitterConnect', 'width=700,height=500'); //권한 승인 창 띄우기
			}
		},
		error: function(e) {
			alert(JSON.stringify(e));
		}
	});
	
}
</script>
<body>
<h1>일정 목록</h1>
<table>
		<tr>
			<th>번호</th>
			<th>시간</th>
			<th>제목</th>
			<th>위치</th>
			<th>노선</th>
		</tr>
	<c:forEach var="i" begin="0" end="${sessionScope.sListSize}">
		<tr id = "inputTR${i}">
		</tr>
	</c:forEach>
		<tr>
			<td>1</td>
			<td>${sessionScope.startdate}</td>
			<td>${sessionScope.scontent}</td>
			<td>${sessionScope.slocation}</td>
			<td></td>
		</tr>
</table>
<!--트윗하기 버튼  -->
<input type="button" id="twitterBtn" value="트윗하기"> 
</body>
</html>