<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<script src="resources/js/jquery-3.3.1.min.js"></script>
<script>
$(document).ready(function(){
	
 	var country = $('#country').html();
	
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
	
 	function split (con) {
		var loc = $(con).find("location").text();
		$.ajax({
			url: 'split',
			type: 'POST',
			data: {loc: loc},
			dataType: 'text',
			success: function(){
				alert('����');
			}
		});
	}
	
	var lat = $('#lat1').html();
	
	var lon = $('#lon1').html();
	
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
})

</script>
<title>�ǽð� ����</title>
<script>

</script>
</head>
<body>

<div id="country">${sessionScope.country2}</div>

���� : <div id="outputDiv0"></div><br>
���� ��� : <div id="outputDiv1"></div><br>
���� : <div id="outputDiv2"></div><br>


<div id="lat1">${sessionScope.lat}</div>
<div id="lon1">${sessionScope.lng}</div>

</body>
</html>