<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원정보 수정</title>

<script type="text/javascript" src="resources/js/jquery-3.3.1.min.js" charset="utf-8"></script>
<script>

	var sel_file;
	
	$(document).ready(function(){
		$("#input_img").on("change",handleImgFileSelect);
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


$(document).ready(function(){
	$('#updateBts').on('click', updateCheck);
});

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


</script>

</head>
<body>

<h1>회원정보 관리</h1>
<form method="post" action="update" id="update" enctype="multipart/form-data" >
<input type="hidden" value="${member.email}" name="email" id="email">
<table border="1">

	<tr>
		<td>
		
		</td>
		
		<td>
				<div class="img_wrap">
					<img id="img" width="130" height="auto" />
				</div>
				
				<div>
				<p class="title"></p>
				<input type="file" id="input_img" name="profile_photo">
				</div>
		
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
			Instagram
		</td>
	</tr>
	
</table>
<br>
<input type="button" id="updateBts" value="수정">

</form>

</body>
</html>