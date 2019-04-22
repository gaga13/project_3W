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
<title>Insert title here</title>
<script src="resources/jquery/jquery-3.3.1.min.js"></script>
<script>
var scheduleList = new Array();
var selectedSnum;
//이벤트 연결
$(document).ready(function(){
	$('#twittBtn').on('click', twittSubmit);
	getScheduleList();
});
//스케쥴 목록
function getScheduleList(){
	$.ajax({
		url:'getScheduleList',
		type: 'post',
		dataType:'json',
		success : function(sList){         
			scheduleList = sList;
			//반복문으로 sList안의 일정 읽기
			$.each(sList, function (index, item){
				var snum = item.snum;
				var scontent = item.scontent;
				var startdate = item.startdate;

				//var enddate = item.enddate;
				if(startdate.substring(3,4) == 0){
					startdate = startdate.substring(0,3)
					+ startdate.substring(4,5)+ '시 ' + startdate.substring(6)+'분';
				}	
				else{
					startdate = startdate.substring(0,5) + '시 ' 
					+startdate.substring(6) + '분';
				}
				//html에 일정 넣기
				$('#inputTR'+ index).html('<td>'+(index +1)+'</td>'+'<td>'+startdate+''
						+ '</td>'+ '<td>' + scontent +'</td>'
						+ '<td>'+ '<input type="radio" name="twittChk" value="'+ snum +'"'
						+'onclick="javascript:check_only(this.value)">'+ '</td>');
				
			});
		},
		error: function(er){
			alert(JSON.stringify(er));
		}
	});	
}
//라디오 버튼 선택 시 트윗 내용 보여주기
function check_only(chk){
	
	
	for(var i =0; i < scheduleList.length; i++){
		if(scheduleList[i].snum == chk){
			$('#putselectedschedule').html('<textarea id="selectedSchedule">' + scheduleList[i].slocation +'에서 ' 
				+ scheduleList[i].scontent + '</textarea>');
		}
	}	
	selectedSnum = chk;
}
//트윗 전송
function twittSubmit(){
	
	var twitt = $('#selectedSchedule').val();	
	//라디오 버튼 선택 안했을 때 예외처리
	if(!$('input:radio[name=twittChk]').is(':checked')){
		$('#notSelected').html('트윗할 일정을 선택해주세요');
		return;
	}
	$.ajax({
		url:'twitterWrite',
		type:'post',
		data: {twitt: twitt},
		success:function(){
			$('#twittSuccess').html('<a href="https://twitter.com">트윗 확인하러 가기</a>'
					+ '<br><a href="#" onclick="javascript:self.close();">닫기</a>');
			
		},
		error: function(e){ alert(JSON.stringify(e));}
	});  
}

</script>
</head>
<body>

<div class="table-users">
   <div class="header">Today's schedule</div>
   
<table cellspacing="0">
      <tr>
      	 
         <th>NO.</th>
         <th>Time</th>
         <th width="230">Title</th>
         <th></th>
         
         
      </tr>
	<c:forEach var="i" begin="0" end="${sessionScope.sListSize}">
		<tr id = "inputTR${i}">
		</tr>
	</c:forEach>
</table>
</div>
<div id="notSelected"></div>
<div id="putselectedschedule"></div>
<input type="button" value="트윗하기" id="twittBtn">
<div id="twittSuccess"></div>



</body>
</html>