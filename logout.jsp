<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<head>
<title>Insert title here</title>
</head>
<body>
	<%

		String USER = (String)session.getAttribute("UserID");
		int site=0;
		
		if(request.getParameter("site")!=null)
		{
			site=Integer.parseInt(request.getParameter("site"));
		}
		else
		{
			site=0;
		}
		
		if(USER != null)
		{
			session.invalidate();
			
		}
		else
		{
			
		}
		
		if(site==1)
		{
			response.sendRedirect("http://www.saghistory.xyz/work.jsp");
		}
		else
		{
			response.sendRedirect("http://www.saghistory.xyz");
		}
		
		

		%>
	

</body>
</html>