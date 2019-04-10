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

<script>
//페이지 실행하자마자 실행
$(document).ready(function(){
	//홈에서 모달 호출 버튼
	$('#insertmd').on('click', insert_md);
	
    $('#insertModal', parent.document).on('hide.bs.modal', function(e){
		$('#insertModal #inscontent', parent.document).val("");
		$('#insertModal #inslocation', parent.document).val("");
		$('#insertModal input[name=startdate]', parent.document).val("");
		$('#insertModal input[name=enddate]', parent.document).val("");
    });  
	//서버에서 하루스케쥴 목록 불러오기
	$.ajax({
		url:'getScheduleList',
		type: 'post',
		dataType:'json',
		success : function(sList){         
			//반복문으로 sList안의 일정 읽기
			$.each(sList, function (index, item){
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
						+ '</td>'+ '<td>' + scontent +'</td>' + '<td>'+ '' + '</td>');	
			});
		},
		error: function(er){
			alert(JSON.stringify(er));
		}
	});
	
	
});  

//모달 호출 메소드
function insert_md(){
	
	$('#insertModal',parent.document).modal('show');
    $('#insertModal',parent.document).on('shown.bs.modal', function(e){
    	$('#insertModal #schedulecontent',parent.document).focus();
    });
    
}

</script>
<title>schedule</title>
</head>
<body>
<h1>일정 목록</h1>
<table>
		<tr>
			<th>번호</th>
			<th>시간</th>
			<th>제목</th>
			<th>노선</th>
		</tr>
	<c:forEach var="i" begin="0" end="${sessionScope.sListSize}">
		<tr id = "inputTR${i}">
		</tr>
	</c:forEach>
	<tr>
	<td colspan="4" align="center"><button id="insertmd">일정 등록</button></td>
	</tr>
</table>

</body>
</html>