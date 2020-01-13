<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js"></script>
</head>
<body>
	<%!public static String getDate() {

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
	
		if(request.getParameter("wr_bucket")==null||request.getParameter("wr_bucket").isEmpty())
		{
			String url = "jdbc:sqlserver://db_주소;databaseName=db_이름";
		
			String replytext="", commentDate="", username="";
			
			
			int idx = Integer.parseInt(request.getParameter("idx"));
			
			replytext = request.getParameter("wr_reply");
			username = request.getParameter("username");
			
			commentDate = getDate();
			
			ResultSet rs = null;
			String sql;
			Connection conn, conn2 = null;
			Statement stmt = null;
			StringBuffer sb = new StringBuffer();
			
			
			
			try
			{
				Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
				conn = DriverManager.getConnection(url, "db_아이디", "db_비밀번호");
				stmt = conn.createStatement();
			}
			catch(Exception e)
			{
				out.println("데이터베이스 접속에 문제가 발생.<hr>");
				out.println(e.getMessage());
				e.printStackTrace();
			}
			
			
			
			sql =   " insert into tbl_reply" +
					"(ReplyText, PicNum, UserName, WriteDate)" +
					" values ('" + replytext + "', " + idx + ", '" + username + "', '" + commentDate + "')";
			try
			{
				stmt.executeUpdate(sql);
			}
			catch(Exception e)
			{
				out.println("데이터베이스 삽입 연산이 실패하였습니다.<hr> ");
				out.println(e.getMessage());
				out.println(sql);
				e.printStackTrace();
			}
			
			response.sendRedirect("view.jsp?idx="+idx);
		}
		else
		{
			String url = "jdbc:sqlserver://db_주소;databaseName=db_이름";
			
			String buckettitle = request.getParameter("wr_bucket");
			
			ResultSet rs = null;
			String sql;
			Connection conn= null;
			Statement stmt = null;
			
			
			
			try
			{
				Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
				conn = DriverManager.getConnection(url, "db_아이디", "db_비밀번호");
				stmt = conn.createStatement();
			}
			catch(Exception e)
			{
				out.println("데이터베이스 접속에 문제가 발생.<hr>");
				out.println(e.getMessage());
				e.printStackTrace();
			}
			
			
			
			sql =   " insert into tbl_bucket" +
					"(buckettitle, bucketclear, UserName)" +
					" values ('" + buckettitle + "', 0, '" + "경호" + "')";
			try
			{
				stmt.executeUpdate(sql);
			}
			catch(Exception e)
			{
				out.println("데이터베이스 삽입 연산이 실패하였습니다.<hr> ");
				out.println(e.getMessage());
				out.println(sql);
				e.printStackTrace();
			}
			
			response.sendRedirect("movie.jsp");
		}
	%>
	
		

	
	
</body>
</html>