<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.net.*" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=0,maximum-scale=10,user-scalable=0">
<link rel="stylesheet" href="write.css">
<script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
</head>
<body>
	<form action="insert.jsp" method="post" enctype="multipart/form-data">
		<div>
		<table id="tb_cover">
			<tr>
				<td>
					<table>
						<tr style="text-align:center;">
							<td width="5">&nbsp;</td>
							<td><h2>사진올리기</h2></td>
							<td width="5">&nbsp;</td>
						</tr>
					</table>
			     	<table>
						<tr>
							<td align="center">제목</td>
							<td>
								<input type="text" name="title" size="30" maxlength="30" required autocomplete="off">
							</td>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td align="center">카테고리</td>
							<td>
								<select id="selOpt" name="selOpt" onChange="chDomain(this.value);">
								<%
									Connection conn = null;
									Statement stmtcate =null;
							
									try
									{
										Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
										String url = "jdbc:sqlserver://db_주소;databaseName=db_이름";
										conn = DriverManager.getConnection(url, "db_아이디", "db_비밀번호");
										stmtcate = conn.createStatement();
										
										String sqlcate = "select * from tbl_Categorization where UserName = '경호'";
										ResultSet rscate = stmtcate.executeQuery(sqlcate);
										while(rscate.next())
										{
											String category = rscate.getString("Category");
										%>
                     						 <option value="<%=category%>"><%=category%></option>
                     				 <%
										}
                     				 	rscate.close();
                     				 	stmtcate.close();
                     				 	conn.close();
									}
                     				 catch(Exception e)
                     				 {
                     					out.println("데이터베이스 접속에 문제가 발생.<hr>");
                     					out.println(e.getMessage());
                     					e.printStackTrace();
                     				 }
                     				 %>
                   				 </select>
							</td>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td><div id="thumImg"></div></td>
							<td>&nbsp;</td>
						</tr>
					</table>
					<div class="slide">
						<table>
							<tr>
								<td>
									<div class="filebox">
										<input id="selFile" class="upload-name" value="사진첨부" disabled="disabled">
										<label for="picFile">업로드</label>
										<input id="picFile" type="file" name="filename" onChange="viewImg();" class="upload-hidden">
									</div>
								</td>
							</tr>
							<tr>
								<td><div id="contentImg"></div>
									<textarea name="context" rows="3" cols="35" maxlength="100" required autocomplete="off"></textarea>
								</td>
							</tr>
						</table>
					</div>
					
				</td>
				<tr align="center">
					<td colspan="2">
					<input type="submit" value="등록" class="btnCreate">
					<td>&nbsp;</td>
				</tr>
			</tr>
		</table>
		</div>
	</form>  
	
	
	<script>
		function chDomain(val) 
		{
			document.form.selOpt.value = val;
		}
		
		var upload = document.getElementById('picFile');
	    var holder = document.getElementById('contentImg');


		function viewImg() 
		{
	  		var file = upload.files[0];
	    	reader = new FileReader();
	  	
	  		reader.onload = function (event) 
	  		{
	    		var img = new Image();
	    		img.src = event.target.result;

	    		img.id="thumimg";
	    		holder.innerHTML = '';
	    		holder.appendChild(img);
	  		};
	  		reader.readAsDataURL(file);
	  		document.getElementById('selFile').value = file.name;
		};
	</script>
</body>
</html>