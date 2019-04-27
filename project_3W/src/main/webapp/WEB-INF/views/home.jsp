<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>

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
  <!-- menu meta -->
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
	<meta name="viewport" content="width=device-width, initial-scale=1.0">

  <title>WWW에 오신것을 환영합니다</title>


  <!-- Bootstrap core JavaScript -->
  <!-- <script src="resources/vendor/jquery/jquery.min.js"></script> -->
  <script src="resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Plugin JavaScript -->
  <script src="resources/vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Custom scripts for this template -->
  <script src="resources/js/resume.min.js"></script>
   
  <!-- Bootstrap core CSS -->
  <link href="resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

  <!-- Custom fonts for this template -->
  <link href="https://fonts.googleapis.com/css?family=Saira+Extra+Condensed:500,700" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css?family=Muli:400,400i,800,800i" rel="stylesheet">
  <link href="resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">

  <!-- Custom styles for this template -->
  <link href="resources/css/resume.min.css" rel="stylesheet">
	
  <!-- 메뉴 css-->
  	<link rel="stylesheet" href="resources/css/menu.bootstrap.min.css">
    	<link rel="stylesheet" href="resources/css/font-awesome.min.css">
    	<link rel="stylesheet" type="resources/text/css" href="css/htmleaf-demo.css">
    	<link rel="stylesheet" href="resources/css/gooey.min.css">
    	<link rel="stylesheet" href="resources/css/livedemo.css">
 <style>
        .prettyprint ol.linenums > li {
            list-style-type: decimal;
        }
    </style> 
  
  
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
	
	//캘린더 클릭시 맵 hide
	$('a').click(function(){
		var check = $(this).attr("id");
			if(check == 'calendar'){
				document.getElementById("mapIframe").style.display = "none";
				document.getElementById("mapChangeButton").style.visibility = "hidden";
			}
			else{
				document.getElementById("mapIframe").style.display = "block";
				document.getElementById("mapChangeButton").style.visibility = "visible";
			}
	});
	
	//맵 전환 버튼 이벤트연결
	$('#mapChangeBtn').on('click', changeMapIframe);

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
function submitToMapSearch(){
	//검색 눌렀을 때 자식창 열기
	document.getElementById("searchMapControl").style.display = "block";

	var search = $('#inslocation').val();
	
	var frame = document.getElementById("slocationMap");
    var gocoderFrameGo = frame.contentWindow || frame.contentDocument ;

    gocoderFrameGo.search(search);
}

//위치의 닫기 눌렀을 때 map_Search창 닫기
function MapSearchClose(){
	document.getElementById("searchMapControl").style.display = "none";
}

//모달의 닫기 눌렀을 때 기존 map_Search기록 삭제하기
function ClickClose(){
	document.getElementById("searchMapControl").style.display = "none";
	document.getElementById("subMapControl").style.display = "none";
	var frame = document.getElementById("slocationMap");
    var gocoderFrameGo = frame.contentWindow || frame.contentDocument ;
	
    gocoderFrameGo.search("");
}

//경로 검색창 열기
function Search_sub(){
	//검색 눌렀을 때 자식창 열기
	document.getElementById("subMapControl").style.display = "block";
}

//위치의 닫기 눌렀을 때 map_Search창 닫기
function subMapClose(){
	document.getElementById("subMapControl").style.display = "none";
}


//menu드롭 사이드
$(function() {
         $("#gooey-h").gooeymenu({
          style: "horizontal",
          contentColor: "#eba190",
          horizontal: {
                    menuItemPosition: "glue"
                }
         });
         });
//맵 전환 이벤트 함수
function changeMapIframe(){
	if($('#mapIframe').attr('src') == 'map_Main'){
		$('#mapIframe').attr("src", "map_Basic"); 
	}
	else{
		$('#mapIframe').attr("src", "map_Main");
	}
}
</script>

<script>
//iframe resize
function autoResize(i){
	var iframeHeight = (i).contentWindow.document.body.scrollHeight;
	(i).height = iframeHeight + 20;
}
</script>

<!-- 메뉴 드롭다운 스크립트 -->
<script src="http://libs.useso.com/js/jquery/2.1.1/jquery.min.js" type="text/javascript"></script>
<script>window.jQuery || document.write('<script src="resources/jquery/jquery-2.1.1.min.js"><\/script>')</script>
<script src="resources/jquery/gooey.min.js"></script>
	<script>
        $(function($) {
            
$("#gooey-h").gooeymenu({
                bgColor: "#85ccbb",
                contentColor: "#000",
                style: "horizontal",
                horizontal: {
                    menuItemPosition: "glue"
                },
                vertical: {
                    menuItemPosition: "spaced",
                    direction: "up"
                },
                circle: {
                    radius: 120
                },
                margin: "small",
                size: 100,
                bounce: true,
                bounceLength: "small",
                transitionStep: 100,
                hover: "#eba190"
            });


        });
    </script>



<style>
#iconimg{position:relative; top:12px;}
#day{position:absolute; left:17px; top: 50px; color:black;}
</style>


</head>

<body id="page-top">

  <nav class="navbar navbar-expand-lg navbar-dark bg-primary fixed-top" id="sideNav">
    <a class="navbar-brand js-scroll-trigger" href="#page-top">
      <span class="d-block d-lg-none">3W에 오신 것을 환영합니다 </span>
      <span class="d-none d-lg-block"></span>
   
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
   
     <ul class="navbar-nav">
        <li class="nav-item">
           <!-- 홈으로 돌아가기 -->
      <a href="hom"></a>
      <!-- 메뉴 드롭다운바 -->
    <div class="row" id="row1">
        <div class="col-xs-12 col-sm-6 col-md-5">
            <nav id="gooey-h">
                <input type="checkbox" class="menu-open" name="menu-open2" id="menu-open2">
				  <label class="open-button" for="menu-open2">
				   <!-- 프로필 이미지 들어가는 공간 -->
				  <img class="img-fluid img-profile rounded-circle mx-auto mb-2" src="resources/img/head.png" alt="">
				  </label>
				  <a href="logout" class="gooey-menu-item">로그아웃</a>
				  <a href="update" class="gooey-menu-item">회원정보수정<li></li></a>
				  <a href="home" class="gooey-menu-item">홈으로 </a>
		    </nav>   
        </div>
    </div>
<!-- 끝 -->
	      <table>
		        <div class="social-icons">
			        <!-- 날씨 -->
			        <li class="nav-item">
			          <a class="nav-link js-scroll-trigger" href="weather" target="box2" id="weather">
			        <div id="iconimg"><img src="resources/img/sun.png" width=80 height=80></div> </a>
			        </li>
			      
			        <!-- 달력 -->
			        <li class="nav-item">
			          <a class="nav-link js-scroll-trigger" href="calendar" target="box2" id="calendar">
			          <div id="iconimg"> <img src="resources/img/cal.png" width=80 height=80 >
			          </div>
			          <!-- 세션에 저장된 날짜의 값 -->
			         <div id="day" style="line-height:0.5cm; padding-left: 25px;">
			        	 ${oneyear}<br>
			        	 ${onedays}
			         </div>
			          </a>
			        </li>
			      
			        <!-- 뉴스 -->
			        <li class="nav-item">
			          <a class="nav-link js-scroll-trigger" href="news" target="box2" id="news">
			          <div id="iconimg"> <img src="resources/img/newsp.png" width=80 height=80></div></a>
			        </li>
	
				</div>
		  
		  </table>
		        
				
     	   </li>
    	</ul>
	</div>
        

  </nav>

    </section>
		
		</table>
		
		<!-- 화면 이중분할 -->
			<!-- 맵전환버튼  -->
			<a id="mapChangeButton" style="visibility: visible;">
				<div class="mapchagebtn">
				<!-- style="width:75; height:30px; font-family:inherit; font-weight: 700; background-color:#85ccbb; border:0 solid #a9d7cc"  -->
					<button type="button" id="mapChangeBtn" style="background-color:#85ccbb; border:0px">
					<img src="resources/img/map.png" width="40" height="40">
					</button>
				</div>
			</a>
			<div class="divide">
			<iframe width="90%" height="400px" style="position:relative; left:70px; display:block; border-width: 10px; border-style: solid; border-color:#85ccbb;" src="map_Main" name = "box1" frameborder=0 framespacing=0 marginheight=0 marginwidth=0 scrolling=no vspace=0 id="mapIframe"></iframe><br> <!-- 위에가 바뀜 -->
			<iframe width="100%" height="350px"  src="scheduleplus" onload="autoResize(this)" name = "box2" frameborder=0 framespacing=0 marginheight=0 marginwidth=0 scrolling=no vspace=0 allowTransparency="true"></iframe> <!-- 아래가 바뀜 -->
			</div>
		
	
	<!-- 입력용 모달-->
	<div class="modal fade" id="insertModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">일정 입력</h5>
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
            <label for="slocation" class="col-form-label">위치 &nbsp; <button type="button" id="inmap" onclick="submitToMapSearch()" style="background-color:white; border:0px"><img src="resources/img/search.png" width="20" height="20"></button> <button type="button" id="inmapClose" onclick="MapSearchClose()" style="background-color:white; border:0px"><img src="resources/img/checked.png" width="20" height="20"></button></label><br>
            <input type="text" class="form-control" name = "slocation" id="inslocation">
           	<input type="hidden" id="slat" name="slatitude">
           	<input type="hidden" id="slon" name="slongitude">
            <div id="searchMapControl" style="display:none">
            	<iframe width="100%" height="400px" src="map_Search" name = "slocationMap" id = "slocationMap"></iframe><br>
            	<div id="result_loc"></div>
            </div>
           
            <label for="subroute" class="col-form-label">길찾기 경로 &nbsp; <button type="button" id="submap" onclick="Search_sub()" style="background-color:white; border:0px"><img src="resources/img/search.png" width="20" height="20"></button> <button type="button" id="submapClose" onclick="subMapClose()" style="background-color:white; border:0px"><img src="resources/img/checked.png" width="20" height="20"></button></label><br>
            <input type="text" class="form-control"  readonly="readonly" id="subroute" name="subroute"> 
            <input type="hidden" name="subpath" id="input_sub">
            <div id="subMapControl" style="display:none">
            	<iframe width="100%" height="400px" src="map_Traffic" name = "subpathMap" id = "subpathMap"></iframe><br>
            	<div id="result_sub"></div>
            </div>            
			
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="ClickClose()">닫기</button>
      </div>
    </div>
  </div>
</div>

 <!-- 수정용 모달 -->
<div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">일정 수정</h5>
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
            <input type="text" class="form-control" name = "subroute" id="setsubroute">
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
			

  <!-- 하단 이미지 -->
   <div class="footer">
    <p class="copyright"><img src="resources/img/underbanner2.png" width="100%" height="20%"></p>
  	</div>
</body>
</html>
		