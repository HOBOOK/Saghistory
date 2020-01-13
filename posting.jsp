<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.servlet.http.HttpServlet" %>
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
		String title="", context="";
		String picaddress="", createID="", writedate="";
		int boardNum = 0;
		int contentNum = 0;
		int delpostNum;
		
		int maxSize = 1920*1080*5;
		String encType = "UTF-8";
		
		String realFolder = "";
		String filename = "";
		String savefile = "image/thum";
		ServletContext scontext = getServletContext();
		realFolder = scontext.getRealPath(savefile);
		
		String EndingMsg = "";
		
		/* File targetDir = new File("E:/db_아이디istory_web/db_아이디istory_web/WebContent" + savefile);  
		  
		if(!targetDir.exists()) 
		{
			targetDir.mkdirs();
		}  */
		if(request.getParameter("delpostNum")!=null)
		{
			delpostNum = Integer.parseInt(request.getParameter("delpostNum"));
		}
		else
		{
			delpostNum = 0;
		}
		try
		{
	 		/* MultipartRequest multi=new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
	 		
		 	Enumeration<?> files = multi.getFileNames();
		    String file = (String)files.nextElement();
		    filename = multi.getFilesystemName(file); */
		    createID = request.getParameter("creator");
			writedate = getDate();
			
			title = request.getParameter("post_title");
			context = String.valueOf(request.getParameter("ir1"));
			boardNum = Integer.parseInt(request.getParameter("selOpt"));
			contentNum = Integer.parseInt(request.getParameter("updatecontextnum2"));
			
		} 
		catch(Exception e) 
		{
		  	e.printStackTrace();
		}
	

		picaddress = savefile + "/" + filename;

	
	
	
		/////데이터베이스/////
		String url = "jdbc:sqlserver://db_주소;databaseName=db_이름";
	
	
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
		
		context = context.replaceAll("'", "`" );
		context = context.replaceAll("\"", "\\\"");
		
		if(contentNum==0) //작성
		{
			if(delpostNum==0)
			{
				sql = 	" insert into tbl_context" +
						"(BoardNum, CreateID, Title, Context, ViewCount, WrittenDate, AccessLevel, IsView)" +
						" values (" + boardNum + ", '"+createID+"', '" + title + "', '" + context + "', 0, '"+writedate +"', 0, 1)";
				
			}
			else //삭제
			{
				sql = "delete from tbl_context where ContentNum = " + delpostNum; 
				
			}
			
		}
		else //수정
		{
			sql = " update tbl_context set BoardNum = " + boardNum + ", Title = '" + title + "', Context ='" + context + "' where ContentNum = " + contentNum;
			
		}
		
		
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
		
		out.println("<script>window.open('work.jsp','_parent')</script>");
	%>

</body>
</html>