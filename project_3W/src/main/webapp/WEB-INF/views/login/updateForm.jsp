<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="resources/css/profileupdate.css" rel="stylesheet">
<title>회원정보 수정</title>

<script src="resources/jquery/jquery-3.3.1.min.js"></script>
<script>

	var sel_file;
	
$(document).ready(function(){
		$("#input_img").on("change",handleImgFileSelect);
		$('#updateBts').on('click', updateCheck);
		//트위터 계정 연결 버튼
		$('#twitterConnectBtn').on('click', twitterConnect);
		$('#twitterDisconnectBtn').on('click', twitterDisconnect);
		
});
	
function handleImgFileSelect(e){
	var files = e.target.files;
	var filesArr = Array.prototype.slice.call(files);
	
	filesArr.forEach(function(f){
		if(!f.type.match("image.*")){
			alert("이미지 파일만 올려주세요.");
			return;
		}
		
		sel_file = f;
		
		var reader = new FileReader();
		reader.onload = function(e){
			$("#img").attr("src", e.target.result);
		}
		reader.readAsDataURL(f);
	});
}
/////////////////////////////////////////////////// 위는 사진 아래는 수정


function updateCheck(){
	var pw = $('#password').val();
	var pw2 = $('#password2').val();
	var email = $('#email').val();
	var username = $('#username').val();
	var userbirthdate = $('#userbirthdate').val();
	var Savedfile = $('#input_img').val();

if(pw != pw2){
		alert('비밀번호가 일치하지 않습니다.');
		return;
	}
	
	   $.ajax({
		      url: 'update',
		      type: 'post',
		      data: {
		    	  email : email
		    	  , password: pw
		    	  , username : username
		    	  , userbirthdate : userbirthdate
		    	  , Savedfile : Savedfile
		      },
		      success: function(){
		         location.href="./";
		      },
		      error: function(){
		         alert('실패');
		      }     
		   });
}

//트위터 계정 연결
function twitterConnect(){
	//트위터 
	window.open('twitterConnect', '', 'width=700,height=500');
	//시간지나면 꺼지게하기
	
}
//트위터 계정 연결 해제
function twitterDisconnect(){
	$.ajax({
		url: 'twitterDisconnect',
		type: 'get',
		success: function(){alert('해재됨');},
		error: function(e){ alert(JSON.stringify(e)); }
	});
}

</script>

</head>
<body>



<table>

	
			
		

<div class="profile-text">
			<h1 class="profile-name">회원 정보</h1>
		
					<div class="img_wrap">
						<img id="img" width="130" height="auto" />
					</div>
					
					<div>
					<p class="title"></p>
					<input type="file" id="input_img" name="profile_photo">
					</div>
	
	<form method="post" action="update" id="update" enctype="multipart/form-data" >
	<input type="hidden" value="${member.email}" name="email" id="email">



<div class="profile-title">

	<table >
	
		<tr>
			<td>
			
			</td>
			
		</tr>
	 
		<tr>
			<td>
				이름
			</td>
			<td>
				<input type="text" name="username" id="username" value="${member.username}"/>
			</td>
		</tr>
	
		<tr>
			<td>
				생년월일 [공개/비공개]
			</td>
			<td>
				${member.userbirthdate}
				<input type = "date" name="userbirthdate" id="userbirthdate" value="${member.userbirthdate}"/>
			</td>
		</tr>
		
		<tr>
			<td>
				이메일 주소
			</td>
			<td>
				${sessionScope.loginId}
			</td>
		</tr>
		
		<tr>
			<td>
				새 비밀번호를 입력하세요
			</td>
			<td>
				<input type="password" id="password" name="password">
			</td>
		</tr>
		
		<tr>
			<td>
				비밀번호 확인
			</td>
			<td>
				<input type="password" id="password2">
			</td>
		</tr>
		
		<tr>
			<td>SNS계정</td>
			<td>
				<img src="./resources/img/twitter.png" width="20px" height="18px">
				<c:choose>
					<c:when test="${member.twitterId eq 'N' }">
						<input type="button" id="twitterConnectBtn" value="계정 연결">
					</c:when>
					<c:otherwise>
						<input type="button" id="twitterDisconnectBtn" value="연결 해제">
					</c:otherwise>
				</c:choose>
				
			</td>
		</tr>
		
	</table>
</div>

</div>
	<br>
	<input type="button" id="updateBts" value="수정">

</form>

</table>


</body>
</html>