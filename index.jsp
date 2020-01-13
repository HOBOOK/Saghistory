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

<link rel="stylesheet" href="index.css">
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
	<div id ="wrapper">
	<%
	
	String USER = "";
	USER = (String)session.getAttribute("UserID");
						
	%>
		<div id="header">
			<a href="index.jsp">
			<img id="header_logo" src="image/logo_1.png" alt="헤더로고이미지"/>
			</a>
			
		<%
		if(USER == null || USER.equals(""))
		{
		%>
			<a id="btn_login" href="login.jsp">
			로그인
			</a>
		<%
		}
		else
		{
		%>
			<a id="btn_login" href="logout.jsp">
			로그아웃
			</a>
		<%
		}
		%>
		
		<br/>
		<div id="menu">
			<ul>
				<li class="menu">
					<a href="index.jsp">db_아이디istory</a>
					<ul class="hide">
						<li><a href="index.jsp">홈</a></li>
						<li><a href="index.jsp">정보</a></li>
					</ul>
				</li>
				<li class="menu">
					<a href="movie.jsp">movehistory</a>
					<ul class="hide">
						<li><a href="movie.jsp">홈</a></li>
						<li><a href="movie.jsp">영화기록</a></li>
						<li><a href="movie.jsp">버킷리스트</a></li>
						<li><a href="movie.jsp">여행지도</a></li>
					</ul>
				</li>
				<li class="menu">
					<a href="work.jsp">workistory</a>
					<ul class="hide">
						<li><a href="work.jsp">홈</a></li>
						<li><a href="work.jsp">정보</a></li>
					</ul>
				</li>
				<li class="menu">
					<a href="info.jsp">info</a>
				</li>
			</ul>
		</div>
		</div>
		
		
		
		
		
		<div id="center">
		
		
		<div class = "thumnail" id="thumnail">
			<img id="thum_image" src ="image/thum/profile.jpg" alt=""/>
			<br />
			<img id="thum_logo2" src="image/logo_2.png" alt=""/>
			
			<%
			if(USER != null)
			{
			%>
			
			<div class="balloon">
			<a href="#upload" class="uploadframe">
			업로드
			</a>
			</div>
			
			<%
			}
			else
			{
				
			}
			%>
			
			
			<a href="movie.jsp" id="go_movie">뭅히스토리 ></a>
		</div>
		
		
		
		
		
		<div id="center_album">
		<nav>
			<ol>
			
		<%
		int scrollcnt = 0;
		
		Connection conn = null;
		Statement stmt=null;
		Statement stmtcate =null;
		

		try
		{
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			String url = "jdbc:sqlserver://db_주소;databaseName=db_이름";
			conn = DriverManager.getConnection(url, "db_아이디", "db_비밀번호");
			stmt = conn.createStatement();
			stmtcate = conn.createStatement();
			
			
				
			String sqlcate = "select * from tbl_Categorization where UserName = '경호'";
			ResultSet rscate = stmtcate.executeQuery(sqlcate);
			while(rscate.next())
			{
				String category = rscate.getString("Category");
				String categoryEnc = URLEncoder.encode(category, "UTF-8");
				%>
				
					<li id="li_category"><a href="index.jsp?category=<%=categoryEnc%>">#<%=category %></a>
						<img onClick="return category_delete(this.name);"name=<%=categoryEnc %> id="del_category" class="del_category" src="image/btn_delete.png"/>
					</li>
				<%
			}
			rscate.close();
			stmtcate.close();
			
			%>
				<li id="form_category">
				<form  action="add.jsp" method="post" >
					#<input id ="txt_category" name="txt_category" type="text" maxlength="5"/>
				</form>
				</li>
			
			<li><a onClick="category_option()"><img id="btn_plus" src="image/btn_plus.png"/></a></li>
			</ol>
			
		</nav>
			<%
			String sql ="";
			String category;
			

			if(request.getParameter("category")!=null)
			{
				category = URLDecoder.decode(request.getParameter("category"), "UTF-8");
				sql = "select * from tbl_picture where UserName = '경호' and Category = '"+ category +"' order by UploadDate desc";
			}
			else
			{
				sql = "select * from tbl_picture order by UploadDate desc";
			}

			ResultSet rs = stmt.executeQuery(sql);
			
			String tempdate = "";
			
			while(rs.next())
			{
				
				scrollcnt++;
				int idx = Integer.parseInt(rs.getString("PicNum"));
				String imgsrc = rs.getString("PicAddress");
				String username = rs.getString("UserName");
				String uploaddate = rs.getString("UploadDate");
				String title = rs.getString("Title");
				if(scrollcnt<10)
				{
					%>
						<div class="pagediv" id=page<%=scrollcnt %> style="display:inline;">
					<%
					if(tempdate.equals(uploaddate.substring(5,7)))
					{
					}
					else
					{
						%>
						
							<p style="font-size:1.2rem;text-align:center;margin-top:1rem; margin-bottom:1rem;">
								<%=uploaddate.substring(5,7) %>월
							</p>
						<%
						
					}
					tempdate = uploaddate.substring(5,7);
					
					%>
						<figure class="viewcover">		
							<a class="viewframe" href="#s" id="<%=idx %>">
								<img id="fig_thum_img" src="<%=imgsrc%>"/>
								<div id="viewp"><p><%=title %></p></div>
							</a>										
						</figure>
						</div>
					<%
				}
				else
				{
					%>
						<div class="pagediv" id=page<%=scrollcnt %> style="display:none;">
					<%
						if(tempdate.equals(uploaddate.substring(5,7)))
						{
						}
						else
						{
							%>
							
								<p style="font-size:1.2rem;text-align:center;margin-top:1rem; margin-bottom:1rem;">
									<%=uploaddate.substring(5,7) %>월
								</p>
							<%
							
						}
						tempdate = uploaddate.substring(5,7);
					
					%>
						<figure class="viewcover">		
							<a class="viewframe" href="#s" id="<%=idx %>">
								<img id="fig_thum_img" src="<%=imgsrc%>"/>
								<div id="viewp"><p><%=title %></p></div>
							</a>										
						</figure>
						</div>
					<%
				}
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
		<div onClick="deobogi();" id="list_deobogi" style="text-align:center;cursor:pointer;">
			<p >더보기</p>
		</div>
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
		<div id="footer">
		
		
		</div>
	
	
	</div>
	<script src="view.js"></script>
	<script>
		window.onload = function() {
		    setTimeout(function() {
		        window.scrollTo(0, 1);}, 100);
		};
	
		// addEventListener 이벤트
		window.addEventListener('load', function(){
		    setTimeout(scrollTo, 1);
		}, false);
		
		
		
		$(document).ready(function(){
		    $(".menu>a").mouseover(function(){
		        var submenu = $(this).next("ul");
		        if( submenu.is(":visible") ){
		            submenu.slideUp();
		        }else{
		            submenu.slideDown();
		        }
		    });
		   
		});
		
		function input_category()
		{
			if(event.keyCode==13){
				var strC = document.getElementByName('txt_category').value;
				alert(strC);
				location.href="add.jsp?categoryid=" + strC;
			}
		}
		function closePopup()
		{
			var img = document.getElementById("notice_popup");
			img.style.display="none";
		}

		function category_option()
		{
			var del = document.getElementsByClassName("del_category");
			var frm = document.getElementById('form_category');
			var frmtxt = document.getElementById('txt_category');
			for(var i=0; i<del.length; i++){
				if(del[i].style.display=="none"){
					del[i].style.display="block";
				}
				else{
					del[i].style.display="none";
				}	
			}
			if(frm.style.display=="none"){
				frm.style.display="inline-block";
			}
			else{
				frm.style.display="none";
			}
			frmtxt.focus();
			
			
		}
		function category_delete(name)
		{
			var del = confirm("카테고리를 삭제합니다.");
			if(del==true){
				location.href="delete.jsp?categoryid=" + name;
			}
			else{
				return false;
			}
			
		}
		
		function deobogi()
		{
			var del = document.getElementsByClassName("pagediv");
			var pagecnt = 0;
			for(var i=1; i <del.length+1; i++){
				var page = document.getElementById('page'+i);
				if(page.style.display=="inline"){
					pagecnt = i;
				}
				if(page.style.display=="none"){
					if(i>pagecnt&&i<pagecnt+9){
						page.style.display="inline";
					}
				}
			}
		}
		
		jQuery(document).ready(function () {
			jQuery(window).scroll(function() {	
				
				if (jQuery(window).scrollTop() == jQuery(document).height() - jQuery(window).height()) {				
					var del = document.getElementsByClassName("pagediv");
					var pagecnt = 0;
					for(var i=1; i <del.length+1; i++){
						var page = document.getElementById('page'+i);
						if(page.style.display=="inline"){
							pagecnt = i;
						}
						if(page.style.display=="none"){
							if(i>pagecnt&&i<pagecnt+9){
								page.style.display="inline";
							}
						}
					}				
				 }
			});
		});
	</script>
    
</body>
</html>