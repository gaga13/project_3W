<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="resources/css/scroll.css" rel="stylesheet">
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<script src="resources/js/jquery-3.3.1.js"></script>
<script>
$(document).ready(function(){
	$('#bt1').on('click', locationSearch);
 	
});

function locationSearch(){
	var location = document.getElementById("Search1");
	var lat;
	var lon;
	
	$.ajax({
		url: 'translate',
		type: "GET",
		data: {country : location.value},
		dataType: "text",
		success: Conversion,
		error: function(e){
			alert(json.stringify(e));
		}
	});
	
	function Conversion(country){
		var latlng = "https://maps.googleapis.com/maps/api/geocode/xml?address=" + country + "&language=ko&sensor=false&key=AIzaSyDBLJ3URwB6HcAHqAJiwwOOqgqwUe2Hu0M"
		
		$.ajax({
			url: latlng,
			dataType: "xml",
			type: "GET",
			async: "false",
			success: split,
			error: function(e){
				alert(json.stringify(e));
			}
		});
	}
	
 	function split (con) {
		var loc = $(con).find("location").text();
		$.ajax({
			url: 'split',
			type: 'POST',
			data: {loc: loc},
			dataType: 'json',
			success: function(hash){
				var lon = hash.lng;
				var lat = hash.lat;
				
				var apiURI = "http://api.openweathermap.org/data/2.5/weather?lat=" + lat + "&lon=" + lon + "&appid="+"c1ae780151cf0ef8cdce02451a0dcc70";
				$.ajax({
				    url: apiURI,
				    dataType: "json",
				    type: "GET",
				    async: "false",
				    success: function(resp) {
				    	//����
				    	var country = resp.sys.country;
				    	var name = resp.name;
				    	$("#outputDiv0").html(country + " - " + name);
				    	
				    	//���
				    	var temp = resp.main.temp- 273.15;
				    	temp = Math.floor(temp*10)/10;
				    	$("#outputDiv1").html(temp);
				        
				    	//���� �����
				    	var weather = 0;
				    	var weather2 = null;
				    	var weather3 = "";
				    	for(var i = 0; i < resp.weather.length; i++){
				    		weather = resp.weather[i].id;
				    		if(weather >=200 && weather <= 232){
				    			weather2 = "õ��";
				    			if(weather3.search(weather2) == -1){
				    				weather3 = weather2 + " " + weather3;
				    			}
				    		}
				    		if(weather >= 300 && weather <= 321){
				    			weather2 = "������";
				    			if(weather3.search(weather2) == -1){
				    				weather3 = weather2 + " " + weather3;
				    			}
				    		}
				    		if(weather >= 500 && weather <= 531){
				    			weather2 = "��";
				    			if(weather3.search(weather2) == -1){
				    				weather3 = weather2 + " " + weather3;
				    			}
				    		}
				    		if(weather >= 600 && weather <= 622){
				    			weather2 = "��";
				    			if(weather3.search(weather2) == -1){
				    				weather3 = weather2 + " " + weather3;
				    			}
				    		}
				    		if(weather == 701 || weather == 721 || weather == 741){
				    			weather2 = "�Ȱ�";
				    			if(weather3.search(weather2) == -1){
				    				weather3 = weather2 + " " + weather3;
				    			}
				    		}
				    		if(weather == 711){
				    			weather2 = "����";
				    			if(weather3.search(weather2) == -1){
				    				weather3 = weather2 + " " + weather3;
				    			}
				    		}
				    		if(weather == 731 || weather == 751 || weather == 761){
				    			weather2 = "��, ����";
				    			if(weather3.search(weather2) == -1){
				    				weather3 = weather2 + " " + weather3;
				    			}
				    		}
				    		if(weather == 762){
				    			weather2 = "ȭ����";
				    			if(weather3.search(weather2) == -1){
				    				weather3 = weather2 + " " + weather3;
				    			}
				    		}
				    		if(weather == 771){
				    			weather2 = "���ݽ�";
				    			if(weather3.search(weather2) == -1){
				    				weather3 = weather2 + " " + weather3;
				    			}
				    		}
				    		if(weather == 781){
				    			weather2 = "��ǳ";
				    			if(weather3.search(weather2) == -1){
				    				weather3 = weather2 + " " + weather3;
				    			}
				    		}
				    		if(weather == 800){
				    			weather2 = "���� �ϴ�";
				    			if(weather3.search(weather2) == -1){
				    				weather3 = weather2 + " " + weather3;
				    			}
				    		}
				    		if(weather == 801){
				    			weather2 = "���� ���� ����";
				    			if(weather3.search(weather2) == -1){
				    				weather3 = weather2 + " " + weather3;
				    			}
				    		}
				    		if(weather >= 802 && weather <= 804){
				    			weather2 = "���� �ִ� ����";
				    			if(weather3.search(weather2) == -1){
				    				weather3 = weather2 + " " + weather3;
				    			}
				    		}
				    		$('#outputDiv2').html(weather3);
				    	}
				    }
				});
				
				var apiURI = "http://api.openweathermap.org/data/2.5/forecast?lat=" + lat + "&lon=" + lon + "&appid="+"c1ae780151cf0ef8cdce02451a0dcc70";
				
				$.ajax({
					url: apiURI,
				    dataType: "json",
				    type: "GET",
				    async: "false",
				    success: function(resp) {
				    	
				    	for(var i = 0; i < resp.list.length; i++){
				    		//�ð�
				    		var time = resp.list[i].dt_txt;
				    		$("#time"+ i).html(time);
				    		
					    	//���
					    	var temp = resp.list[i].main.temp- 273.15;
					    	temp = Math.floor(temp*10)/10;
					    	$("#temp" + i).html(temp);
					    	
					    	//���� �����
					    	var weather = 0;
					    	var weather2 = null;
					    	var weather3 = "";
					    	for(var j = 0; j < resp.list[i].weather.length; j++){
					    		weather = resp.list[i].weather[j].id;
					    		if(weather >=200 && weather <= 232){
					    			weather2 = "õ��";
					    			if(weather3.search(weather2) == -1){
					    				weather3 = weather2 + " " + weather3;
					    			}
					    		}
					    		if(weather >= 300 && weather <= 321){
					    			weather2 = "������";
					    			if(weather3.search(weather2) == -1){
					    				weather3 = weather2 + " " + weather3;
					    			}
					    		}
					    		if(weather >= 500 && weather <= 531){
					    			weather2 = "��";
					    			if(weather3.search(weather2) == -1){
					    				weather3 = weather2 + " " + weather3;
					    			}
					    		}
					    		if(weather >= 600 && weather <= 622){
					    			weather2 = "��";
					    			if(weather3.search(weather2) == -1){
					    				weather3 = weather2 + " " + weather3;
					    			}
					    		}
					    		if(weather == 701 || weather == 721 || weather == 741){
					    			weather2 = "�Ȱ�";
					    			if(weather3.search(weather2) == -1){
					    				weather3 = weather2 + " " + weather3;
					    			}
					    		}
					    		if(weather == 711){
					    			weather2 = "����";
					    			if(weather3.search(weather2) == -1){
					    				weather3 = weather2 + " " + weather3;
					    			}
					    		}
					    		if(weather == 731 || weather == 751 || weather == 761){
					    			weather2 = "��, ����";
					    			if(weather3.search(weather2) == -1){
					    				weather3 = weather2 + " " + weather3;
					    			}
					    		}
					    		if(weather == 762){
					    			weather2 = "ȭ����";
					    			if(weather3.search(weather2) == -1){
					    				weather3 = weather2 + " " + weather3;
					    			}
					    		}
					    		if(weather == 771){
					    			weather2 = "���ݽ�";
					    			if(weather3.search(weather2) == -1){
					    				weather3 = weather2 + " " + weather3;
					    			}
					    		}
					    		if(weather == 781){
					    			weather2 = "��ǳ";
					    			if(weather3.search(weather2) == -1){
					    				weather3 = weather2 + " " + weather3;
					    			}
					    		}
					    		if(weather == 800){
					    			weather2 = "���� �ϴ�";
					    			if(weather3.search(weather2) == -1){
					    				weather3 = weather2 + " " + weather3;
					    			}
					    		}
					    		if(weather == 801){
					    			weather2 = "���� ���� ����";
					    			if(weather3.search(weather2) == -1){
					    				weather3 = weather2 + " " + weather3;
					    			}
					    		}
					    		if(weather >= 802 && weather <= 804){
					    			weather2 = "���� �ִ� ����";
					    			if(weather3.search(weather2) == -1){
					    				weather3 = weather2 + " " + weather3;
					    			}
					    		}
					    		$("#weather" + i).html(weather3);
					    	}
				    	}
				    },
					error: function (e) {
						alert(JSON.stringify(e));
					}
				});
				
			}
		});
	}
}

</script>
<title>�ǽð� ����</title>
<script>

</script>
</head>
<body>

��ġ �˻��� : <input type="text" id="Search1"><input type="button" id="bt1" value="�˻�"><br>

���� : <div id="outputDiv0"></div><br>
���� ��� : <div id="outputDiv1"></div><br>
���� : <div id="outputDiv2"></div><br>

[5�ϰ��� ���� ����]<br>
<c:forEach var="i" begin="0" end="38">
	�ð� : <div id="time${i}"></div>
	��� ��� : <div id="temp${i}"></div>
	���� : <div id="weather${i}"></div><br>
</c:forEach>

<input type="hidden" id="lng" value="${sessionScope.loginLon}"/>
<input type="hidden" id="lat" value="${sessionScope.loginLat}"/>

</body>
</html>