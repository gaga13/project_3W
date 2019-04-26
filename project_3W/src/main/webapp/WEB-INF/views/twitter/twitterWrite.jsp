<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link href="resources/css/jquery.timepicker.min.css" rel="stylesheet" type="text/css">
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
      <link rel="stylesheet" href="resources/css/table.css">
		<link href='https://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'>
		<link href="resources/css/twitter.css" rel="stylesheet" type="text/css">
<title>Insert title here</title>
<style type="text/css">
 a:link { color: #565f65; text-decoration: none;}
 a:visited { color: #565f65; text-decoration: none;}
 a:hover { color: #63bef6; text-decoration: none;}
</style>
<script src="resources/jquery/jquery-3.3.1.min.js"></script>
<script>
var scheduleList = new Array();
var selectedSnum;
//이벤트 연결
$(document).ready(function(){
	//$('#tweetBtn').on('click', twittSubmit);
	$('#tweetSubmit').on('click', tweet);
	//부모창에서 값 가져오기
	selectedSnum = $('#hiddenSelectedSnum', opener.document).val();
	getScheduleList();
});
function getScheduleList(){
	//서버에서 하루스케쥴 목록 불러오기
	$.ajax({
		url:'getScheduleList',
		type: 'post',
		dataType:'json',
		success : function(sList){
			$.each(sList, function (index, item){
				if(item.snum == selectedSnum){
					var slocation = item.slocation;
					var scontent = item.scontent;
					$('#tweet').val(slocation + '에서 ' + scontent);
				}
			});
			
		},
		error : function(e){ alert(JSON.stringify(e));}
	});			
}

//트윗 폼
document.addEventListener("DOMContentLoaded", function(){
	this.querySelector("textarea").addEventListener("keydown",ctChars);
	
});

function ctChars() {
	let el = this,
		to = setTimeout(function() {
			let len = el.value.length,
				ct = document.querySelector("span"),
				btn = document.querySelector("button"),
				warnAt = 20,
				max = ct.getAttribute("data-limit");
			
			// characters left
			ct.innerHTML = max - len;
			// warn about reaching limit
			ct.className = len > max - warnAt ? "warn" : "";
			btn.disabled = len == 0 ? true : false;
			clearTimeout(to);
		}, 1);
}
function tweet(e) {
	/* let el = this,
		ta = el.querySelector("textarea");
	el.classList.add("pre-morph");
	ta.disabled = true;
	
	//bird animation
	var tl = new TimelineMax();
	tl
		.to("#b1", 0.2, {
			delay: 0.2,
			morphSVG:"#b2",
			ease: Linear.easeIn
		})
		.to("#b1", 0.25, {
			morphSVG:"#b3",
			ease: Linear.easeIn
		})
		.to("#b1", 0, {
			delay: 0.05,
			opacity: 0
		});
	
	// reset everything
	setTimeout(function(){
		let ct = el.querySelector("span"),
			btn = el.querySelector("button");

		el.classList.remove("pre-morph")
		ta.value = "";
		ta.disabled = false;
		ct.innerHTML = ct.getAttribute("data-limit");
		btn.disabled = true;
		tl.pause(0);
	}, 3000);
	
	e.preventDefault(); */
	
	//트윗
	var tweet = $('#tweet').val();
	$.ajax({
		url:'twitterWrite',
		type:'post',
		data: {tweet: tweet},
		success:function(){
			$('#twittSuccess').html('<div class="tt"><a href="https://twitter.com">트윗 확인하러 가기</a>'
					+ '<a href="#" onclick="javascript:tweetClose()" class="close">닫기</a></div>');
			
		},
		error: function(e){ alert(JSON.stringify(e));}
	}); 
}
function tweetClose(){
	window.opener.location.reload();
	self.close();
	
}
</script>
</head>
<body>


</div>

<br><br>
<div id="tweetForm">
<textarea id="tweet" name="tweet" ></textarea>
</div>
<div class="bottom">
	<span data-limit="280">280</span>
	<button type="submit" tabindex="0" abled id="tweetSubmit">
		<span tabindex="-1">Tweet</span>
	</button>
</div>
<div class="svgs">
	<svg version="1.1" xmlns="http://www.w3.org/2000/svg" x="0px" y="0px" width="540px" height="306px" viewBox="0 0 540 306" enable-background="new 0 0 540 306">
		<path id="b1" fill="#55ABEE" d="M540,189c0,4.971-4.029,9-9,9c0,0-310.125,0-413.5,0C90.375,198,9,198,9,198c-4.971,0-9-4.029-9-9
	c0,0,0-12.375,0-16.5c0-3,0-9,0-12c0-1.625,0-4.875,0-6.5s0-4.875,0-6.5c0-2.875,0-8.626,0-11.501c0-2,0-6,0-8
	C0,125.249,0,117,0,117c0-4.971,4.029-9,9-9h355h18.5H531c4.971,0,9,4.029,9,9c0,0,0,13.875,0,18.5c0,4,0,12,0,16c0,3.5,0,10.5,0,14
	C540,171.375,540,189,540,189z"/>
	</svg>
	<svg version="1.1" xmlns="http://www.w3.org/2000/svg" x="0px" y="0px" width="540px" height="306px" viewBox="0 0 540 306" enable-background="new 0 0 540 306">
		<path id="b2" fill="#55ABEE" d="M373.925,5.634c-8.719,8.862-18.389,15.302-28.671,18.77C337.035,9.381,325.302,0,312.316,0
		c-24.92,0-45.126,34.591-45.126,77.254c0,6.056,0.403,11.931,1.158,17.593c-37.507-3.225-70.762-33.978-93.023-80.708
		c-3.879,11.396-6.116,24.674-6.116,38.836c0,26.789,7.986,50.439,20.084,64.285c-7.392-0.404-14.358-3.875-20.444-9.648
		c0,0.316,0,0.647,0,0.968c0,37.424,15.561,68.646,36.21,75.763c-3.792,1.758-7.774,2.703-11.901,2.703
		c-2.905,0-5.729-0.482-8.492-1.391c5.757,30.676,22.417,53.025,42.165,53.648c-15.451,20.723-34.904,33.076-56.06,33.076
		c-3.653,0-7.23-0.373-10.772-1.084C179.982,293.209,203.717,306,229.192,306c83.023,0,128.416-117.699,128.416-219.785
		c0-3.345-0.03-6.692-0.116-9.999c8.806-10.885,16.467-24.49,22.51-39.998c-8.088,6.159-16.785,10.293-25.923,12.166
		C363.404,38.823,370.545,23.687,373.925,5.634z"/>
	</svg>
	<svg version="1.1" xmlns="http://www.w3.org/2000/svg" x="0px" y="0px" width="540px" height="306px" viewBox="0 0 540 306" enable-background="new 0 0 540 306">
		<path id="b3" fill="#55ABEE" d="M394.709,51.297c-10.461,6.115-22.064,10.561-34.402,12.953c-9.863-10.367-23.943-16.842-39.525-16.842
		c-29.902,0-54.152,23.871-54.152,53.314c0,4.18,0.483,8.235,1.39,12.145c-45.009-2.229-84.914-23.451-111.628-55.701
		c-4.655,7.867-7.339,17.027-7.339,26.803c0,18.488,9.583,34.811,24.101,44.367c-8.87-0.281-17.229-2.674-24.533-6.66
		c0,0.219,0,0.447,0,0.668c0,25.826,18.673,47.375,43.452,52.285c-4.549,1.213-9.328,1.867-14.281,1.867
		c-3.486,0-6.874-0.334-10.19-0.959c6.908,21.17,26.9,36.594,50.597,37.025c-18.541,14.301-41.885,22.826-67.271,22.826
		c-4.383,0-8.677-0.256-12.927-0.748c23.979,15.125,52.462,23.951,83.031,23.951c99.628,0,154.096-81.23,154.096-151.685
		c0-2.307-0.036-4.618-0.141-6.897c10.568-7.514,19.763-16.903,27.014-27.604c-9.705,4.25-20.143,7.104-31.107,8.396
		C382.084,74.204,390.654,63.756,394.709,51.297z"/>
	</svg>
	<svg version="1.1" xmlns="http://www.w3.org/2000/svg" x="0px" y="0px" width="264px" height="214px" viewBox="0 0 264 214" enable-background="new 0 0 264 214">
		<path id="b4-1" fill="#55ABEE" d="M264.001,26.405c-9.705,4.25-20.144,7.104-31.106,8.396c11.189-6.597,19.76-17.045,23.814-29.504
c-10.461,6.115-22.064,10.561-34.402,12.953c-9.863-10.367-23.941-16.842-39.523-16.842c-29.902,0-54.152,23.871-54.152,53.314
c0,4.18,0.483,8.235,1.39,12.145c-0.02-0.001-0.04-0.003-0.06-0.004c1.289,26.137-6.044,41.72-14.711,57.387
c-10.75,18.5-27.75,37.5-35.805,42.872c-18.419,13.956-41.469,22.267-66.515,22.267c-4.383,0-8.677-0.256-12.927-0.748
c23.979,15.125,52.462,23.951,83.031,23.951c99.628,0,154.096-81.23,154.096-151.685c0-2.307-0.036-4.618-0.142-6.897
C247.555,46.496,256.75,37.106,264.001,26.405z"/>
		<path id="b4-2" fill="#55ABEE" d="M54.073,128.629c-4.549,1.213-9.328,1.867-14.281,1.867c-3.486,0-6.874-0.334-10.19-0.959
			c6.908,21.17,26.9,36.594,50.597,37.025c-0.108,0.083-0.221,0.16-0.329,0.243c1.245,0.027,2.477,0.117,3.696,0.376
			c8.178-0.742,16.029-1.338,23.741-4.563c5.559-2.325,11.182-5.499,15.883-9.283c10.015-8.062,18.012-18.157,23.113-30.003
			c8.144-18.915,11.361-53.553-16.355-56.82c0.027,0.118,0.045,0.238,0.072,0.356C85.011,64.639,45.106,43.417,18.392,11.167
			c-4.655,7.867-7.339,17.027-7.339,26.803c0,18.488,9.583,34.811,24.101,44.367c-8.87-0.281-17.229-2.674-24.533-6.66v0.668
			C10.621,102.17,29.294,123.719,54.073,128.629z"/>
	</svg>
</div>
</div>

<div id="twittSuccess" class="twittSuccess"></div>

</body>
</html>