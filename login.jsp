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
<meta name="robots" content="index,follow">
<meta name="description" content="연인간의 사진공유 와 같이만드는 기록장">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" /> 
<meta property="og:type" content="website">
<meta property="og:title" content="Saghistory">
<meta property="og:description" content="연인간의 사진공유 와 같이만드는 기록장">
<meta property="og:image" content="http://www.saghistory.xyz/image/logo_1.png">
<meta property="og:url" content="http://www.saghistory.xyz">

<meta name="twitter:card" content="summary">
<meta name="twitter:title" content="페이지 제목">
<meta name="twitter:description" content="페이지 설명">
<meta name="twitter:image" content="http://www.saghistory.xyz">
<meta name="twitter:domain" content="사이트 명">

<link rel="stylesheet" href="login.css">
<script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>


<script type="text/javascript" src="http://code.jquery.com/jquery-1.7.min.js"></script>
<script type="text/javascript" src="jquery.smartPop.js"></script>
<link href="styles/ihover.css" rel="stylesheet">
<link rel="stylesheet" href="jquery.smartPop.css" />
<link rel="canonical" href="http://www.saghistory.xyz/index.jsp">

<title>Saghistory</title>
</head>
<body>
<%!public static String getDate() 

{

		DecimalFormat df = new DecimalFormat("00");

		Calendar calendar = Calendar.getInstance();




		String year = Integer.toString(calendar.get(Calendar.YEAR)); //년도를 구한다

		String month = df.format(calendar.get(Calendar.MONTH) + 1); //달을 구한다

		String day = df.format(calendar.get(Calendar.DATE)); //날짜를 구한다




		String hour = ""; //시간을 구한다

		if (calendar.get(Calendar.AM_PM) == Calendar.PM) {

			hour = df.format(calendar.get(Calendar.HOUR) + 12); //Calendar.PM이면 12를 더한다

		} else {

			hour = df.format(calendar.get(Calendar.HOUR));

		}




		String minute = df.format(calendar.get(Calendar.MINUTE)); //분을 구한다

		String second = df.format(calendar.get(Calendar.SECOND)); //초를 구한다




		String date = year + "-" + month + "-" + day + " " + hour + ":"+ minute+":" + second;




		return date;

	}
%>
	
	<div id ="wrapper">
	
		<div id="header">
			<a href="login.jsp">
			Saghistory
			</a>
		</div>

		<div id="center">
			
			<div id="login_div">
				<a href="index.jsp"><img src="image/main_title.png" alt="메인타이틀"/></a>
				<form action="checklog.jsp" method="post">
					<input onClick="id_click()" type="text" id="login_id" value="닉네임" name="login_id"/>
					<input onClick="pwd_click()" type="password" value="비밀번호" id="login_pwd" name="login_pwd"/>
					<input type="submit" id="login_submit" value="시작하기" name="login_id"
					style="cursor:pointer;width:253px;height:40px;font-family: 'Jeju Gothic';font-size:1em;
					background-color:rgba(0,120,250,1);border:0.2px solid rgba(0,120,250,1);color:white;"/>
				</form>
				<img src="image/main_title2.png" alt="메인타이틀2" 
				style="margin-top:1rem;width:100px;"/>
			</div>
		</div>
            
            <div id="notice_popup" onClick="closePopup()">
			<%
				SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				java.util.Date beginDate = df.parse("2017-03-13 00:00:00");
				java.util.Date endDate = df.parse(getDate());
				long diff = endDate.getTime() - beginDate.getTime();
				long diffTime = diff/(60*60*1000);
				long diffDay = diff/(24*60*60*1000)+1;
				
			%>
				<p>신애와 경호가 만난지 <%=diffDay %>일이 지났습니다.</p>
				<img onClick="closePopup()" src="image/btn_delete.png"/>
			</div>
		<div id="footer" style="position:absolute;display:block;text-align:center;bottom:0.3rem;left:0.3rem;margin:0 auto;">
			<p style="text-align:center;margin:0 auto;color:rgba(200,200,200,1);font-size:0.7em;"> Copyright (c) All Right is reserved. </p>
		</div>
	
	
	</div>
	<script>
		window.onload = function() {
		    setTimeout(function() {
		        window.scrollTo(0, 1);}, 100);
		};
	
		// addEventListener 이벤트
		window.addEventListener('load', function(){
		    setTimeout(scrollTo, 1);
		}, false);
		
		function id_click()
		{
			var id = document.getElementById("login_id");
			id.value = "";
		}
		function pwd_click()
		{
			var pwd = document.getElementById("login_pwd");
			pwd.value = "";
		}
		
		function closePopup()
		{
			var img = document.getElementById("notice_popup");
			img.style.display="none";
		}
		
		$("#login_submit").click(function(){
				for (var i=0; i<$("#login_id").val().length; i++)  { 
				    var chk = $("#login_id").val().substring(i,i+1); 
				    
				    if ($("#login_id").val() == "") {
				    	alert("이름을 정확히 입력해주세요");
				    	return;
				    }
				    
				    if(chk.match(/[0-9]|[a-z]|[A-Z]/)) { 
				    	alert("이름을 정확히 입력해주세요");
				        return;
				    }
				    if(chk.match(/([^가-힣\x20])/i)){
				    	alert("이름을 정확히 입력해주세요");
				        return;
				    }
				    if($("#login_id").val() == " "){
				    	alert("이름을 정확히 입력해주세요");
				        return;
				    }
				} 
		});
	</script>
    
</body>
</html>