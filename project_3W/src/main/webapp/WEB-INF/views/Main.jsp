<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<script src="resources/jquery/jquery-3.3.1.min.js"></script>
<script>
var lon;
var lat;
var loca;

$(document).ready(function(){
	$('#loginBts').on('click',logCheck);
	$('#joinBts').on('click',joinCheck);
	locationSave();
});
//로그인 시 회원체크
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
	
	//로그인시 - 회원인지 아닌지 확인하기
	$.ajax({
		url:'loginCheck',
		type: 'get',
		data: {email: email, password: pw},
		dataType: 'text',
		success: function(check){
			if(check == 'true'){
				//아이디랑 비밀번호 일치하는 경우 home화면으로 이동
				window.location.replace('home');
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
//회원가입 버튼 눌렀을 때, 회원정보 확인
function joinCheck(){
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
	
	//회원가입시 - 회원인지 아닌지 확인하기
	$.ajax({
		url:'joinCheck',
		type: 'get',
		data: {email: email, password: pw},
		dataType: 'text',
		success: function(emailCheck){
			//email이 중복되지 않아회원가입 가능
			if(emailCheck == 'no'){
				//회원가입 성공 후  '본인인증' 창 띄우기
				document.getElementById("joinImage").style.visibility='visible';
				setTimeout(function (){document.getElementById("joinImage").style.visibility='hidden'},3000);
				$('#email').val('');
				$('#password').val('');
				$('#email').focus();
			}
			//입력한 email이 이미 존재함
			else{
				alert('이미 등록된 이메일 입니다.');
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
//아이디 기억하기
$(document).ready(function(){
 
    // 저장된 쿠키값을 가져와서 ID 칸에 넣어준다. 없으면 공백으로 들어감.
    var key = getCookie("key");
    $('#email').val(key); 
     
    if($('#email').val() != ""){ // 그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
        $('#customControlInline').attr('checked', true); // ID 저장하기를 체크 상태로 두기.
    }
     
    $('#customControlInline').change(function(){ // 체크박스에 변화가 있다면,
        if($('#customControlInline').is(':checked')){ // ID 저장하기 체크했을 때,
            setCookie('key', $('#email').val(), 7); // 7일 동안 쿠키 보관
        }else{ // ID 저장하기 체크 해제 시,
            deleteCookie('key');
        }
    });
     
    // ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
    $('#email').keyup(function(){ 				// ID 입력 칸에 ID를 입력할 때,
        if($('#customControlInline').is(':checked')){ // ID 저장하기를 체크한 상태라면,
            setCookie('key', $('#email').val(), 7); // 7일 동안 쿠키 보관
        }
    });
});

function setCookie(cookieName, value, exdays){
    var exdate = new Date();
    exdate.setDate(exdate.getDate() + exdays);
    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
    document.cookie = cookieName + "=" + cookieValue;
}
 
function deleteCookie(cookieName){
    var expireDate = new Date();
    expireDate.setDate(expireDate.getDate() - 1);
    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
}
 
function getCookie(cookieName) {
    cookieName = cookieName + '=';
    var cookieData = document.cookie;
    var start = cookieData.indexOf(cookieName);
    var cookieValue = '';
    if(start != -1){
        start += cookieName.length;
        var end = cookieData.indexOf(';', start);
        if(end == -1)end = cookieData.length;
        cookieValue = cookieData.substring(start, end);
    }
    return unescape(cookieValue);
}

function locationSave(){
	// Geolocation API에 액세스할 수 있는지를 확인
    if (navigator.geolocation) {
    	//위치 정보를 얻기
        navigator.geolocation.getCurrentPosition (function(pos) {
        	lon = pos.coords.longitude;
        	lat = pos.coords.latitude;
        	$.ajax({
				//url : 어디로 갈지. controller의 경로와 맞아야함. 상대경로로 중간에 ../ 등의 경로가 추가될 수도 있음.
				url: 'loginLocation',
				//type : 요청을 get방식으로 보낼 것인가, post방식으로 보낼 것인가.
				type: 'post',
				data: {lat : pos.coords.latitude, lon : pos.coords.longitude},
				//dataType : 데이터를 가져올 때 어떤 타입으로 가져올지. 보통 text 아니면 json이 들어간다.
				dataType: 'text',
				//요청 성공시 어떻게 할 것인지. 방법 1: 다른 함수로 보내기. 뒤에 ()붙이면 안됨. ()붙이는 것은 그 함수를 지금 이 자리에서 실행한다는 뜻이므로.
				success: reverseGeoCording,
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

function reverseGeoCording(){
	var latlng = "https://maps.googleapis.com/maps/api/geocode/xml?latlng=" + lat + "," + lon + "&language=ko&sensor=false&key=AIzaSyDBLJ3URwB6HcAHqAJiwwOOqgqwUe2Hu0M"
			
	$.ajax({
		url: latlng,
		type: "POST",
		success: XMLParsing,
		error: function(e){
			alert(json.stringify(e));
		}
	});
}

function XMLParsing(xml){
	var xmlDoc = xml.getElementsByTagName("formatted_address");	
	loca = xmlDoc[4].childNodes[0].nodeValue;
	$.ajax({
		url: 'reverseGeoCording',
		type: 'post',
		data: {loca : loca},
		dataType: 'text',
		success: function(){
		},
		error: function (e) {
			alert(JSON.stringify(e));
			alert("현재위치에 따른 주소명 session 저장 실패");
		}
	});
}
</script> 
      
<head>
	<title>Login Page</title>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.1/css/all.css" integrity="sha384-gfdkjb5BdAXd+lj+gudLWI+BXq4IuLW5IT+brZEZsLFm++aCMlF1V92rMkPaX4PP" crossorigin="anonymous">
	<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
	<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<link href="resources/css/Login.css" rel="stylesheet">
	<link href="resources/css/character.css" rel="stylesheet">
</head>

<body>
	
	<!-- 회원가입 완료 했을 때 완료했다는 알림 뜨는 곳 -->
	<a id="joinImage" style="visibility: hidden; position:absolute; top:180px; left:1000px;" ><img src="resources/img/joinImage.png"/></a>
	
	<div class="container h-100">
		<div class="d-flex justify-content-center h-100">
			<div class="user_card">
				<div class="d-flex justify-content-center">
					<div class="brand_logo_container">
					<!-- 캐릭터 컨트롤 소스 -->
						<!-- <img src="resources/img/head.png" class="brand_logo" alt="Logo"> -->
						<!-- 캐릭터 배경 -->
						 <svg id="cha" viewBox="0 0 250 250" xmlns="http://www.w3.org/2000/svg">
            <!-- 얼굴 cx,cy=얼굴 위치  r= 얼굴 크기-->
            <circle cx="125" cy="125" r="120" fill="#f8ea8a" stroke="#f8ea8a" stroke-width="2.5" />
            <g class="eyes">
                <!-- left eye and eyebrow-->
                <circle cx="94" cy="110" r="9" fill="#000" />
                <!-- right eye and eyebrow -->
                <circle cx="146" cy="110" r="9" fill="#000" />
            </g>
            <!-- 입코 -->
            <g class="muzzle">
               <!--  <path d="M60,66 C58.5,61 49,63 49,69 C49,75 58,77 60,71 M60,66 C61.5,61 71,63 71,69 C71,75 62,77 60,71" fill="#fff" />
                <path d="M60,66 C58.5,61 49,63 49,69 C49,75 58,77 60,71 M60,66 C61.5,61 71,63 71,69 C71,75 62,77 60,71" fill="#fff" stroke="#000" stroke-width="2.5" stroke-linejoin="round" stroke-linecap="round" /> -->
                <polygon points="119,123.5,120,123.4,121,123.5,120,125" fill="#a22525" stroke="#a22525" stroke-width="15"  />
            </g>
        </svg>
        <!-- 캐릭터 컨트롤 svg끝 -->
       
        
					</div>
				</div>
				<div class="d-flex justify-content-center form_container">
					<form>
					<!-- 로그인 폼 -->
						<div class="input-group mb-3">
							<div class="input-group-append">
								<span class="input-group-text"><i class="fas fa-user"></i></span>
							</div>
							<input type="text" name="email" id="email" class="form-control input_user" value="" placeholder="email@domain.com">
						</div>
						<div class="input-group mb-2">
							<div class="input-group-append">
								<span class="input-group-text"><i class="fas fa-key"></i></span>
							</div>
							<input type="password" name="password" id="password" class="form-control input_pass" value="" placeholder="password">
						</div>
						<div class="form-group">
							<div class="custom-control custom-checkbox">
								<input type="checkbox" class="custom-control-input" id="customControlInline">
								<label class="custom-control-label" for="customControlInline">Remember me</label>
							</div>
						</div>
					</form>
				</div>
				<div class="d-flex justify-content-center mt-3 login_container">
					<button type="button" name="button" id="loginBts" class="btn login_btn">Login</button>
				</div>
				<div class="d-flex justify-content-center mt-3 login_container">
					<button type="button" name="button" id="joinBts" class="btn login_btn">Sign Up</button>
				</div>
				<div class="mt-4">
				</div>
			</div>
		</div>
	</div>
	 <script src="resources/js/login_script.js"></script>
	 
	
</body>