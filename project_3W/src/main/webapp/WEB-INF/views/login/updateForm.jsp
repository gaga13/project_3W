<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="resources/css/profileupdate.css" rel="stylesheet">
<title>회원정보 수정</title>

<script src="resources/jquery/jquery-3.3.1.min.js"></script>
<script>

$(document).ready(function() {
	//트위터 계정 연결 버튼
	$('#twitterConnectBtn').on('click', twitterConnect);
	$('#twitterDisconnectBtn').on('click', twitterDisconnect);
	$('#backhome').on('click',back);

});

function back(){
	location.href="home";
}

//트위터 계정 연결
function twitterConnect() {
	//트위터 
	window.open('twitterConnect', '', 'width=700,height=500');
	//시간지나면 꺼지게하기
}
//트위터 계정 연결 해제
function twitterDisconnect() {
	$.ajax({
		url : 'twitterDisconnect',
		type : 'get',
		success : function() {
			alert('해재됨');
		},
		error : function(e) {
			alert(JSON.stringify(e));
		}
	});
}

	function updateCheck() {
	    var pw = $('#password');
	    var pw2 = $('#password2');
	    var username = $('#username');
	    var userbirthdate = $('#userbirthdate');
	    
	    if (username.val() == '') {
	        alert('이름을 입력해 주세요.');
	        username.select();
	        username.focus();
	        return false;
	    }
	    
	    if (userbirthdate.val() == '') {
	        alert('생일을 입력해 주세요.');
	        userbirthdate.focus();
	        return false;
	    }
	    
	    if(pw.val() != ''){
	  	  if(pw2.val() == ''){
	        alert('확인용 비밀번호를 입력해 주세요.');
	        pw2.select();
	        pw2.focus();
	        return false;
	    	}
	  		
	  	  	if (pw.val() != pw2.val()) {
	        	alert('비밀번호를 확인해 주세요.');
	        	pw.select();
	        	pw2.focus();
	        	return false;
	    	}
	    
	   	 }
	    
	    
	    return true;
}
</script>
<style>
.button_1{position:relative; left:-280px; bottom:-150px;}
.button_2{position:relative; left:180px; bottom:-100px;}

</style>


</head>
<body>

	<div class="profileoutline" style="height: auto; width: 500px; height:600px; border:3px solid black; padding-left:90px; padding-top:70px;">
			<img class="img-fluid img-profile rounded-circle mx-auto mb-2"
				src="resources/img/head.png" width="150px;" height="150;" style="position:relative; left:-50px;">
			<h1 style="position:relative; left:-50px;">회원 정보</h1>
			<form method="post" action="update" id="update"
				enctype="multipart/form-data" onsubmit="return updateCheck()">
				<input type="hidden" value="${member.email}" name="email" id="email">
					<table >
						<tr>
							<td></td>
						</tr>
						<tr>
							<td>이름</td>
							<td><input type="text" name="username" id="username"
								value="${member.username}" /></td>
						</tr>
						<tr>
							<td>생년월일</td>
							<td><input type="date"
								name="userbirthdate" id="userbirthdate"
								value="${member.userbirthdate}" />
							</td>
						</tr>
						<tr>
							<td>이메일 주소</td>
							<td>${sessionScope.loginId}</td>
						</tr>
						<tr>
							<td>새 비밀번호</td>
							<td><input type="password" id="password" name="password">
							</td>
						</tr>
						<tr>
							<td>비밀번호 확인</td>
							<td><input type="password" id="password2"></td>
						</tr>
						<tr>
							<td>SNS계정${member.twitterId}</td>
							<td><img src="./resources/img/twitter.png" width="20px" height="18px">
							 <c:choose>
									<c:when test="${member.twitterId eq 'N' }">
										<input type="button" id="twitterConnectBtn" value="계정 연결">
									</c:when>
									<c:otherwise>
										<input type="button" id="twitterDisconnectBtn" value="연결 해제">
									</c:otherwise>
								</c:choose></td>
						</tr>
					</table>
					
					<div class="button_1">
						<button type="button" id="backhome" style="background-color:#F2F2F2; border:0px">
						<img src="resources/img/return.png" width="50" height="50"> 
						</button>
					</div>
					
					<div class="button_2">
						<button type="submit" id="update" style="background-color:#F2F2F2; border:0px">
						<img src="resources/img/arrows.png" width="50" height="50">
						</button>
					</div>
				</form>
	</div>
</body>
</html>