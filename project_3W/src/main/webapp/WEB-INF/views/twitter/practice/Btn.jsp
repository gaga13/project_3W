<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="resources/jquery/jquery-3.3.1.min.js"></script>
<script>
function twittBtn(){

	//트위터 계정 연결 여부 확인
	$.ajax({
		url:'twitterTokenCheck',
		type:'get',
		dataType: 'json',
		success: function(check){
			if(check){
				//연결되어있음, session에 accessToken 담겨있음
				//트위터 글쓰기 창 띄우기
				window.open('twitterWrite','','width=700,height=500');
			}
			else{
				//트위터 인증 창
				alert(check);
				window.open('twitterConnect', '', 'width=700,height=500');
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
<a href="javascript:twittBtn()"><img src="./resources/img/twitterLogo2.PNG"></a>
</body>
</html>