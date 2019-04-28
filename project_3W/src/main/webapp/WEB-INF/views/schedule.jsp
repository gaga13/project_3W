<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="resources/jquery/jquery-3.3.1.min.js"></script>
<script src="resources/jquery/bootstrap.min.js"></script>
<link href="resources/css/jquery.timepicker.min.css" rel="stylesheet" type="text/css">
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
      <link rel="stylesheet" href="resources/css/table.css">
		<link href='https://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'>


<script>
var ScheduleList = new Array();
//페이지 실행하자마자 실행
$(document).ready(function(){
	
	
	//홈에서 모달 호출 버튼
	$('.button').on('click', insert_md);

    $('#insertModal', parent.document).on('hide.bs.modal', function(e){
		$('#insertModal #inscontent', parent.document).val("");
		$('#insertModal #inslocation', parent.document).val("");
		$('#insertModal input[name=startdate]', parent.document).val("");
		$('#insertModal input[name=enddate]', parent.document).val("");
		$('#insertModal input[name=subroute]', parent.document).val("");
		$('#insertModal #inlocation', parent.document).hide();
		
		parent.subMapClose();
		$('body', parent.document).removeClass('modal-open');
		//$(parent.frames["slocationMap"].document).get(0).location.reload(); //traffic용
     	//$(parent.frames["slocationMap"].contentDocument).get(0).location.reload(); //search 용
    
		//parent.location.reload(); //만약의 경우 사용
    });//hied 모달 이벤트
    
	//서버에서 하루스케쥴 목록 불러오기
	$.ajax({
		url:'getScheduleList',
		type: 'post',
		dataType:'json',
		success : function(sList){    
			scheduleList = sList;
			//반복문으로 sList안의 일정 읽기
			$.each(sList, function (index, item){
				
				var scontent = item.scontent;
				var startdate = item.startdate;
				var subpath = item.subpath;
				var snum = item.snum;
				
				if(startdate.substring(3,4) == 0){
					startdate = startdate.substring(0,3)
					+ startdate.substring(4,5)+ '시 ' + startdate.substring(6)+'분';
				}	
				else{
					startdate = startdate.substring(0,5) + '시 ' 
					+startdate.substring(6) + '분';
				}
				//길찾기 기능 사용하지 않았을 경우
				if(subpath == null){
					subpath = '';
				}
				//html에 일정 넣기
				$('#inputTR'+ index).html('<td>'+(index +1)+'</td>'+'<td>'+startdate+''
						+ '</td>'+ '<td>' + scontent +'</td>' + '<td>'+ subpath+ '</td>'
						+ '<td><input type="radio" name="twittChk" id="twittChk" value="'+ snum +'"'
						+'onclick="javascript:twitter_selectedSchedule(this.value)">'+ '</td>');
				clickList;
			});
			//라디오 버튼 숨기기
			$('input[type="radio"][name="twittChk"]').hide();
		},
		error: function(er){
			alert(JSON.stringify(er));
		}
	});
	
	
});  

//모달 호출 메소드
function insert_md(){
	
	$(this).toggleClass("clicked");
	$('#insertModal',parent.document).modal('show');
    $('#insertModal',parent.document).on('shown.bs.modal', function(e){
    	$('#insertModal #schedulecontent',parent.document).focus();
    	$('body',parent.document).addClass('modal-open');
    });
}

//리스트 클릭했을 때
function clickList(i){
	$.ajax({
		url:'clickList',
		type: 'post',
		data: {i : i},
		dataType: 'json',
		success: function(iList){

			var sp = iList.startdate.split(" ");
			var ep = iList.enddate.split(" ");
			var setnum = iList.snum;
			var content = iList.scontent;
			var location = iList.slocation;
			var startDate = sp[0];
			var endDate = ep[0];
			var startTime = sp[1] + " " + sp[2];
			var endTime = ep[1] + " " + ep[2];
			var subroute = iList.subroute;
			
			$('#updateModal #setnum', parent.document).val(setnum);
			$('#updateModal #setscontent', parent.document).val(content);
			$('#updateModal #setslocation', parent.document).val(location);
			$('#updateModal #setsubroute', parent.document).val(subroute);
			$('#updateModal #setstartdate', parent.document).val(startDate);
			$('#updateModal #setenddate',parent.document).val(endDate);
			$('#updateModal #setstarttime',parent.document).val(startTime);
			$('#updateModal #setendtime',parent.document).val(endTime);
			
			$('#updateModal',parent.document).modal('show');
		},
		error: function(er){
			alert(JSON.stringify(er));
		}
	});
}
//트위터
function twittBtn(){
	$('input[type="radio"][name="twittChk"]').show();
	//$('input[type="hidden"][name="twittChk"]').attr("type", "radio");
	
	
}
function twitter_selectedSchedule(s){
	$('#twittIcon').attr('href', 'javascript:submitTwitt()');
	$('#hiddenSelectedSnum').val(s);
	//수정폼 이벤트 해제
	$('tr[id^="inputTR"]').attr('onclick', '');
}
function submitTwitt(){
	/* var twitt = $('#selectedSchedule').val();	
	//라디오 버튼 선택 안했을 때 예외처리
	if(!$('input:radio[name=twittChk]').is(':checked')){
		$('#notSelected').html('트윗할 일정을 선택해주세요');
		return;
	} */
	//트위터 계정 연결 여부 확인
	$.ajax({
		url:'twitterTokenCheck',
		type:'get',
		dataType: 'json',
		success: function(check){
			if(check){
				//연결되어있음, session에 accessToken 담겨있음
				//트위터 글쓰기 창 띄우기
				window.open('twitterWrite','','width=700,height=300, location=0, resizable=0');
			}
			else{
				//트위터 인증 창
				window.open('twitterConnect', '', 'width=700,height=500');
			}
		},
		error: function(e){
			alert(JSON.stringify(e));
		}
	});
	
}
</script>

<style>
.button{position:relative; top:-30px; left:750px;
}
.tw{position:absolute;
	top: 15px;	
	left:920px;
	}
	.header{ height:60px;}
</style>

<title>schedule</title>
</head>
<body>

<div class="table-users">
		
	<!-- 트위터 호출 버튼 -->
	  
	   <div class="tw">
		<a href="javascript:twittBtn()" id="twittIcon"><img src="resources/img/twitter_3.png" ></a>
		</div>
		
		 <div class="header">Today's schedule 
		</div>
	
   <table cellspacing="0">
      <tr>
         <th>NO.</th>
         <th>Time</th>
         <th width="230">Title</th>
         <th>How to</th>
         <th></th>
      </tr>
	<c:forEach var="i" begin="0" end="${sessionScope.sListSize}">
		<tr id = "inputTR${i}" onclick="clickList(${i})">
		</tr>
	</c:forEach>
	<tr>  
	<!-- 이 버튼을 눌러서 모달을 호출 -->
	<div class="button" id="insertmd">
	</div>
	</tr>
	</table>
</div>

<input type="hidden" id="hiddenSelectedSnum">
</body>
</html>