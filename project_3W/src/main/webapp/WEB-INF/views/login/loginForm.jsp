<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script src="resources/jquery/jquery-3.3.1.min.js"></script>
<script>
$(document).ready(function(){
	$('#logBts').on('click',logCheck);
});

function logCheck(){
	var email = $('#email').val();
	var pw = $('#password').val();
	
	if(email.length < 3 || email.length > 25){	//var id의 길이 값을 확인
		alert('Email 입력하시오.');				//alert 창 띄우기
		return;								//함수 종료
	}
	
	if(pw.length < 3 ){	//var pw의 길이 값을 확인
		alert('비밀번호는 3글자 이상입니다.');				//alert 창 띄우기
		return;								//함수 종료
	}
	
	//회원인지 아닌지 확인하기
	$.ajax({
		url:'loginCheck',
		type: 'get',
		data: {email: email, password: pw},
		dataType: 'json',
		success: function(check){
			if(check == "true"){
				//아이디랑 비밀번호 일치하는 경우 form의 아이디 값이 logForm인 것을 submit시킨다.
				$('#logForm').submit();	
			}
			else{
				alert('등록된 이메일 주소와 비밀번호가 일치하지 않습니다.');
				$('#email').val('');
				$('#password').val('');
				$('#email').focus();
			}
		},
		error: function(e){
			alert(JSON.stringify(e));
		}
	});
	
					
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