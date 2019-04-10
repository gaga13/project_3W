<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
    
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
							<input type="text" name="" class="form-control input_user" value="" placeholder="email@domain.com">
						</div>
						<div class="input-group mb-2">
							<div class="input-group-append">
								<span class="input-group-text"><i class="fas fa-key"></i></span>
							</div>
							<input type="password" name="" class="form-control input_pass" value="" placeholder="password">
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
					<button type="button" name="button" class="btn login_btn">Login</button>
				</div>
				<div class="d-flex justify-content-center mt-3 login_container">
					<button type="button" name="button" class="btn login_btn">Sign Up</button>
				</div>
				<div class="mt-4">
				</div>
			</div>
		</div>
	</div>
	 <script src="resources/js/login_script.js"></script>
	 
	
</body>