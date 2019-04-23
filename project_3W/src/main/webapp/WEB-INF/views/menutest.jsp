<!doctype html>
<html lang="zh">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>jquery gooey menu pluggins,Easily customizable jQuery plugin using SVG filters</title>
	<link rel="stylesheet" href="resources/css/menu.bootstrap.min.css">
    	<link rel="stylesheet" href="resources/css/font-awesome.min.css">
    	<link rel="stylesheet" type="resources/text/css" href="css/htmleaf-demo.css">
    	<link rel="stylesheet" href="resources/css/gooey.min.css">
    	<link rel="stylesheet" href="resources/css/livedemo.css">
    	<style>
        .prettyprint ol.linenums > li {
            list-style-type: decimal;
        }
    </style>
	<!--[if IE]>
		<script src="http://libs.useso.com/js/html5shiv/3.7/html5shiv.min.js"></script>
	<![endif]-->
</head>
<body>

	
       
    <div class="row">
        <div class="col-xs-12 col-sm-6 col-md-5">
            
            <nav id="gooey-h">
                <input type="checkbox" class="menu-open" name="menu-open2" id="menu-open2">
  <label class="open-button" for="menu-open2">
    <span class="burger burger-1"></span>
    <span class="burger burger-2"></span>
    <span class="burger burger-3"></span>
  </label>
  
  <a href="#" class="gooey-menu-item">로그아웃<i class="fa fa-train"></i> </a>
  <a href="#" class="gooey-menu-item">회원정보 수정<i class="fa fa-bicycle"></i> </a>
  <a href="#" class="gooey-menu-item">홈으로 <i class="fa fa-rocket"></i> </a>
  <a href="#" class="gooey-menu-item"> <i class="fa fa-automobile"></i> </a>
            </nav>   
        </div>

     
    
 
	<script src="http://libs.useso.com/js/jquery/2.1.1/jquery.min.js" type="text/javascript"></script>
	<script>window.jQuery || document.write('<script src="resources/jquery/jquery-2.1.1.min.js"><\/script>')</script>
	<script src="resources/jquery/gooey.min.js"></script>
	<script>
        $(function($) {
            $("#gooey-upper").gooeymenu({
                bgColor: "#ff6666",
                contentColor: "white",
                style: "circle",
                horizontal: {
                    menuItemPosition: "glue"
                },
                vertical: {
                    menuItemPosition: "spaced",
                    direction: "up"
                },
                circle: {
                    radius: 80
                },
                margin: "small",
                size: 90,
                bounce: true,
                bounceLength: "small",
                transitionStep: 100,
                hover: "#e55b5b"
            });
$("#gooey-h").gooeymenu({
                bgColor: "#68d099",
                contentColor: "white",
                style: "horizontal",
                horizontal: {
                    menuItemPosition: "glue"
                },
                vertical: {
                    menuItemPosition: "spaced",
                    direction: "up"
                },
                circle: {
                    radius: 90
                },
                margin: "small",
                size: 80,
                bounce: true,
                bounceLength: "small",
                transitionStep: 100,
                hover: "#5dbb89"
            });
$("#gooey-round").gooeymenu({
                bgColor: "#68d099",
                contentColor: "white",
                style: "circle",
                horizontal: {
                    menuItemPosition: "spaced"
                },
                vertical: {
                    menuItemPosition: "spaced",
                    direction: "up"
                },
                circle: {
                    radius: 85
                },
                margin: "small",
                size: 80,
                bounce: true,
                bounceLength: "small",
                transitionStep: 100,
                hover: "#5dbb89"
            });
   $("#gooey-API").gooeymenu({
                bgColor: "#68d099",
                contentColor: "white",
                style: "circle",
                circle: {
                    radius: 85
                },
                margin: "small",
                size: 70,
                bounce: true,
                bounceLength: "small",
                transitionStep: 100,
                hover: "#5dbb89",
                open: function() {
                    $(this).find(".gooey-menu-item").css("background-color", "steelblue");
                    $(this).find(".open-button").css("background-color", "steelblue");
                },
                close: function() {
                    $(this).find(".gooey-menu-item").css("background-color", "#ffdf00");
                    $(this).find(".open-button").css("background-color", "#ffdf00");
                }
            });
 $("#gooey-v").gooeymenu({
                bgColor: "#68d099",
                contentColor: "white",
                style: "vertical",
                horizontal: {
                    menuItemPosition: "glue"
                },
                vertical: {
                    menuItemPosition: "spaced",
                    direction: "up"
                },
                circle: {
                    radius: 90
                },
                margin: "small",
                size: 70,
                bounce: true,
                bounceLength: "small",
                transitionStep: 100,
                hover: "#68d099"
            });

        });
    </script>
</div></body>
</html>