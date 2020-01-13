<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.servlet.http.HttpServlet" %>
<%@page import="java.net.URLDecoder"%>
<%@ page import="java.io.*" %>
<%@ page import="com.oreilly.servlet.MultipartRequest,com.oreilly.servlet.multipart.DefaultFileRenamePolicy,java.util.*,java.io.*" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
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
		/*String MemID = (String)session.getAttribute("MemID");

		if(MemID == null || MemID.equals(""))
		{
			out.println("<script>alert('로그인이 필요합니다.');</script>"); 
			out.println("<script>window.open('login/login.jsp','_parent')</script>");
			return;
		}
		*/
		request.setCharacterEncoding("utf-8");
		
		String categoryid = URLDecoder.decode(request.getParameter("txt_category"), "UTF-8");
		
	
		/////데이터베이스/////
		String url = "jdbc:sqlserver://ipaddress;databaseName=dbname";
	
	
		ResultSet rs = null;
		String sql ="";
		Connection conn= null;
		Statement stmt = null;
		StringBuffer sb = new StringBuffer();
		
		try
		{
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			conn = DriverManager.getConnection(url, "db_id", "db_pwd");
			stmt = conn.createStatement();
		}
		catch(Exception e)
		{
			out.println("데이터베이스 접속에 문제가 발생.<hr>");
			out.println(e.getMessage());
			e.printStackTrace();
		}
		
		
		
		
		try
		{
			sql = 	"Insert into tbl_categorization (Category, UserName)" +
					" values ('" + categoryid + "', '경호')";
			stmt.executeUpdate(sql);
		}
		catch(Exception e)
		{
			out.println("데이터베이스 삭제 연산이 실패하였습니다.<hr> ");
			out.println(e.getMessage());
			out.println(sql);
			e.printStackTrace();
		}
		
		out.println("<script>window.open('index.jsp','_parent')</script>");
	%>

</body>
</html>