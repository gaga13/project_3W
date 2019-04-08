<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script src="resources/jquery/jquery-3.3.1.min.js"></script>
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
});  

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
	
</table>

</div>
</body>
</html>