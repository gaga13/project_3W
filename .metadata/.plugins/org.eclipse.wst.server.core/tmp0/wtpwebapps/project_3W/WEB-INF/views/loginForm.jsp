<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script src="resources/js/jquery-3.3.1.min.js"></script>
<script>
$(function(){
	$('#logBts').on('click',logCheck);
})

function logCheck(){
	var email = $('#email').val();
	var pw = $('#password').val();
	
	if(email.length < 3 || email.length > 25){	//var id의 길이 값을 확인
		alert('Email 입력하시오.');				//alert 창 띄우기
		return;								//함수 종료
	}
	if(pw.length < 3 || pw.length > 10){	//var pw의 길이 값을 확인
		alert('비밀번호 입력하시오.');				//alert 창 띄우기
		return;								//함수 종료
	}
	$('#logForm').submit();					//form의 아이디 값이 logForm인 것을 submit시킨다.
}

</script>

</head>
<body>

<h1>로그인</h1>

<form method="post" action="login" id="logForm">
<table>
	<tr>
		<td>
			Email
		</td>
		<td>
			<input type="text" name="email" id="email">
		</td>
	</tr>
	
	<tr>
		<td>
			Password
		</td>
		<td>
			<input type="password" name="password" id="password">
		</td>
	</tr>
	<tr>
		<td colspan="2" class="center">
			<input type="button" id="logBts" value="login">
		</td>
	</tr>
</table>
</form>

</body>
</html>