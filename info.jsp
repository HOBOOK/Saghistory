<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLDecoder"%>
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" /> 
<link rel="stylesheet" href="movie.css">
<script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>


<script type="text/javascript" src="http://code.jquery.com/jquery-1.7.min.js"></script>
<script type="text/javascript" src="jquery.smartPop.js"></script>
<link href="styles/ihover.css" rel="stylesheet">
<link rel="stylesheet" href="jquery.smartPop.css" />

<title>신애 경호 이야기♪ Saghistory</title>
</head>
<body>
	<div id ="wrapper">
	
		<div id="header">
			<a href="index.jsp">
			<img id="header_logo" src="image/logo_1.png" alt="헤더로고이미지"/>
			</a>
		</div>
		
		<div id="menu">
			<ul>
				<li class="menu">
					<p>saghistory</p>
					<ul class="hide">
						<li><a href="index.jsp">홈</a></li>
						<li><a href="index.jsp">정보</a></li>
					</ul>
				</li>
				<li class="menu">
					<p>movehistory</p>
					<ul class="hide">
						<li><a href="movie.jsp">홈</a></li>
						<li><a href="movie.jsp">영화기록</a></li>
						<li><a href="movie.jsp">버킷리스트</a></li>
						<li><a href="movie.jsp">여행지도</a></li>
					</ul>
				</li>
				<li class="menu">
					<p>workistory</p>
					<ul class="hide">
						<li><a href="work.jsp">홈</a></li>
						<li><a href="work.jsp">정보</a></li>
					</ul>
				</li>
				<li class="menu">
					<p></p>
					<a style="display:block;text-decoration:none;"href="info.jsp">info</a>
				</li>
			</ul>
		</div>
		
		
		
		<div id="center">
		
			
		</div>
		
		
		<div id="footer">
		
		
		</div>
	
	
	</div>
	<script>
		$(document).ready(function(){
			$(".menu>p").click(function(){
				var submenu = $(this).next("ul");
				
				if(submenu.is(":visible")){
					submenu.slideUp();
				}else{
					submenu.slideDown();
				}
			});
		});
	

	</script>
    
    
</body>
</html>