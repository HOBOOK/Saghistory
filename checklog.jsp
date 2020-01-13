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
<meta property="og:title" content="db_아이디istory">
<meta property="og:description" content="연인간의 사진공유 와 같이만드는 기록장">
<meta property="og:image" content="http://www.db_아이디istory.xyz/image/logo_1.png">
<meta property="og:url" content="http://www.db_아이디istory.xyz">

<meta name="twitter:card" content="summary">
<meta name="twitter:title" content="페이지 제목">
<meta name="twitter:description" content="페이지 설명">
<meta name="twitter:image" content="http://www.db_아이디istory.xyz">
<meta name="twitter:domain" content="사이트 명">

<link rel="stylesheet" href="login.css">
<script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>


<script type="text/javascript" src="http://code.jquery.com/jquery-1.7.min.js"></script>
<script type="text/javascript" src="jquery.smartPop.js"></script>
<link href="styles/ihover.css" rel="stylesheet">
<link rel="stylesheet" href="jquery.smartPop.css" />
<link rel="canonical" href="http://www.db_아이디istory.xyz/index.jsp">

<title>db_아이디istory</title>
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

	request.setCharacterEncoding("utf-8");
	String id = request.getParameter("login_id");
	String pwd = request.getParameter("login_pwd");

	Connection conn = null;
	Statement stmt=null;

	try
	{
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		String url = "jdbc:sqlserver://db_주소;databaseName=db_이름";
		conn = DriverManager.getConnection(url, "db_아이디", "db_비밀번호");
		stmt = conn.createStatement();
	}
	catch(Exception e)
	{
		out.println("데이터베이스 접속에 문제가 발생.<hr>");
		out.println(e.getMessage());
		e.printStackTrace();
	}

	String sql;

	sql = "select * from tbl_user where ID = '" + id + "' and Pwd = HashBytes('SHA1','" + pwd + "')";

	ResultSet rs = stmt.executeQuery(sql);

	int isLog = 0;
	if(rs.next())
	{
		//로그인 성공 시 session 객체 값 저장
		session.setAttribute("UserID", id);
	
		isLog = 1;
		
		String sqlVisit = "update tbl_user set LogDate = '" + getDate() + "' where ID ='" + id + "'";
		Statement stmtVisit = conn.createStatement();
		
		try
		{
			stmtVisit.executeUpdate(sqlVisit);
		}
		catch(Exception e)
		{
			
			out.println("데이터베이스 업데이트 문제");
		}
		stmtVisit.close();
	}
	else
	{
		%>
		<script>
			alert("아이디, 비밀번호를 다시 확인해주세요.");
		</script>
		<%
	}

	if(stmt!=null)
		stmt.close();
	if(conn!=null)
		conn.close();

	if(isLog == 1)
	{
		response.sendRedirect("http://www.db_아이디istory.xyz");
	}
	else
	{
		response.sendRedirect("login.jsp");
	}
%>	
</body>
</html>