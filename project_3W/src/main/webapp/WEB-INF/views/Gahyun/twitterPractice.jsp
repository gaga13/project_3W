<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="resources/jquery/jquery-3.3.1.min.js"></script>
<script>
//이벤트 연결
$(document).ready(function(){
	$('#twittBtn').on('click', twittSubmit);
});

function twittSubmit(){
	var twitt = $('#twitt').val();
	
	$.ajax({
		url:'twitterWrite',
		type:'post',
		data: {twitt : twitt},
		success:function(){
			//this.close();  //현재 창닫기
			alert('성공');
		},
		error: function(e){ alert(JSON.stringify(e));}
	});
}
</script>
</head>
<body>




<!--트윗할 내용 보내기  -->

<textarea id="twitt" name="twitt" rows="10"></textarea>
<input type="button" value="트윗하기" id="twittBtn">


</body>
</html>