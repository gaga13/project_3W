<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="resources/jquery/jquery-3.3.1.min.js"></script>
<script>
//1초 후 함수 실행
$(document).ready(function(){
	auto_close();
});
function auto_close() {
	setTimeout('closed()',500);
	}

	function closed() {
	self.close();
	}
	auto_close();
</script>
</head>
<body>

</body>
</html>