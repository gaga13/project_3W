<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
	<title>Home</title>
<link href="<c:url value='resources/css/jquery-ui.css'/>" rel="stylesheet" type="text/css">
<link href="<c:url value='resources/css/jquery.timepicker.min.css'/>" rel="stylesheet" type="text/css">
<script src="<c:url value='resources/jquery/jquery-3.3.1.min.js'/>"></script>
<script src="<c:url value='resources/jquery/jquery-ui.min.js'/>"></script>
<script src="<c:url value='resources/jquery/jquery.timepicker.min.js'/>"></script>
<script src="<c:url value='resources/jquery/bootstrap.min.js'/>"></script>
<script src="<c:url value='resources/jquery/datepicker-ko-KR.js'/>"></script>

<meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>WWW에 오신것을 환영합니다</title>

  <!-- Bootstrap core CSS -->
  <link href="resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

  <!-- Custom fonts for this template -->
  <link href="https://fonts.googleapis.com/css?family=Saira+Extra+Condensed:500,700" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css?family=Muli:400,400i,800,800i" rel="stylesheet">
  <link href="resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">

  <!-- Custom styles for this template -->
  <link href="resources/css/resume.min.css" rel="stylesheet">

<link href="<c:url value='resources/css/bootstrap.min.css'/>" rel="stylesheet" type="text/css">
<script>
$(document).ready(function(){
	
	pickTime();
	
	//시작시간에 따른 종료시간 제한
	$('#insertModal #instarttime').on('changeTime',{modal:$('#insertModal')},sted);
	$('#updateModal #setstarttime').on('changeTime',{modal:$('#updateModal')},sted);
	
	//날짜 변화에 따른 시간제한, 같은 날짜일시 종료시간을 변경
	$('#insertModal #instartdate').on('change',{modal:$('#insertModal')},sted);
	$('#insertModal #inenddate').on('change',{modal:$('#insertModal')},sted);
	$('#updateModal #setstartdate').on('change',{modal:$('#updateModal')},sted);
	$('#updateModal #setenddate').on('change',{modal:$('#updateModal')},sted);
	
	//일정 입력
	$('#insertModal #btin').on('click', insert_schedule);
	//일정 수정
	$('#updateModal #btup').on('click', update_schedule);
	//일정 삭제
	$('#updateModal #btde').on('click', delete_schedule);
	$('#insertModal #inlocation').hide();
	$('#insertModal #inmap').on('click', function(){$('#insertModal #inlocation').show();});
});

//날짜 및 시간
function pickTime(){

	//입력
	$('#insertModal #inendtime').timepicker({
		  'disableTextInput': true,
	 	  'timeFormat': 'a h:i'  
	});
	$('#insertModal #instarttime').timepicker({
		  'disableTextInput': true,
		  'maxTime': '오후 10:30',
	  	  'timeFormat': 'a h:i'  
	}); 
	
	  $('#insertModal #instartdate').attr('readonly',true);
	  $('#insertModal #instartdate').datepicker({
	    	dateFormat: "yy-mm-dd",	
	    	 firstDay: 0 
	    });
	  
	  $('#insertModal #inenddate').attr('readonly',true);
	  $('#insertModal #inenddate').datepicker({
		  dateFormat: "yy-mm-dd",
	    	firstDay: 0 
	    });
	  
	  //업데이트
		$('#updateModal #setendtime').timepicker({
			  'disableTextInput': true,
		 	  'timeFormat': 'a h:i'  
		});
		$('#updateModal #setstarttime').timepicker({
			  'disableTextInput': true,
			  'maxTime': '오후 10:30',
		  	  'timeFormat': 'a h:i'  
		}); 
		
		  $('#updateModal #setstartdate').attr('readonly',true);
		  $('#updateModal #setstartdate').datepicker({
		    	dateFormat: "yy-mm-dd",	
		    	 firstDay: 0 
		    });
		  
		  $('#updateModal #setenddate').attr('readonly',true);
		  $('#updateModal #setenddate').datepicker({
			  dateFormat: "yy-mm-dd",
		    	firstDay: 0
		    });
	  
}


//시간 제한
function sted(info){
	var ModalId = "#"+info.data.modal[0].id;
	
	if(ModalId == "#insertModal"){
		var stDate = $(ModalId+" #instartdate").val();
		var edDate = $(ModalId+" #inenddate").val();
		var stTime = $(ModalId+" #instarttime");
		var edTime = $(ModalId+" #inendtime");
	}else if(ModalId == "#updateModal"){
		var stDate = $(ModalId+" #setstartdate").val();
		var edDate = $(ModalId+" #setenddate").val();
		var stTime = $(ModalId+" #setstarttime");
		var edTime = $(ModalId+" #setendtime");		
	}
	
	// 같은 날짜인지 확인
	if(stDate == edDate){

	var sta = stTime.get(0).value.split(" ");
	var eta = edTime.get(0).value.split(" ");
	
	if(sta[0]!=""){
	var getSTime = sta[1].split(":");
	
	var hours = parseInt(getSTime[0])+1; 
	
	if(sta[0]=='오전'){
		if(hours == 13){
			hours=1;
		}else if(hours == 12){
			sta[0]='오후'
		}
	}
	
	var newTime = sta[0]+hours+":"+getSTime[1]; //시간 1시간 세팅
	}
	if(eta[0]!=""){ //종료시간이 있을시
		var getETime = eta[1].split(":");
	
			if(sta[0]=='오전'){
				if(sta[0] == eta[0]){
					if(hours != 1){
						if(getSTime[0]>=getETime[0]){
							$(edTime).val(newTime);
						}
					}
				}
		
			}
	
		if(sta[0]=='오후'){
			if(sta[0]==eta[0]){
				if(hours != 1){
					if(getSTime[0]>=getETime[0]){
						$(edTime).val(newTime);
					}else if(getETime[0]== 12){
						$(edTime).val(newTime);
					}
				}
		
			}else{
				$(edTime).val(newTime);
		 	}
		}

		if(eta[0]=='오전'){
			if(eta[1].substring(0,2)=='12'){
				$(edTime).val(newTime);
			}
		}
	}
	
	$(edTime).timepicker('remove');
	$(edTime).timepicker({
		'minTime': newTime,
		'maxTime': '오후 11:30', 
		'disableTextInput': true,
		  'timeFormat': 'a h:i'
		});
	}else{
		$(edTime).timepicker('remove');
		 
		$(edTime).timepicker({
			  'disableTextInput': true,
		 	  'timeFormat': 'a h:i'  
		});
	}
	
}


//일정 등록용
function insert_schedule(){
	var title = $('#insertModal #inscontent').val();
	var isd = $('#insertModal #instartdate').val();
	var ied = $('#insertModal #inenddate').val();
	var iti = $('#insertModal #instarttime').val();
	var ime = $('#insertModal #inendtime').val();
	
	if(title ==""){
		alert("제목을 입력해 주세요.");
		$('#insertModal  #inscontent').focus();
		$('#insertModal  #inscontent').select();
		return false;
	}

	if(title.length>20){
		alert("제목은 20자 이내로 입력해주세요.");		
		$('#insertModal  #inscontent').focus();
		$('#insertModal  #inscontent').select();
		return false;
	}
	if(isd==""){
		alert("시작일을 설정해 주세요.");
		$('#insertModal  #instartdate').focus();
		$('#insertModal  #instartdate').select();
		return false;
	}
	
	if(ied==""){
		alert("종료일을 설정해 주세요.");
		$('#insertModal  #inenddate').focus();
		$('#insertModal  #inenddate').select();
		return false;
	}
	
	if(iti==""){
		alert("시작시간을 설정해 주세요.");
		$('#insertModal  #instarttime').focus();
		$('#insertModal  #instarttime').select();
		return false;
	}
	
	if(ime==""){
		alert("종료시간을 설정해 주세요.");
		$('#insertModal  #inendtime').focus();
		$('#insertModal  #inendtime').select();
		return false;
	}
	
	if(isd>ied){
		alert('종료일을 시작일보다 늦은 날짜로 입력해주세요.');
		return false;
	}
	
	if(confirm('일정을 등록하시겠습니까?')){
		$.ajax({
			url:'inSchedule',
			type:'post',
			data:$('#insertModal #insert').serialize(),
			success:function(){
				alert('일정 입력 성공!');
				location.reload();
			},
			error:function(){
				alert('일정 입력 실패!');
			}
		});
	}
}

//일정 수정용
function update_schedule(){
	var title = $('#updateModal #setscontent').val();
	var isd = $('#updateModal #setstartdate').val();
	var ied = $('#updateModal #setenddate').val();
	
	if(title ==""){
		alert("제목을 입력해 주세요.");
		$('#updateModal  #setscontent').focus();
		$('#updateModal  #setscontent').select();
		return false;
	}

	if(title.length>20){
		alert("제목은 20자 이내로 입력해주세요.");		
		$('#updateModal  #setscontent').focus();
		$('#updateModal  #setscontent').select();
		return false;
	}
	
	if(isd>ied){
		alert('종료일을 시작일보다 늦은 날짜로 입력해주세요.');
		return false;
	}
	
	if(confirm('일정을 수정하시겠습니까?')){
		$.ajax({
			url:'setSchedule',
			type:'post',
			data:$('#updateModal #update').serialize(),
			success:function(){
				alert('일정 수정 성공!');
				location.reload();
			},
			error:function(){
				alert('일정 입력 실패!');
			}
		});
	}
}

//일정 삭제용
function delete_schedule(){
	var email = $('#updateModal #setemail').val();
	var num = $('#updateModal #setnum').val();
	
	if(confirm('일정을 삭제하시겠습니까?')){
		$.ajax({
			url:'deSchedule',
			type:'post',
			data:{email:email, num:num},
			success:function(){
				alert('일정 삭제 성공!');
				location.reload();
			},
			error:function(){
				alert('일정 삭제 실패!');
			}
		});
	}
}

//검색값 map_Search로 보내기
function submitToWindow(){
	
	//자식창에서 location reload
	var search = $('#inslocation').val();
	slocationMap.search(search);

}
</script>
</head>

<body id="page-top">

  <nav class="navbar navbar-expand-lg navbar-dark bg-primary fixed-top" id="sideNav">
    <a class="navbar-brand js-scroll-trigger" href="#page-top">
      <span class="d-block d-lg-none">3W에 오신 것을 환영합니다 </span>
      <span class="d-none d-lg-block">
      
      <!-- 홈으로 돌아가기 -->
      <a href="hom">홈으로</a>
      <!-- 프로필 이미지 들어가는 공간 -->
	</a>
	<a href="profile">
	<img class="img-fluid img-profile rounded-circle mx-auto mb-2" src="resources/img/profil.png" alt="">
	</a>

     </span>
    </a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
   
     <ul class="navbar-nav">
        <li class="nav-item">
       
        
	      <table>
		     <!-- 로그아웃 버튼 -->
		     <li class="nav-item">    
		     <div class="logout">
	          <a class="nav-link js-scroll-trigger" href="" >
	            <img src="resources/img/logout.png" width=120 height=50></a>
	            </div>
	        </li>
	        
		        <div class="social-icons">
			        <!-- 날씨 -->
			        <li class="nav-item">
			          <a class="nav-link js-scroll-trigger" href="weather" target="box2">
			         <img src="resources/img/sun.png" width=80 height=80 ></a>
			        </li>
			      
			        <!-- 달력 -->
			        <li class="nav-item">
			          <a class="nav-link js-scroll-trigger" href="calendar" target="box2">
			           <img src="resources/img/cal.png" width=80 height=80 ></a>
			        </li>
			       
			        <!-- 뉴스 -->
			        <li class="nav-item">
			          <a class="nav-link js-scroll-trigger" href="news" target="box2">
			          <img src="resources/img/newsp.png" width=80 height=80></a>
			        </li>
	
				</div>
		  
		  </table>
		        
				
     	   </li>
    	</ul>
	</div>
        

  </nav>
<!-- Mainpage -->
  <!-- div <class="container-fluid p-0">

    <section class="resume-section p-3 p-lg-5 d-flex align-items-center" id="about">
      <div class="w-100">
        <h1 class="mb-0">Welcome
          <span class="text-primary">WWW</span>
        </h1>
        <div class="subheading mb-5">당신 주위에서 일어나는 일들을 경험하세요!
          <a href="mailto:name@email.com">www@gmail.com</a>
        </div>
        <p class="lead mb-5"></p>
        
         <a>로그인 폼</a>
        
      </div> -->
    </section>
			<!--화면 2분할 코드 들어가는 구간 -->
	<!-- 	<tr>
		<th><a href="jsp/js1" target="box1"></a></th>
		</tr>
		target으로 name을 지정해주면 해당 name화면으로 화면이 바뀜
		
		<tr>
		<th><a href="jquery3" target="box2"></a></th>
		</tr>
		
		<tr>
		<th><a href="ajax1" target="box2"></a></th>
		</tr>
		
		<tr>
		<th><a href="ajax2" target="box2"></a></th>
		</tr> -->
		
		</table>
		
		<!-- 화면 이중분할 -->
		<div class="divide">
		<button onclick >맵 변환 버튼 들어갈 자리</button>
		<iframe width="100%" height="400px" src="map_Basic" name = "box1" frameborder=0 framespacing=0 marginheight=0 marginwidth=0 scrolling=no vspace=0></iframe><br> <!-- 위에가 바뀜 -->
		<iframe width="100%" height="350px" src="scheduleplus" name = "box2" frameborder=0 framespacing=0 marginheight=0 marginwidth=0 scrolling=no vspace=0></iframe> <!-- 아래가 바뀜 -->
		</div>

	<!-- 입력용 모달-->
	<div class="modal fade" id="insertModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">일정 입력</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        <button type="button" class="btn btn-primary" id="btin">일정 등록</button>
      </div>
     
      <div class="modal-body">
        <form id="insert">
        <input type="hidden" name="email" value="${sessionScope.loginId}">
        <label for="schedulecontent" class="col-form-label">제목</label>
        <input type="text" class="form-control" name = "scontent" id="inscontent">
        <br>
        
            <label for="startdate" class="col-form-label">시작일</label>
            <br>
            <input type="text" name = "startdate" id="instartdate" style="width:100px; float:left;">
            <input type="text" name = "startdate" id="instarttime" style="width:100px;">
           <h4>~</h4>
            <label for="enddate" class="col-form-label">종료일</label>
            <br>
            <input type="text" name = "enddate" id="inenddate" style="width:100px; float:left;">
            <input type="text" name = "enddate" id="inendtime" style="width:100px;">
            <br>
            <label for="slocation" class="col-form-label">위치 &nbsp; <button type="button" id="inmap" onclick="submitToWindow()">검색</button> <button type="button" id="inmapClose" onclick="">닫기</button></label><br>
            <input type="text" class="form-control" name = "slocation" id="inslocation">
           	<input type="hidden" id="slat" name="slatitude">
           	<input type="hidden" id="slon" name="slongitude">
            <iframe width="100%" height="400px" src="map_Search" name = "slocationMap"></iframe><br> 
            <div id="result_sub"></div>
			<div id="start"></div>
			<div id="end"></div>
			<p>첫번째 대중교통<input type="text" id="input_sub" readonly="readonly"></p>
        </form>
      </div>
      <div class="modal-footer">
        
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>

 <!-- 수정용 모달 -->
<div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">일정 입력</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>

      <div class="modal-body">
        <form id="update">
        <input type="hidden" name="email" id="setemail" value="${sessionScope.loginId}">
        <input type="hidden" name="snum" id="setnum">
        <label for="schedulecontent" class="col-form-label">제목</label>
        <input type="text" class="form-control" name = "scontent" id="setscontent"><br>
        
            <label for="starttime">시작일</label><br>
            <input type="text" name = "startdate" id="setstartdate" style="width:100px;">
            <input type="text" name = "startdate" id="setstarttime" style="width:100px;">
           <h4>~</h4>
            <label for="enddate">종료일</label><br>
            <input type="text" name = "enddate" id="setenddate" style="width:100px;">
            <input type="text" name = "enddate" id="setendtime" style="width:100px;"><br>
            <label for="local">위치</label>
            <input type="text" class="form-control" name = "slocation" id="setslocation">
            <label for="local">길찾기 경로</label>
            <input type="text" class="form-control" name = "slocation" id="setslocation">
        </form>
      </div>
      <div class="modal-footer">
   	    <button type="button" class="btn btn-primary" id="btde">삭제하기</button>
        <button type="button" class="btn btn-primary" id="btup">수정하기</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>
			
  <!-- Bootstrap core JavaScript -->
  <!-- <script src="resources/vendor/jquery/jquery.min.js"></script> -->
  <script src="resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Plugin JavaScript -->
  <script src="resources/vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Custom scripts for this template -->
  <script src="resources/js/resume.min.js"></script>
   
  <!-- 하단 이미지 -->
   <div class="footer">
    <p class="copyright"><img src="resources/img/underbanner2.png" width="100%" height="20%"></p>
  	</div>
</body>
</html>
		