<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<h1>회원가입</h1>

<form method="post" action="join" id="joinForm">
<table class="border">
	<tr>
		<td>Email</td>
		<td><input type="text" name="email" id="email"></td>
	</tr>

	<tr>
		<td>비밀번호</td>
		<td><input type="password" name="password" id="password"></td>
	</tr>
	
	<tr>
		<td>본인확인여부</td>
		<td><input type="button" value="본인확인여부"></td>
	</tr>
	
	<tr>
		<td><input type="submit" value="가입하기"></td>
	</tr>
	</table>
</form>

</body>
</html>