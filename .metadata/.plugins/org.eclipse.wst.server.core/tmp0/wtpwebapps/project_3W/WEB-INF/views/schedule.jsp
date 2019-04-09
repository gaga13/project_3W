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

$(document).ready(function(){
		
	$.ajax({
		url:'getScheduleList',
		type: 'post',
		dataType:'json',
		success : function(sList){         
			//each함수 객체.속성
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
				$('#inputTR'+ index).html('<td>'+(index +1)+'</td>'+'<td>'+startdate+''
						+ '</td>'+ '<td>' + scontent +'</td>' + '<td>'+ '' + '</td>');	
			});
		},
		error: function(er){
			alert(JSON.stringify(er));
		}
	});
	
	//홈에서 모달 호출 버튼
	$('#insertmd').on('click', insert_md);
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
<h1>일정 보여주기</h1>
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