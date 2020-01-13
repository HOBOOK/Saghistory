<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="com.oreilly.servlet.MultipartRequest,com.oreilly.servlet.multipart.DefaultFileRenamePolicy,java.util.*,java.io.*" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<%
		request.setCharacterEncoding("utf-8");
		
		String USER = (String)session.getAttribute("UserID");
	
		
		int maxSize = 1024*1024*5;
		String encType = "UTF-8";
		
		String realFolder = "";
		String filename1 = "";
		String savefile = "image/profile/";
		String realFileName = "";
		ServletContext scontext = getServletContext();
		realFolder = scontext.getRealPath(savefile);
		
		File targetDir = new File("D:/db_아이디istory/" + savefile);  
		  
		if(!targetDir.exists()) 
		{
			targetDir.mkdirs();
		} 
		
		try
		{
	 		MultipartRequest multi=new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
	 		
		 	Enumeration<?> files = multi.getFileNames();
		    String file1 = (String)files.nextElement();
		    filename1 = multi.getFilesystemName(file1);
		    
		    int i = -1;
	        i = filename1.lastIndexOf("."); 
		    realFileName = USER + filename1.substring(i, filename1.length()); 

		    
		    File oldFile = new File("D:/db_아이디istory/" + savefile + filename1);
		    File newFile = new File("D:/db_아이디istory/" + savefile + realFileName); 
		    
		    File f = new File("D:/db_아이디istory/" + savefile + realFileName); // 파일 객체생성
		    if( f.exists()) f.delete(); 

		    oldFile.renameTo(newFile); // 파일명 변경 
		    
			
		} 
		catch(Exception e) 
		{
		  	e.printStackTrace();
		}
	

		String fullpath = savefile + realFileName;
		
		if(fullpath.equals("image/profile/null"))
		{
			fullpath = "";
		}
		
	
	
	
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
		
		
		
		
		sql = "update tbl_user set ProfileImage='" + fullpath + "' where ID='" + USER  +"'";
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
		
		out.println("<script>window.open('http://www.db_아이디istory.xyz/work.jsp','_parent')</script>");
	%>

</body>
</html>