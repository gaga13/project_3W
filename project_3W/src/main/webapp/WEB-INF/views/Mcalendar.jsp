<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<style>
.view{  width:1200px; height:400px; overflow:hidden; }
</style>

<link href="<c:url value='resources/css/fullcalendar.min.css'/>" rel="stylesheet" type="text/css">
<link href="<c:url value='resources/css/bootstrap.min.css'/>" rel="stylesheet" type="text/css">
<script src="<c:url value='resources/jquery/jquery-3.3.1.min.js'/>"></script>
<script src="<c:url value='resources/jquery/jquery-ui.min.js'/>"></script>
<script src="<c:url value='resources/jquery/moment.min.js'/>"></script>
<script src="<c:url value='resources/jquery/fullcalendar.min.js'/>"></script>
<script src="<c:url value='resources/jquery/locale-all.js'/>"></script>
<script src="<c:url value='resources/jquery/bootstrap.min.js'/>"></script>
<script src="<c:url value='resources/jquery/jquery.timepicker.min.js'/>"></script>
<style>

#calendar {
	width : 1200px;
}

</style>
<script>
var information;
$(function (){
	calendar();
    $('#updateModal', parent.document).on('hide.bs.modal', function(e){;
	$('body', parent.document).removeClass('modal-open');
});//hide 모달 이벤트
});

//달력호출
function calendar() {
	var initialLocaleCode = 'ko';
	$('#calendar').fullCalendar({
						header : {
							left : 'prev,next today',
							center : 'title',
							right : ''
						},
						height : 550,
						eventClick : function(info) {},
						defaultView : 'month',
						locale : initialLocaleCode,							
						eventClick : function(info) {
							
							var clickDay;
							for(var n =0; n<information.length;n++ ){
								if(information[n].snum == info.id){
								clickDay=information[n];
								}
							}
							console.log(clickDay);
							var std = info.start._i.split(" ");
							var edd = info.end._i.split(" ");

							var startTimeSet;
							var EndTimeSet;
							
							var sp = std[1].split(":");
							var ep = edd[1].split(":");
							
							if(parseInt(sp[0])<12){
								startTimeSet = "오전 "+std[1];
							}else{
								startTimeSet = "오후 "+(sp[0]-12)+":"+sp[1];
							}
							
							if(parseInt(ep[0])<12){
								EndTimeSet = "오전 "+edd[1];
							}else{
								EndTimeSet = "오후 "+(ep[0]-12)+":"+ep[1];
							}

 							$('#updateModal #setscontent',parent.document).val(info.title);
							$('#updateModal #setnum',parent.document).val(info.id);
							$('#updateModal #setstartdate',parent.document).val(std[0]);
							$('#updateModal #setstarttime',parent.document).val(startTimeSet);
							$('#updateModal #setenddate',parent.document).val(edd[0]);
							$('#updateModal #setendtime',parent.document).val(EndTimeSet);
							$('#updateModal #setslocation', parent.document).val(clickDay.slocation);
							$('#updateModal #setsubroute', parent.document).val(clickDay.subroute);
 
							$('#updateModal',parent.document).modal('show');
						    $('#updateModal',parent.document).on('shown.bs.modal', function(e){						    	
						    	$('body',parent.document).addClass('modal-open');
						    });
							
						  },
						dayClick:function (date, jsEvent, view){
							console.log(date._d.getFullYear()+"/"+(date._d.getMonth()+1)+"/"+date._d.getDate());
							$.ajax({
								url: 'getDaily',
								type:'post',
								data:{daily:date._d},
								success:function(){
									parent.document.location.reload();	
								},
								error: function(e){
								}
							});
							
						},
						nextDayThreshold:"00:00",
						buttonIcons : true,
						navLinks : false,
						editable : false,
						eventLimit : true,
						events : function(startdate, enddate, timezone,callback) {

							var std = startdate._d;
							var edd = enddate._d;
							
							st= std.getFullYear()+"-"+(std.getMonth()+1)+"-"+std.getDate();
							ed= edd.getFullYear()+"-"+(edd.getMonth()+1)+"-"+edd.getDate();
 							
							$.ajax({
										url : 'getMonth',
										type : 'get',
										data:{st:st, ed:ed},
										dataType : 'json',
										success : function(list) {
											var events = [];
											information = list;
											console.log(list);
											$.each(list,function(key,item) {
											
																events.push({
																			id : item.snum,
																			title : item.scontent,
																			start : item.startdate,
																			end : item.enddate
																		});
															});
											callback(events);
										},
										error : function(r, status, e) {
											alert("code=" + r.status+ "message="+ r.responseText+ "error=" + e);
										}
									});//ajax
						}
					});//fullCalendar
}
</script>
</head>
<body>
	<br>
	<div class="S_unvisible" align="center">
		<div class="scrollblind">
			<div id="calendar"></div>
	</div>
</div>

</body>

</html>