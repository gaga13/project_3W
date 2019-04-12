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
	$('#insertModal #instarttime').on('changeTime',{modal:$('#insertModal')},sted);
	$('#updateModal #setstarttime').on('changeTime',{modal:$('#updateModal')},sted);	
	
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
	
	if(title ==""){
		alert("제목을 입력해 주세요.");
		$('#insertModal  #inscontent').focus();
		$('#insertModal  #inscontent').select();
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
<iframe width="560" height="315" src="mapBasic" name = "box1"></iframe><br>
<iframe width="560" height="315" src="getScheduleList" name = "box2"></iframe>


	<!-- 입력용 모달-->
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
            <label for="slocation" class="col-form-label">위치 &nbsp; <button type="button" id="inmap">여기에 버튼 삽입 가능</button></label><br>
            <input type="text" class="form-control" name = "slocation" id="inslocation">
             <div id = "inlocation">디브를 띄우는 것에 성공하였다. 정말 기쁘구나</div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" id="btin">일정 등록</button>
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
</body>
</html>
	