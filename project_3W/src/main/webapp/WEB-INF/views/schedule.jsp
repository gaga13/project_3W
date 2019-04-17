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

//페이지 실행하자마자 실행
$(document).ready(function(){
	
	
	//홈에서 모달 호출 버튼
	$('.button').on('click', insert_md);
	
    $('#insertModal', parent.document).on('hide.bs.modal', function(e){
		$('#insertModal #inscontent', parent.document).val("");
		$('#insertModal #inslocation', parent.document).val("");
		$('#insertModal input[name=startdate]', parent.document).val("");
		$('#insertModal input[name=enddate]', parent.document).val("");
		$('#insertModal #inlocation', parent.document).hide();
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
				clickList;
			});
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
    });
    
}

//리스트 클릭했을 때
function clickList(i){
	var id = '#inputTR'+i;
	console.log(id);
	$('#updateModal #setcontent').val();
	$('#updateModal',parent.document).modal('show');
	
	
	$.ajax({
		url:'clickList',
		type: 'post',
		data: {i : i},
		dataType: 'json',
		success: function(){
			alert('성공');
			$('#updateModal #setstartdate',parent.document).val();
		},
		error: function(er){
			alert(JSON.stringify(er));
		}
	});
}

</script>
<title>schedule</title>
</head>
<body>

<div class="table-users">
   <div class="header">Today's schedule</div>
   
   <table cellspacing="0">
      <tr>
         <th>NO.</th>
         <th>Time</th>
         <th width="230">Title</th>
         <th>How to</th>
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

<%-- <!-- 수정용 모달 -->
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
</div> --%>

</body>
</html>