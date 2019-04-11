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
	locationSave();
});

function logCheck(){
	var email = $('#email').val();
	var pw = $('#password').val();
	
	if(email.length < 3 || email.length > 25){	//var id의 길이 값을 확인
		alert('Email 입력하시오.');				//alert 창 띄우기
		return;									//함수 종료
	}
	if(pw.length < 3 ){							//var pw의 길이 값을 확인
		alert('비밀번호는 3글자 이상입니다.');			//alert 창 띄우기
		return;									//함수 종료
	}
	
	//회원인지 아닌지 확인하기
	$.ajax({
		url:'loginCheck',
		type: 'get',
		data: {email: email, password: pw},
		dataType: 'json',
		success: function(check){
			if(check){      
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

function locationSave(){
	// Geolocation API에 액세스할 수 있는지를 확인
    if (navigator.geolocation) {
    	//위치 정보를 얻기
        navigator.geolocation.getCurrentPosition (function(pos) {
        	const lon = pos.coords.longitude;
        	const lat = pos.coords.latitude;
        	
        	$.ajax({
				//url : 어디로 갈지. controller의 경로와 맞아야함. 상대경로로 중간에 ../ 등의 경로가 추가될 수도 있음.
				url: 'loginLocation',
				//type : 요청을 get방식으로 보낼 것인가, post방식으로 보낼 것인가.
				type: 'post',
				data: {lat : pos.coords.latitude, lon : pos.coords.longitude},
				//dataType : 데이터를 가져올 때 어떤 타입으로 가져올지. 보통 text 아니면 json이 들어간다.
				dataType: 'text',
				//요청 성공시 어떻게 할 것인지. 방법 1: 다른 함수로 보내기. 뒤에 ()붙이면 안됨. ()붙이는 것은 그 함수를 지금 이 자리에서 실행한다는 뜻이므로.
				success: function(){
					
				},
				//요청 실패시 어떻게 할 것인가. 방법 2: 안에 함수 넣어버리기(추가할 내용이 짧을 때 유용).
				error: function (e) {
					//에러 발생시 에러 내용을 문자열로 출력하는 명령어.
					alert(JSON.stringify(e));
					alert("현재위치 session 저장 실패");
				}
			});
        });
    } 
    else {
        alert("이 브라우저에서는 Geolocation이 지원되지 않습니다.")
    }
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