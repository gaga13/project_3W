<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
	<title>Home</title>
<link href="<c:url value='resources/css/jquery-ui.css'/>" rel="stylesheet" type="text/css">
<link href="<c:url value='resources/css/bootstrap.min.css'/>" rel="stylesheet" type="text/css">
<link href="<c:url value='resources/css/jquery.timepicker.min.css'/>" rel="stylesheet" type="text/css">
<script src="<c:url value='resources/jquery/jquery-3.3.1.min.js'/>"></script>
<script src="<c:url value='resources/jquery/jquery-ui.min.js'/>"></script>
<script src="<c:url value='resources/jquery/jquery.timepicker.min.js'/>"></script>
<script src="<c:url value='resources/jquery/bootstrap.min.js'/>"></script>
<script src="<c:url value='resources/jquery/datepicker-ko-KR.js'/>"></script>

<script>
$(document).ready(function(){
	
	pickTime();
	
	//시작시간에 따른 종료시간 제한
	$('#insertModal #starttime').on('changeTime',sted);
	$('#insertModal #btin').on('click', insert);
	
});

//날짜 및 시간
function pickTime(){

	$('#insertModal #endtime').timepicker({
		  'disableTextInput': true,
	 	  'timeFormat': 'a h:i'  
	});
	$('#insertModal #starttime').timepicker({
		  'disableTextInput': true,
		  'maxTime': '오후 10:30',
	  	  'timeFormat': 'a h:i'  
	}); 
	
	  $('#insertModal #startdate').attr('readonly',true);
	  $('#insertModal #startdate').datepicker({
	    	dateFormat: "yy-mm-dd",	
	    	 firstDay: 0 
	    });
	  
	  $('#insertModal #enddate').attr('readonly',true);
	  $('#insertModal #enddate').datepicker({
		  dateFormat: "yy-mm-dd",
	    	firstDay: 0 
	    });
}


//시간 제한
function sted(){
	var stt = $('#insertModal #starttime');
	var edt = $('#insertModal #endtime');
	
	var sta = stt.get(0).value.split(" ");
	var eta = edt.get(0).value.split(" ");
	
	var getTime = sta[1].split(":");
	var hours = parseInt(getTime[0])+1; 
	
	if(sta[0]=='오전'){
		if(hours == 13){
			hours=1;
		}else if(hours == 12){
			sta[0]='오후';
		}
	}
	var newTime = sta[0]+hours+":"+getTime[1];
	
	$('#insertModal #endtime').timepicker('remove');
	$('#insertModal #endtime').val(newTime);
	$('#insertModal #endtime').timepicker({
		'minTime': newTime,
		'maxTime': '오후 11:30', 
		'disableTextInput': true,
		  'timeFormat': 'a h:i'
		});
}

//일정 등록용
function insert(){
	
	$.ajax({
		url:'setSchedule',
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
</script>
</head>
<body>
<h1>
	Hello world!  sysdate : ${sessionScope.sysdate} id :${sessionScope.loginId}
</h1>

<!-- 클릭하면 iframe에 화면 띄움 -->
<a href="getScheduleList" target="box2">스케줄 리스트</a>
<a href="getMcalendar" target="box2">달력</a>
<a href="getNews" target="box2">뉴스</a>
<br>

<!-- iframe박스 -->
<iframe width="560" height="315" src="" name = "box1"></iframe><br>
<iframe width="560" height="315" src="getScheduleList" name = "box2"></iframe>


	<!-- 모달창을 정의해놓은 공간  -->
	<div class="modal fade" id="insertModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">일정 입력</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
     
      <div class="modal-body">
        <form id="insert">
        <input type="hidden" name="email" value="${sessionScope.loginId}">
        <label for="schedulecontent" class="col-form-label">제목</label>
        <input type="text" class="form-control" name = "scontent" id="scontent">
        <br>
        
            <label for="startdate" class="col-form-label">시작일</label>
            <br>
            <input type="text" name = "startdate" id="startdate" style="width:100px; float:left;">
            <input type="text" name = "startdate" id="starttime" style="width:100px;">
           <h4>~</h4>
            <label for="enddate" class="col-form-label">종료일</label>
            <br>
            <input type="text" name = "enddate" id="enddate" style="width:100px; float:left;">
            <input type="text" name = "enddate" id="endtime" style="width:100px;">
            <br>
            <label for="slocation" class="col-form-label">위치</label><br>
            <input type="text" class="form-control" name = "slocation" id="slocation">
            
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" id="btin">일정 등록</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>

</body>
</html>