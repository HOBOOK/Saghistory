<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="viewport" content="initial-scale=1.0; maximum-scale=1.0; minimum-scale=1.0; user-scalable=no;" /> 
<link rel="stylesheet" href="view.css">
<script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>

<title>신애 경호 이야기♪ db_아이디istory</title>
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
<%
	int idx = Integer.parseInt(request.getParameter("idx"));
	Connection conn = null;
	Statement stmt=null;
	Statement stmt2=null;
	
	try
	{
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		String url = "jdbc:sqlserver://db_주소;databaseName=db_이름";
		conn = DriverManager.getConnection(url, "db_아이디", "db_비밀번호");
		stmt = conn.createStatement();
	
		String sql = "select * from tbl_picture where PicNum=" +idx;
		ResultSet rs = stmt.executeQuery(sql);
		while(rs.next())
		{
			String imgsrc = rs.getString("PicAddress");
			String username = rs.getString("UserName");
			String uploaddate = rs.getString("UploadDate");
			
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			java.util.Date beginDate = df.parse(uploaddate);
			java.util.Date endDate = df.parse(getDate());
			long diff = endDate.getTime() - beginDate.getTime();
			long diffTime = diff/(60*60*1000);
			long diffDay = diff/(24*60*60*1000);
			%>
			<div id="content">
				<div id="div_1">
					<div class="img_wrapper">
					<img id="imgview" src="<%=imgsrc %>"/>
					</div>
				</div>
				<div id="div_2">
						<div id="con_thum">
							<img class="con_thum_img" src="image/thum/profile.jpg">
							<p><%=username %></p>
							<% 
								if(diffTime<48)
								{
							%>
									<h5><%=diffTime %>시간 전</h5>
							<%
								}
								else
								{
							%>
									<h5><%=diffDay %>일 전</h5>
							<%
								}
							%>
						</div>
					
						<div id="con_reply">
						
						<%
						
						
						stmt2 = conn.createStatement();
						String sql2 = "select * from tbl_reply where PicNum=" +idx +"order by WriteDate desc";
						ResultSet rs2 = stmt2.executeQuery(sql2);
						while(rs2.next())
						{
							String replytext = rs2.getString("ReplyText");
							String rp_username = rs2.getString("UserName");	
							
						%>
							<%=rp_username %> #<%=replytext %> 
						<%
						}
						stmt2.close();
						rs2.close();
						%>
						</div>
						
						
				</div>
				
				<div id="div_3">
					<img class="con_thum_img" src="image/thum/profile.jpg">
					<p><%=username %></p>
					<form action="regreply.jsp" method="post">
						<div id="div_reply">
						<input id="wr_reply" type="text" name="wr_reply">
						<input value="<%=idx %>" type="hidden" name="idx">
						<input value="<%=username %>" type="hidden" name="username">
						<input onClick="return checklength();" id="btn_reply" type="submit" name="btn_reply" value="새그달기"/>
						</div>
					</form>
					
				</div>
				
				
			</div>
			<%
		}
		rs.close();
		stmt.close();
		conn.close();
	}
	catch(Exception e)
	{
		out.println("데이터베이스 접속에 문제가 발생.<hr>");
		out.println(e.getMessage());
		e.printStackTrace();
	}
%>
	<script>
		window.onload = function() {
		    setTimeout(function() {
		        window.scrollTo(0, 1);}, 100);
		};
	
		// addEventListener 이벤트
		window.addEventListener('load', function(){
		    setTimeout(scrollTo, 1);
		}, false);
		
		function checklength()
		{
			var str = document.getElementById("wr_reply").value;
			
			if(str.length<5)
			{
				alert("5자 이상 입력");
				document.getElementById("wr_reply").value = "";
				document.getElementById("wr_reply").focus();
				return false;
			}
			return true;
		}
		
		var content = document.getElementById('con_reply').innerHTML;
		var splitedArray = content.split(' ');
		var linkedContent = '';
		for(var word in splitedArray)
		{
		  word = splitedArray[word];
		   if(word.indexOf('#') == 0)
		   {
		      word = "<a href=/tags/" + word.substring(1,word.length) +">"+word+ "</a>";
		   }
		   linkedContent += word+' ';
		}
		document.getElementById('con_reply').innerHTML = linkedContent; 
		
	</script>
</body>
</html>