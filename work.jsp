<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLDecoder"%>
<%@ page import="java.security.*" %>
<%@ page import="com.oreilly.servlet.MultipartRequest,com.oreilly.servlet.multipart.DefaultFileRenamePolicy,java.util.*,java.io.*" %>



<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
<link rel="stylesheet" href="work.css">
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.7.min.js"></script>
<script type="text/javascript" src="jquery.smartPop.js"></script>
<script type="text/javascript"
	src="posting/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script src="posting/photo_uploader/plugin/hp_SE2M_AttachQuickPhoto.js" type="text/javascript" charset="utf-8"></script>

<link href="styles/ihover.css" rel="stylesheet">
<link rel="stylesheet" href="jquery.smartPop.css" />

<link href="http://vjs.zencdn.net/c/video-js.css" rel="stylesheet" />

<script src="http://vjs.zencdn.net/c/video.js"></script>

<title>신애 경호 이야기♪ db_아이디istory</title>
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

		String date = year + "-" + month + "-" + day + " " + hour + ":" + minute + ":" + second;

		return date;

	}%>
	<%!
    public class CEncrypt
    {
        MessageDigest md;
        String strSRCData = "";
        String strENCData = "";

        public CEncrypt(){}
        //인스턴스 만들 때 한방에 처리할 수 있도록 생성자 중복시켰습니다. 
        public CEncrypt(String EncMthd, String strData)
        {
            this.encrypt(EncMthd, strData);
        }

        //암호화 절차를 수행하는 메소드입니다.
        public void encrypt(String EncMthd, String strData)
       {
           try
          {
              MessageDigest md = MessageDigest.getInstance(EncMthd); // "MD5" or "SHA1"
             byte[] bytData = strData.getBytes();
             md.update(bytData);

             byte[] digest = md.digest();
             for(int i =0;i<digest.length;i++)
             {
                 strENCData = strENCData + Integer.toHexString(digest[i] & 0xFF).toUpperCase();
             }
           }catch(NoSuchAlgorithmException e)
          {
             System.out.print("암호화 알고리즘이 없습니다.");
          };
        
          //나중에 원본 데이터가 필요할지 몰라서 저장해 둡니다.
          strSRCData = strData;
        }

        //접근자 인라인 함수(아니, 메소드)들입니다.
        public String getEncryptData(){return strENCData;}
        public String getSourceData(){return strSRCData;}

        //데이터가 같은지 비교해주는 메소드입니다.
        public boolean equal(String strData)
        {
          //암호화 데이터랑 비교를 하던, 원본이랑 비교를 하던 맘대로....
          if(strData == strENCData) return true;
          return false;
        }
    }    //CEncrypt
%>
	
	<div id="wrapper">

		<%
			String USER = null;
			String IP = "";
			USER = (String) session.getAttribute("UserID");
			IP = request.getRemoteAddr();
			

			String USER_PROFILE_IMAGE = "";

			if (USER != null) {
				String url = "jdbc:sqlserver://db_주소;databaseName=db_이름";

				ResultSet rsI = null;
				String sqlI;
				Connection connI = null;
				Statement stmtI = null;

				try {
					Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
					connI = DriverManager.getConnection(url, "db_아이디", "db_비밀번호");
					stmtI = connI.createStatement();
				} catch (Exception e) {
					out.println("데이터베이스 접속에 문제가 발생.<hr>");
					out.println(e.getMessage());
					e.printStackTrace();
				}

				sqlI = "select * from tbl_user where ID = '" + USER + "'";
				rsI = stmtI.executeQuery(sqlI);
				try {
					while (rsI.next()) {
						USER_PROFILE_IMAGE = rsI.getString("ProfileImage");
					}
				} catch (Exception e) {
					out.println(e.getMessage());
					out.println(sqlI);
					e.printStackTrace();
				}
			}
		%>

		<div id="header">
			<div id="header_top">
				<img id="menu_m" src="image/menu_1_b.png" onClick="viewMenu()" />
				<img id="menu2_m" src="image/menu_2_m.png" onClick="mobileOnList();"/>

				<div id="webLogo">
					<a href="work.jsp"> <img id="header_logo" src="image/logo_6.png"
						alt="헤더로고이미지" />
					</a>
				</div>
				<div id="mLogo">
					<a href="work.jsp"> <img id="header_logo"
						style="height: 20px; margin-top:-3px;" src="image/logo_6.png"
						alt="헤더로고이미지" />
					</a>
				</div>
			</div>
			

			<%
				if (USER != null) {
			%>
			<a id="btn_login" href="logout.jsp?site=1">로그아웃</a>
			<%
				} else {
			%>
			<a id="btn_login" href="login.jsp?site=1">로그인</a>
			<%
				}
			%>
			<div id="menu" >
			<img id="menuclose" onClick="viewMenu()" src="image/btn_close_b.png"/>
				<ul>
					<li class="menu"><a href="index.jsp">db_아이디istory</a>
						<ul class="hide">
							<li><a href="index.jsp">홈</a></li>
							<li><a href="index.jsp">정보</a></li>
						</ul></li>
					<li class="menu"><a href="movie.jsp">movehistory</a>
						<ul class="hide">
							<li><a href="movie.jsp">홈</a></li>
							<li><a href="movie.jsp">영화기록</a></li>
							<li><a href="movie.jsp">버킷리스트</a></li>
							<li><a href="movie.jsp">여행지도</a></li>
						</ul></li>
					<li class="menu"><a href="work.jsp">workistory</a>
						<ul class="hide">
							<li><a href="work.jsp">홈</a></li>
							<li><a href="work.jsp">정보</a></li>
						</ul></li>
					<li class="menu"><a href="info.jsp">info</a></li>
				</ul>
			</div>
			<%
				if (USER == null || USER.equals("")) {
			%>
			<div id="mobile_nav">
				<img id="profilePic_m" src="image/profile/unKnown.jpg" />
				<p
					style="text-align: center; height: 20px; color: rgba(255, 255, 255, 0.8); margin-bottom: 0;">손님</p>
				<a
					style="font-size: 0.55em; border-radius: 0.15rem; color: white; background-color: yellow; color: black; padding: 0.3em; margin-top: 0; margin-bottom: 1rem; text-align: center;"
					href="login.jsp">로그인</a>
				<div id="mobile_nav_in">
					<a style="text-decoration: none;" href="#mobileList"
						onClick="mobileOnList();"> <img
						style="width: 30px; height: 30px;" src="image/list_1_w.png" />
					</a>
				</div>
				<br />
			</div>
			<%
				} else {
			%>
			<div id="mobile_nav">

				<img id="profilePic_m" src="<%=USER_PROFILE_IMAGE%>" />
				<p
					style="text-align: center; height: 20px; color: rgba(255, 255, 255, 0.8); margin-bottom: 0;"><%=USER%></p>
				<a
					style="font-size: 0.55em; border-radius: 0.15rem; color: white; background-color: yellow; color: black; padding: 0.3em; margin-top: 0; text-align: center;"
					href="logout.jsp?site=1">로그아웃</a>
				<div id="mobile_nav_in">
					<a style="text-decoration: none;" href="?bnum=100"> <img
						style="width: 30px; height: 30px;" src="image/btn_writepost_w.png" />
					</a> <a style="text-decoration: none;" href="?bnum=101"> <img
						style="width: 30px; height: 30px;"
						src="image/btn_optionpost_w.png" />
					</a> <a style="text-decoration: none;" href="#mobileList"
						onClick="mobileOnList();"> <img
						style="width: 30px; height: 30px;" src="image/list_1_w.png" />
					</a> <br /> <br />
				</div>

			</div>
			<%
				}
			%>
		</div>





		<div id="center">
			<div id="main_header">
				<%
				SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				java.util.Date beginDate = df.parse("2017-03-13 00:00:00");
				java.util.Date endDate = df.parse(getDate());
				long diff = endDate.getTime() - beginDate.getTime();
				long diffTime = diff / (60 * 60 * 1000);
				long diffDay = diff / (24 * 60 * 60 * 1000) + 1;
				%>
				<img onClick="mhclose()" style="cursor:pointer;position:absolute;right:1rem;top:1rem;width:14px;height:14px;" src="image/btn_close_b.png"/>
				<p style="font-size:0.9rem;">
				신애와 경호가 포스팅하는 블로그 Workhistory<br/>신애와 경호가 만난지 <span style="font-size:1rem;color:rgba(0,170,200,1);"><%=diffDay%></span> 일이 지났습니다.
				</p>
			</div>

			<div id="center_album">

				<nav id="nav">
					<img id="navclose" onClick="mobileOnList();" src="image/btn_close_b.png"/>
					<div id="mobile_cover_in">
					<div id="mobile_cover">
					
					<div id="profilediv">
						<img id="profilePic" src="image/profile/db_아이디.jpg" />

						<%
							if (USER != null) {
						%>

						<img
							style="position: absolute; display: block; left: 100px; top: 100px; width: 60px; height: 60px; border-radius: 100%;"
							id="userPic" src="<%=USER_PROFILE_IMAGE%>" />
						<p
							style="position: absolute; left: 0; top: 150px; text-align: center; width: 260px; height: 20px; color: rgba(255, 255, 255, 0.8);"><%=USER%></p>
						<a href="?bnum=100"> <img id="profilewrpost"
							src="image/btn_writepost_w.png" />
						</a> <a href="?bnum=101"> <img id="profileoppost"
							src="image/btn_optionpost_w.png" />
						</a>
						<%
							} else {
						%>
						<img
							style="position: absolute; display: block; left: 100px; top: 100px; width: 60px; height: 60px; border-radius: 100%;"
							id="userPic" src="image/profile/unKnown.jpg" />
						<p
							style="position: absolute; left: 0; top: 150px; text-align: center; width: 260px; height: 20px; color: rgba(255, 255, 255, 0.8);">손님</p>
						<a
							style="font-size: 0.7em; border-radius: 0.15rem; color: white; position: absolute; left: 0; bottom: 40px; margin-left: 112px; margin-bottom: 0.5rem; background-color: yellow; color: black; padding: 0.3em; text-align: center;"
							href="login.jsp">로그인</a>
						<%
							}
						%>
					</div>

					
					<div id="searchdiv">
						<form action="search.jsp" method="post">
							<input type="text" id="search_keyword" name="search_keyword"
								style="float: left; width: 218px; height: 20px; margin: 0; border: none; margin-top: 6px; margin-left: 5px; border-radius: 0.15rem;" />
							<input type="image" id="search_submit" name="search_submit"
								value="검색" src="image/search_1_w.png"
								style="float: left; width: 20px; height: 20px; margin-left: 5px; margin-top: 7px; border: none; background-color: rgba(0, 100, 150, 0.9); color: white; font-family: 'Jeju Gothic'; font-size: 0.8em; cursor: pointer;" />
						</form>
					</div>

					<div id="category">
						<ul style="list-style: none; position: relative;">
							<li class="li_category"><a style="color: white;"
								href="work.jsp">전체보기</a></li>
							<%
								Connection conn = null;
								Statement stmt = null;
								Statement stmtin = null;
								try {
									Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
									String url = "jdbc:sqlserver://db_주소;databaseName=db_이름";
									conn = DriverManager.getConnection(url, "db_아이디", "db_비밀번호");
									stmt = conn.createStatement();

									String sql = "select * from tbl_boardCategory order by Sequence asc";
									ResultSet rs = stmt.executeQuery(sql);
									while (rs.next()) {
										String title = rs.getString("BoardCategory");
										int boardCategoryNum = Integer.parseInt(rs.getString("BoardCategoryNum"));

										switch (boardCategoryNum) {
											default : //일반게시판
							%>
							<li class="li_category"><p><%=title%></p>
								<ul class="sub_category">
									<%
										try {
															stmtin = conn.createStatement();
															String sqlin = "select * from tbl_board where BoardCategory =" + boardCategoryNum;
															ResultSet rsin = stmtin.executeQuery(sqlin);

															while (rsin.next()) {
																String titlein = rsin.getString("BoardTitle");
																int boardNum = Integer.parseInt(rsin.getString("BoardNum"));
									%>
									<li class="sub_list" id="l1_1"><a
										href="?cate=<%=boardCategoryNum%>&bnum=<%=boardNum%>"><%=titlein%></a></li>
									<%
										}
														} catch (Exception e) {
															out.println("내부데이터베이스 접속에 문제가 발생.<hr>");
															out.println(e.getMessage());
															e.printStackTrace();
														}
												}
									%>
								</ul></li>
								
						
							<%
								}
									rs.close();
									stmt.close();

								} catch (Exception e) {
									out.println("데이터베이스 접속에 문제가 발생.<hr>");
									out.println(e.getMessage());
									e.printStackTrace();
								}
								conn.close();
							%>

						</ul>
						
					</div>
					<p id="blank">
					
					</p>
					</div>
					<div id="timeWidget">
						<span id="dpTime"
							style="display: block; font-size: 1.1em; text-shadow: 0 0 1px #fff, 0 0 1px #fff, 0 0 6px #fff, 0 0 20px #ff00de, 0 0 80px #ff00de, 0 0 100px #ff00de, 0 0 120px #ff00de, 0 0 150px #ff00de; text-align: center; border-radius: 0.3rem; width: 100px; padding: 10px; margin: 0 auto; margin-top: 1rem; margin-bottom: 1rem; box-shadow: 0 0 5px 5px white; color: white;">오전<br />00:00:00
						</span>
					</div>
					
					</div>
					
					

				</nav>

				<div id="contents">


					<%
						Connection conn2 = null;
						Statement stmt2 = null;
						try {
							int bnum = 0;
							int cate = 0;
							int contentNum = 0;
							if (request.getParameter("bnum") == null) {
								if (request.getParameter("cate") == null) {

								} else {
									cate = Integer.parseInt(request.getParameter("cate"));
								}
							} else {
								bnum = Integer.parseInt(request.getParameter("bnum"));
							}
							if (request.getParameter("contnum") == null) {

							} else {
								contentNum = Integer.parseInt(request.getParameter("contnum"));
							}

							Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
							String url = "jdbc:sqlserver://db_주소;databaseName=db_이름";
							conn2 = DriverManager.getConnection(url, "db_아이디", "db_비밀번호");
							stmt2 = conn2.createStatement();

							String sql2 = "";
							if (cate == 3) //다이어리 게시판
							{
								sql2 = "";
					%>
					<div class="context_diary">
						<h3>title</h3>
						<p>writtendate</p>
						<p>context</p>
						<p>creator</p>
						<img src="" />
						<div class="container">
							<a href="#" class="btn-slide"> <span class="circle"><span
									class="icon-long-arrow-right "></span></span> <span class="title">Slide
									to Unlock</span> <span class="title-hover">Unlocked!</span>
							</a>
						</div>
					</div>
					<%
						} 
						else if (bnum == 0) //메인페이지
						{
						sql2 = "select * from tbl_context inner join tbl_user on tbl_context.CreateID = tbl_user.ID inner join tbl_board on tbl_context.BoardNum = tbl_board.BoardNum where IsView = 1 order by WrittenDate desc";
								ResultSet rs0;
								rs0 = stmt2.executeQuery(sql2);
								int cnt = 0;
								while (rs0.next()) {
									String display = "block";
									String display2 = "none";
									if (cnt > 5){
										display = "none";
										display2 = "block";
									}
									if (cnt == 30) {
										break;
									}
									cnt++;
									int ma_contentsnum = Integer.parseInt(rs0.getString("ContentNum"));
									int ma_bnum = Integer.parseInt(rs0.getString("BoardNum"));
									int ma_cate = Integer.parseInt(rs0.getString("BoardCategory"));
									String ma_id = rs0.getString("CreateID");
									String ma_title = rs0.getString("Title");
									String ma_context = rs0.getString("Context");
									String ma_view = rs0.getString("ViewCount");
									String ma_wrdate = rs0.getString("WrittenDate");
									String ma_profile = rs0.getString("ProfileImage");
									String ma_boardTitle = rs0.getString("BoardTitle");
									ma_wrdate = ma_wrdate.substring(0, 16);
					%>
				
					<span id="contextopen<%=cnt %>" onClick="contextopen(<%=cnt %>);" style="display:<%=display2 %>;
						-webkit-appearance: none;font-size:0.9rem;font-weight:normal;margin-top:1rem;cursor:pointer;margin-left:1.2rem;color:rgba(0,150,180,1);">열기 <span style="margin-left:2rem;color:black;"><%=ma_title %> <span style="color:rgba(200,200,200,1);font-size:0.8rem;margin-left:0.5rem;"> posting by <%=ma_id %></span></span></span></span>
					<div class="context" id="context<%=cnt%>" style="display:<%=display%>;">
						<span onClick="contextclose(<%=cnt %>);" style="font-family: 'Jeju Gothic';font-size:0.9rem;position:absolute;top:0;left:0;cursor:pointer;color:rgba(0,150,180,1);">접기</span>
						<img id="thum_image" src="<%=ma_profile%>" alt="" />
						<h5><%=ma_id%>
							작성
						</h5>
						<%
							if (USER != null) {
											if (ma_id.equals(USER)) {
						%>
						<form action="posting.jsp" method="post">
							<a id="updatea" href="?bnum=102&updatecont=<%=ma_contentsnum%>">수정</a>
							<input type="hidden" id="delpostNum" name="delpostNum"
								value="<%=ma_contentsnum%>" /> <input type="submit"
								id="delbtnpost" onClick="return isdelPost();" value="삭제" />
						</form>
						<%
							}
										} else {

										}
						%>
						<p class="line"></p>
						<h4><%=ma_boardTitle%></h4>
						<a style="color:black;"
							href="work.jsp?cate=<%=ma_cate%>&bnum=<%=ma_bnum%>&contnum=<%=ma_contentsnum%>"><h3><%=ma_title%></h3></a>
						<br /> <br />
						<%=ma_context%>
						<p class="addinfo"><%=ma_view%>명 읽음
						</p>
						<p class="addinfo"><%=ma_wrdate%>에 작성된 글
						</p>
					
					<div style="display: block; text-align: center;">
						<img
							style="cursor: pointer; margin-top: 2rem; display: inline-block;"
							onClick="commentOn(<%=cnt%>)" id="commentimage"
							src="image/comment.png" />
						

						<%
							String sqlcomnum = "select * from tbl_reply where ContentNum = " + ma_contentsnum;
							ResultSet rscomnum;
							PreparedStatement stmtcomnum = conn2.prepareStatement(sqlcomnum,
							ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);

							rscomnum = stmtcomnum.executeQuery();
							rscomnum.last();
							int totalComment = rscomnum.getRow();
						%>
						<p style="display: inline-block;font-size:0.8rem;"><%=totalComment%></p>
						<img
							style="cursor: pointer; margin-top: 2rem; display: inline-block;width:28px;height:26px;"
							id="loveimage"
							src="image/love.png" />
					</div>
					</div>
					<div class="div_comment" id="div_comment<%=cnt%>">
						<div id="write_comment" style="position: relaitve;">
							<div class="emoticon_popup" id="emoticon_popup<%=cnt%>">
								<%
									String sqlemoti = "select * from tbl_emoticon";

									Statement stmtemoti = conn2.createStatement();

									ResultSet rsemoti = stmtemoti.executeQuery(sqlemoti);
									while (rsemoti.next()) {
										String emotisrc = rsemoti.getString("emoticonUrl");
										String emotiName = rsemoti.getString("emoticonName");
								%>
								<img onClick="emotiput(this, <%=cnt%>);" src="<%=emotisrc%>"
									alt="<%=emotiName%>" />
								<%
									}
								%>
							</div>
						
							<img src="image/btn_emoticon.png" onClick="emotiPopup(<%=cnt%>);" id="emotip" style="width:20px;display:inline-block; margin-top:0.2rem; margin-bottom: 0; cursor: pointer; padding: 0.25rem; margin-left: 0.5rem;"/>
							<br />
							<form action="comment.jsp" method="post">
								<%
								if(USER!=null)
								{
								%>
								<input type="hidden" id="cm_id" name="cm_id" value="<%=USER%>"/>
								<%
								}
								else
								{
									
								%>
								<input type="hidden" id="cm_id" name="cm_id" value="손님" />
								<%
								}
								%>
								<input type="hidden" id="cm_ip" name="cm_ip" value="<%=IP %>"/>
								<input type="hidden" id="cmnum" name="cmnum"
									value="<%=ma_contentsnum%>"> <input type="hidden"
									id="canum" name="canum" value="<%=ma_cate%>"> <input
									type="hidden" id="bnum" name="bnum" value="<%=ma_bnum%>">
								<textarea onClick="clearta(<%=cnt %>);" onfocus="this.value = this.value;" class="commentarea"
									name="commentarea" id="commentarea<%=cnt%>"
									onKeyup="var m=50; var s=this.scrollHeight;if(s>=m)this.style.pixelHeight=s+4">댓글을 작성해주세요...</textarea>
								<input id="cm_submit" type="submit" value="댓글쓰기" />
							</form>
						</div>
						<br />
						<%
							String sqlcomment ="";
							sqlcomment = "select * from tbl_reply inner join tbl_user on tbl_reply.UserName = tbl_user.Id where ContentNum = "
									+ ma_contentsnum + " order by WriteDate desc";
							ResultSet rscomment;
							Statement stmtcomment = conn2.createStatement();
							rscomment = stmtcomment.executeQuery(sqlcomment);
							int commcnt = 0;
							while (rscomment.next()) 
							{
								commcnt++;
								String commentId_profile = rscomment.getString("ProfileImage");
								String comment = rscomment.getString("ReplyText");
								String commentId = rscomment.getString("UserName");
								String commentwrdate = rscomment.getString("WriteDate");
								int commentNum = Integer.parseInt(rscomment.getString("ReplyNum"));
								String commentIP = rscomment.getString("WriteIP");
						%>
								<%
								if(commcnt>3)
								{
								%>
								<div class="div_commentin" style="display:none;"
									id="div_commentin_<%=commcnt%>_<%=cnt%>"
									onmouseover="delon('<%=commcnt%>_<%=cnt%>');"
									onmouseout="deloff('<%=commcnt%>_<%=cnt%>')"
									>
								<%
								}
								else
								{
								%>
								<div class="div_commentin"
									id="div_commentin_<%=commcnt%>_<%=cnt%>"
									onmouseover="delon('<%=commcnt%>_<%=cnt%>');"
									onmouseout="deloff('<%=commcnt%>_<%=cnt%>')"
									>
								<%
								}
								%>
		
		
									<img id="comment_profileimg" src="<%=commentId_profile%>" />
									<div id="commentText">
										<%
										if(commentId.equals("손님"))
										{
											CEncrypt encrypt = new CEncrypt("MD5", commentIP);
											String changeid = "손님" +encrypt.getEncryptData().substring(0,8);

										%>
										<p id="comment_id"><%=changeid%></p>
										<%
										}
										else
										{
										%>
										<p id="comment_id"><%=commentId%></p>
										<%
										}
										if(USER!=null)
										{
											if(USER.equals(commentId))
											{
											%>
											<a href="comment.jsp?delnum=<%=commentNum %>&cate=<%=ma_cate %>&bnum=<%=ma_bnum %>&contnum=<%=ma_contentsnum %>" id="comment_del_<%=commcnt%>_<%=cnt%>">삭제</a> 
											<%
											
											}
										}
										else if(commentId.equals("손님"))
										{
											if(IP.equals(commentIP))
											{
												
											%>
											<a href="comment.jsp?delnum=<%=commentNum %>&cate=<%=ma_cate %>&bnum=<%=ma_bnum %>&contnum=<%=ma_contentsnum%>" id="comment_del_<%=commcnt%>_<%=cnt%>">삭제</a> 
											<%
											}
										}
											rsemoti = stmtemoti.executeQuery(sqlemoti);
															while (rsemoti.next()) {
																String emotichk = rsemoti.getString("emoticonName");
																String emotichangeUrl = rsemoti.getString("emoticonUrl");
																comment = comment.replaceAll("[(]" + emotichk + "[)]",
																		"<img src='" + emotichangeUrl + "'/>");
															}
										%>
										<br />
										<%=comment%>
										<br />
										<p id="comment_date"><%=commentwrdate%></p>
										<br />
									</div>
								</div>
								
								
						<%
							}
						%>
						<%
						if(commcnt>3)
						{
						%>
						<p onClick="deobogi(<%=cnt %>, <%=commcnt%>);" style="cursor:pointer;font-size:0.85rem;">댓글더보기</p>
						<%
						}
						else
						{
						%>
						
						<%
						}
						%>
					</div>
					
					

					<p
						style="margin-top: 1rem; text-align: center; font-size: 1.2em; font-weight: bold; border-top: 0.2px solid lightgray; border-bottom: 0.2px solid lightgray; background-color: rgba(0, 30, 30, 1); height: 7px;"></p>
					<%
						}
								rs0.close();
							} else if (bnum == 100) //작성페이지
							{
					%>
					<div class="context">
						<br />
						<h2 style="text-align: center;">포스트 작성</h2>
						<br /> <br />
						<form action="posting.jsp" method="post">
							<input type="hidden" id="creator" name="creator"
								value="<%=USER%>" /> <select id="selOpt" name="selOpt"
								onChange="chDomain(this.value);"
								style="width: 100px; height: 30px; font-size: 1em; display: block; text-align: center; margin: 0 auto; border: 1px solid rgba(0, 0, 0, 0); border-bottom: 0.3px solid lightgray;">
								<%
									Connection conn3 = null;
											Statement stmtcate = null;

											try {
												Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
												String url3 = "jdbc:sqlserver://db_주소;databaseName=db_이름";
												conn3 = DriverManager.getConnection(url3, "db_아이디", "db_비밀번호");
												stmtcate = conn3.createStatement();

												String sqlcate = "select * from tbl_board where CreateID = '" + USER + "' or CreateID = '공용'";
												ResultSet rscate = stmtcate.executeQuery(sqlcate);
												while (rscate.next()) {
													String category = rscate.getString("BoardTitle");
													int categorynum = Integer.parseInt(rscate.getString("BoardNum"));
								%>
								<option value="<%=categorynum%>"><%=category%></option>
								<%
									}
												rscate.close();
												stmtcate.close();
												conn.close();
											} catch (Exception e) {
												out.println("데이터베이스 접속에 문제가 발생.<hr>");
												out.println(e.getMessage());
												e.printStackTrace();
											}
								%>
							</select> <input type="text" onClick="clearTitle();"
								value="포스트제목을 입력해주세요." name="post_title" id="post_title"
								required=""
								style="border: 1px solid rgba(0, 0, 0, 0); border-bottom: 0.3px solid lightgray; font-size: 1.2em; width: 500px; display: block; text-align: center; margin: 0 auto; margin-top: 1rem; color: rgba(150, 150, 150, 1);">
							<br /> <br />
							<textarea name="ir1" id="ir1" rows="10" cols="100"
								style="width:100%;min-width:260px;height: 412px; display: none; margin: 0 auto;"></textarea>
							<!--textarea name="ir1" id="ir1" rows="10" cols="100" style="width:100%; height:412px; min-width:610px; display:none;"></textarea-->
							<p>
								<input type="button" onclick="submitContents(this);" value="올리기"
									style="border-radius: 0.15rem; border: 0.3px solid lightgray; background-color: white; cursor: pointer; padding: 1rem; text-align: center; margin: 0 auto; display: block; font-size: 1em; width: 150px;" />
								<!-- <input type="button" onclick="setDefaultFont();" value="기본 폰트 지정하기 (궁서_24)" /> -->
							</p>
						</form>
					</div>
					<%
						} else if (bnum == 101) //옵션페이지
							{
					%>
					<div style="position: relative;" class="context">
						<h3 style="font-size: 1.2em;">프로필 정보</h3>
						<p style="text-align: right; cursor: pointer; font-size: 0.7em;"
							onClick="onoffInfo();" id="onoffInfo">닫기</p>
						<div id="profileOption">
							<p class="line"></p>
							<p>프로필 사진</p>
							<img id="userImage" src="<%=USER_PROFILE_IMAGE%>" />
							<form action="userProfileManager.jsp" method="post"
								enctype="multipart/form-data">
								<div class="filebox">
									<label for="inFile">프로필사진 변경</label> <input id="inFile"
										type="file" name="filename1" onChange="viewImg();"
										class="upload-hidden">
								</div>

								<br />
								<p>비밀번호 변경</p>

								<input type="hidden" id="manageID" name="manageID"
									value="<%=USER%>" /> <input onClick="clearText(this);"
									type="password" class="password" id="managePwd"
									name="managePwd" value="비밀번호 입력"
									style="border: none; border-bottom: 0.2px solid lightgray;" />
								<br /> <input onClick="clearText(this);" type="password"
									class="password" id="checkPwd" name="checkPwd" value="비밀번호 입력"
									style="border: none; border-bottom: 0.2px solid lightgray;" />
								<br /> <br /> <br /> <input id="saveInfo" type="submit"
									value="변경된 정보 저장" onClick="return alert_save()" />
							</form>
						</div>

						<br /> <br />

						<h3 style="font-size: 1.2em;">게시판 정보</h3>
						<p style="text-align: right; cursor: pointer; font-size: 0.7em;"
							onClick="onoffInfo2();" id="onoffboardInfo">닫기</p>
						<div id="boardOption">

							<p class="line"></p>

							<form action="userBoardManager.jsp" method="post"></form>
						</div>

					</div>
					<%
						} else if (bnum == 102) //수정페이지
							{
					%>
					<div class="context">
						<br />
						<h2 style="text-align: center;">포스트 작성</h2>
						<br /> <br />
						<form action="posting.jsp" method="post">
							<select id="selOpt" name="selOpt"
								onChange="chDomain(this.value);"
								style="width: 100px; height: 30px; font-size: 1em; display: block; text-align: center; margin: 0 auto; border: 1px solid rgba(0, 0, 0, 0); border-bottom: 0.3px solid lightgray;">
								<%
									int updatecontnum = Integer.parseInt(request.getParameter("updatecont"));
											Connection conn3 = null;
											Statement stmtcate = null;

											String contexttitle = "";
											String context = "";
											try 
											{
												Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
												String url3 = "jdbc:sqlserver://db_주소;databaseName=db_이름";
												conn3 = DriverManager.getConnection(url3, "db_아이디", "db_비밀번호");
												stmtcate = conn3.createStatement();

												String sqlcate = "select * from tbl_board where CreateID = '" + USER + "' or CreateID = '공용'";
												ResultSet rscate = stmtcate.executeQuery(sqlcate);
												while (rscate.next()) {
													String category = rscate.getString("BoardTitle");
													int categorynum = Integer.parseInt(rscate.getString("BoardNum"));
								%>
								<option value="<%=categorynum%>"><%=category%></option>
								<%
									}
												String sqlcontext = "select * from tbl_context where Contentnum =" + updatecontnum;
												rscate = stmtcate.executeQuery(sqlcontext);
												while (rscate.next()) {
													contexttitle = rscate.getString("Title");
													context = rscate.getString("Context");
												}
												rscate.close();
												stmtcate.close();
												conn.close();
											} catch (Exception e) {
												out.println("데이터베이스 접속에 문제가 발생.<hr>");
												out.println(e.getMessage());
												e.printStackTrace();
											}
								%>
							</select> <input id='updatecontextnum' name="updatecontextnum"
								type='hidden' value='<%=context%>'> 
								<input id='updatecontextnum2' name="updatecontextnum2" type='hidden'
								value='<%=updatecontnum%>'> <input type="text"
								onClick="clearTitle();" value="<%=contexttitle%>"
								name="post_title" id="post_title" required=""
								style="border: 1px solid rgba(0, 0, 0, 0); border-bottom: 0.3px solid lightgray; font-size: 1.2em; width:95%; max-width:500px; display: block; text-align: center; margin: 0 auto; margin-top: 1rem; color: rgba(150, 150, 150, 1);">
							<br /> <br />
							<textarea name="ir1" id="ir1" rows="10" cols="100"
								style="width: 766px; height: 412px; display: none; margin: 0 auto;"></textarea>
							<!--textarea name="ir1" id="ir1" rows="10" cols="100" style="width:100%; height:412px; min-width:610px; display:none;"></textarea-->
							<p>
								<input type="button" onclick="submitContents(this);"
									value="수정하기"
									style="border-radius: 0.15rem; border: 0.3px solid lightgray; background-color: white; cursor: pointer; padding: 1rem; text-align: center; margin: 0 auto; display: block; font-size: 1em; width: 150px;" />
								<!-- <input type="button" onclick="setDefaultFont();" value="기본 폰트 지정하기 (궁서_24)" /> -->
							</p>
						</form>
					</div>
					<%
						} 
						else //일반 게시판
						{
								sql2 = "select * from tbl_context inner join tbl_user on tbl_context.CreateID = tbl_user.ID where BoardNum="
										+ bnum + " and IsView = 1 order by WrittenDate desc";

								String title = "";
								String context = "";
								int viewCnt = 0;
								String writtenDate = "";
								int contNum = 0;
								String creatorID = "";
								String profileUrl = "";
								String boardTitle = "";
								ResultSet rs2;

								String sql3 = "";
								if (contentNum == 0) {
									sql3 = "select * from tbl_context inner join tbl_user on tbl_context.CreateID = tbl_user.ID inner join tbl_board on tbl_context.BoardNum = tbl_board.BoardNum where tbl_context.BoardNum="
											+ bnum + " and IsView = 1 order by WrittenDate desc";
								} else {
									sql3 = "select * from tbl_context inner join tbl_user on tbl_context.CreateID = tbl_user.ID inner join tbl_board on tbl_context.BoardNum = tbl_board.BoardNum where IsView = 1 and ContentNum="
											+ contentNum;
								}

								rs2 = stmt2.executeQuery(sql3);
								if (rs2.next()) {
									title = rs2.getString("Title");
									context = rs2.getString("Context");
									viewCnt = Integer.parseInt(rs2.getString("ViewCount"));
									writtenDate = rs2.getString("WrittenDate");
									writtenDate = writtenDate.substring(0, 16);
									creatorID = rs2.getString("CreateID");
									contNum = Integer.parseInt(rs2.getString("ContentNum"));
									profileUrl = rs2.getString("ProfileImage");
									boardTitle = rs2.getString("BoardTitle");
					%>
					<div class="context">
						<img id="thum_image" src="<%=profileUrl%>" alt="" />
						<h5><%=creatorID%>
							작성
						</h5>
						<%
							if (USER != null) 
							{
											
								if (creatorID.equals(USER)) 
								{
						%>
						<form action="posting.jsp" method="post">
							<a id="updatea" href="?bnum=102&updatecont=<%=contNum%>">수정</a>
							<input type="hidden" id="delpostNum" name="delpostNum"
								value="<%=contNum%>" /> <input type="submit" id="delbtnpost"
								onClick="return isdelPost();" value="삭제" />
						</form>
						<%
								}
								else 
								{

								}
							}
						%>
						<p class="line"></p>
						<h4><%=boardTitle%></h4>
						<h3><%=title%></h3>
						<br /> <br />
						<%=context%>
						<p class="addinfo"><%=viewCnt%>명 읽음
						</p>
						<p class="addinfo"><%=writtenDate%>에 작성된 글
						</p>
						<div style="display: block; text-align: center;">
							<img style="cursor: pointer; margin-top: 2rem;display:inline-block;"
								onClick="commentOpen()" id="commentimage"
								src="image/comment.png" />
							<%
								String sqlcomnum = "select * from tbl_reply where ContentNum = " + contNum;
											ResultSet rscomnum;
											PreparedStatement stmtcomnum = conn2.prepareStatement(sqlcomnum,
													ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);

											rscomnum = stmtcomnum.executeQuery();
											rscomnum.last();
											int totalComment = rscomnum.getRow();
							%>
							<p style="display: inline-block;font-size:0.8rem;"><%=totalComment%></p>
							<img
							style="cursor: pointer; margin-top: 2rem; display: inline-block;width:28px;height:26px;"
							id="loveimage"
							src="image/love.png" />
						</div>
						<div class="div_comment" id="div_comment" style="display:block;">
							<div id="write_comment">
								<div class="emoticon_popup" id="emoticon_popup">
									<%
										String sqlemoti = "select * from tbl_emoticon";

													Statement stmtemoti = conn2.createStatement();

													ResultSet rsemoti = stmtemoti.executeQuery(sqlemoti);
													while (rsemoti.next()) {
														String emotisrc = rsemoti.getString("emoticonUrl");
														String emotiName = rsemoti.getString("emoticonName");
									%>
									<img onClick="emotiput2(this);" src="<%=emotisrc%>"
										alt="<%=emotiName%>" />
									<%
										}
									%>
								</div>
								<img src="image/btn_emoticon.png" onClick="emotiPopup2();" id="emotip" style="width:20px;display:inline-block; margin-top:0.2rem; margin-bottom: 0; cursor: pointer; padding: 0.25rem; margin-left: 0.5rem;"/>
								<br />
								<form action="comment.jsp" method="post">
									<%
									if(USER!=null)
									{
									%>
									<input type="hidden" id="cm_id" name="cm_id" value="<%=USER%>">
									<%
									}
									else
									{
									%>
									<input type="hidden" id="cm_id" name="cm_id" value="손님">
									<%
									}
									%>
									<input type="hidden" id="cm_ip" name="cm_ip" value="<%=IP %>"/>
									<input type="hidden" id="cmnum" name="cmnum"
										value="<%=contNum%>"> <input type="hidden" id="canum"
										name="canum" value="<%=cate%>"> <input type="hidden"
										id="bnum" name="bnum" value="<%=bnum%>">
									<textarea onClick="clearta2()" onfocus="this.value = this.value;"
										class="commentarea" name="commentarea" id="commentarea"
										onKeyup="var m=50; var s=this.scrollHeight;if(s>=m)this.style.pixelHeight=s+4">댓글을 작성해주세요...</textarea>
									<input id="cm_submit" type="submit" value="댓글쓰기" />
								</form>
							</div>
							<br />

							<%
								String sqlcomment = "select * from tbl_reply inner join tbl_user on tbl_reply.UserName = tbl_user.Id where ContentNum = "
													+ contNum + " order by WriteDate desc";
											ResultSet rscomment;
											Statement stmtcomment = conn2.createStatement();
											rscomment = stmtcomment.executeQuery(sqlcomment);
											int commcnt = 0;
											while (rscomment.next()) {
												commcnt++;
												String commentId_profile = rscomment.getString("ProfileImage");
												String comment = rscomment.getString("ReplyText");
												String commentId = rscomment.getString("UserName");
												String commentwrdate = rscomment.getString("WriteDate");
												int commentNum = Integer.parseInt(rscomment.getString("ReplyNum"));
												String commentIP = rscomment.getString("WriteIP");
							%>
							<div class="div_commentin" id="div_commentin_<%=commcnt%>"
								onmouseover="delon('<%=commcnt%>');"
								onmouseout="deloff('<%=commcnt%>')">

								<img id="comment_profileimg" src="<%=commentId_profile%>" />
								<div id="commentText">
									<%
									if(commentId.equals("손님"))
									{
										CEncrypt encrypt = new CEncrypt("MD5", commentIP);
										String changeid = "손님" +encrypt.getEncryptData().substring(0,8);

									%>
									<p id="comment_id"><%=changeid%></p>
									<%
									}
									else
									{
									%>
									<p id="comment_id"><%=commentId%></p>
									<%
									}
									if(USER!=null)
									{
										if(USER.equals(commentId))
										{
										%>
										<a href="comment.jsp?delnum=<%=commentNum %>&cate=<%=cate %>&bnum=<%=bnum %>&contnum=<%=contNum %>" id="comment_del_<%=commcnt%>">삭제</a> 
										<%
										}
									}
									else if(commentId.equals("손님"))
									{
										if(IP.equals(commentIP))
										{
										%>
										<a href="comment.jsp?delnum=<%=commentNum %>&cate=<%=cate %>&bnum=<%=bnum %>&contnum=<%=contNum %>" id="comment_del_<%=commcnt%>">삭제</a> 
										<%
										}
									}
									rsemoti = stmtemoti.executeQuery(sqlemoti);
									while (rsemoti.next()) 
									{
										String emotichk = rsemoti.getString("emoticonName");
										String emotichangeUrl = rsemoti.getString("emoticonUrl");
										comment = comment.replaceAll("[(]" + emotichk + "[)]",
												"<img src='" + emotichangeUrl + "'/>");
									}
									%>
									 <br />
									<%=comment%>
									<br />
									<p id="comment_date"><%=commentwrdate%></p>
									<br />
								</div>


							</div>

							<%
								}
							%>
						</div>

					</div>
					<p
						style="margin-top: 1rem; text-align: center; font-size: 1em; font-weight: bold; border-top: 0.2px solid lightgray; border-bottom: 0.2px solid lightgray; background-color: rgba(0, 30, 30, 1); color: white; padding-top: 0.6rem; padding-bottom: 0.6rem;">
						<span style="color: lightgray;">'<%=boardTitle%>'
						</span> 포스트 리스트
					</p>
					<%
						}

							rs2 = stmt2.executeQuery(sql2);
							while (rs2.next()) 
							{
								title = rs2.getString("Title");
								context = rs2.getString("Context");
								viewCnt = Integer.parseInt(rs2.getString("ViewCount"));
								writtenDate = rs2.getString("WrittenDate");
								writtenDate = writtenDate.substring(0, 10);
								contNum = Integer.parseInt(rs2.getString("ContentNum"));
								String thumimg = rs2.getString("ProfileImage");
					%>
					<a href="?cate=<%=cate%>&bnum=<%=bnum%>&contnum=<%=contNum%>">
						<div class="context_list">
							<img src="<%=thumimg%>" />
							<h5><%=title%></h5>
							<p><%=writtenDate%></p>
						</div>
					</a>
					<%
							}
							rs2.close();
							stmt2.close();
						}
						} 
						catch (Exception e) 
						{
							out.println("데이터베이스 접속에 문제가 발생3.<hr>");
							out.println(e.getMessage());
							e.printStackTrace();
						}
					%>
					<br /> <br /> <br />
				</div>


			</div>

		</div>

		<div id="notice_popup" onClick="closePopup()">
			<%
				df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				beginDate = df.parse("2017-03-13 00:00:00");
				endDate = df.parse(getDate());
				diff = endDate.getTime() - beginDate.getTime();
				diffTime = diff / (60 * 60 * 1000);
				diffDay = diff / (24 * 60 * 60 * 1000) + 1;
			%>
			<p>
				신애와 경호가 만난지
				<%=diffDay%>일이 지났습니다.
			</p>
			<img onClick="closePopup()" src="image/btn_delete.png" />

		</div>



		<div id="footer"></div>
	</div>
	</div>
	<script>


	$( window ).resize(function() {
		var windowWidth = $( window ).width();
		var windowHeight = $( window ).height();
		var nav = document.getElementById('nav');
		var menu = document.getElementById('menu');
		/* if(windowWidth>1080){
			if(nav.style.display=="none"){
				nav.style.display="block";	
			}
			if(menu.style.display=="none"){
				menu.style.display="block";
			}
		} */

	});



	
	

	function closePopup()
	{
		var img = document.getElementById("notice_popup");
		img.style.display="none";
	}
	
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
	function chDomain(val) 
	{
		document.form.selOpt.value = val;
	}
	function viewMenu()
	{
		var m = document.getElementById("menu");
		if(m.style.display=="block"){
			m.style.display="none";
		}
		else{
			m.style.display="block";
		}
		
	}
	function alert_save()
	{
		var del = confirm("변경된 내용이 저장됩니다.");
		var p1 = document.getElementById('managePwd').value;
		var p2 = document.getElementById('checkPwd').value;
		if(del==true){
			if(p1.length<6){
				alert("비밀번호는 6자 이상 입력해주세요.");
				document.getElementById("managePwd").value = "";
				document.getElementById("checkPwd").value = "";
				document.getElementById("managePwd").focus();
				return false;
			}
			if(p1==p2){
				document.form.submit();
			}
			else{
				alert("입력한 비밀번호가 다릅니다.");
				return false;
			}
			
		}else{
			return false;
		}
	}
	function viewImg() 
	{
		var upload = document.getElementById('inFile');
	    var holder = document.getElementById('userImage');
  		var file = upload.files[0];
    	reader = new FileReader();
  	
  		reader.onload = function (event) 
  		{
    		holder.src = event.target.result;

  		};
  		reader.readAsDataURL(file);
  		
  		alert("성공적으로 프로필사진을 변경하였습니다.");
	}
	function clearText(str)
	{
		str.value = "";
	}
	
	function onoffInfo()
	{
		var info = document.getElementById('profileOption');
		var p = document.getElementById('onoffInfo');
		if(info.style.display=="block"){
			info.style.display="none";
			p.innerHTML = "열기";
		}
		else{
			info.style.display="block";
			p.innerHTML = "닫기";
		}
	}
	
	function onoffInfo2()
	{
		var info = document.getElementById('boardOption');
		var p = document.getElementById('onoffboardInfo');
		if(info.style.display=="block"){
			info.style.display="none";
			p.innerHTML = "열기";
		}
		else{
			info.style.display="block";
			p.innerHTML = "닫기";
		}
	}
	function mobileOnList()
	{
		var list = document.getElementById('nav');
		var x = document.getElementsByTagName("html")[0]; 
		
		if(list.style.display=="block"){
			list.style.display="none";
			
			
		
		}else{
			list.style.display="block";
			
			
		}
	}
	function delon(cnt)
	{
		var del = document.getElementById('comment_del_'+cnt);
		var b = document.getElementById('div_commentin_'+cnt);
		b.style.backgroundColor="rgba(240,240,240,1)";
		del.style.display="block";
	}
	function deloff(cnt)
	{
		var del = document.getElementById('comment_del_'+cnt);
		var b = document.getElementById('div_commentin_'+cnt);
		b.style.backgroundColor="white";
		del.style.display="none";
	}
	function commentOn(cnt)
	{
		var obj = document.getElementById('div_comment'+cnt);
		if(obj.style.display=="block"){
			obj.style.display="none";
		}else{
			obj.style.display="block";
		}
			
	}
	function commentOpen()
	{
		var obj = document.getElementById('div_comment');
		if(obj.style.display=="block"){
			obj.style.display="none";
		}
		else{
			obj.style.display="block";
		}
			
	}
	
	setInterval("dpTime()",1000);

    function dpTime(){
       var now = new Date();
        hours = now.getHours();
        minutes = now.getMinutes();
        seconds = now.getSeconds();
        if (hours > 12){

            hours -= 12;
        ampm = "오후 ";
        }else{
            ampm = "오전 ";
        }
        if (hours < 10){
            hours = "0" + hours;
        }

        if (minutes < 10){
            minutes = "0" + minutes;
        }

        if (seconds < 10){
            seconds = "0" + seconds;
        }
        document.getElementById("dpTime").innerHTML = ampm + hours + ":" + minutes + ":" + seconds;
    }
    
    function emotiPopup(cnt)
    {
    	obj = document.getElementById('emoticon_popup'+cnt);
    	
		
    	if(obj.style.display=="block"){
    		obj.style.display="none";
    	}else{
    		obj.style.display="block";
    	}
    			
    }
    function emotiPopup2()
    {
    	obj = document.getElementById('emoticon_popup');
    	
		
    	if(obj.style.display=="block"){
    		obj.style.display="none";
    	}else{
    		obj.style.display="block";
    	}
    			
    }
    
    function getAbsolutePos(obj)
    {
    	var position = new Object;
    	position.x = 0;
    	position.y = 0;
    	if(obj){
    		position.x = obj.offsetLeft + obj.clientLeft;
    		position.y = obj.offsetTop + obj.clientTop;
    		if(obj.offsetParent){
    			var parentpos = getAbsolutePos(obj.offsetParent);
    			position.x +=parentpos.x;
    			position.y += parentpos.y;
    		}
    	}
    	return position;
    }
    
    function emotiput(obj, cnt)
    {
    	name = obj.alt;
    	var s = document.getElementById('emoticon_popup'+cnt);
    	var t = document.getElementById('commentarea'+cnt);
    	clearta(cnt);
    	t.value += "("+name+")";
    	s.style.display="none";
    	t.focus();
    }
    
    function emotiput2(obj)
    {
    	name = obj.alt;
    	var s = document.getElementById('emoticon_popup');
    	var t = document.getElementById('commentarea');
   		clearta2();
    	t.value += "("+name+")";
    	s.style.display="none";
    	t.focus();
    }
    function clearta2()
    {
    	var obj = document.getElementById('commentarea');
    	if(obj.value=="댓글을 작성해주세요..."){
    		obj.value = "";
    	}
    	
    	obj.style.color="black";
    	obj.focus();
    }
    function clearta(cnt)
    {
    	var obj = document.getElementById('commentarea'+cnt);
    	if(obj.value=="댓글을 작성해주세요..."){
    		obj.value = "";
    	}
    	obj.style.color="black";
    	obj.focus();
    }
    
    function deobogi(cnt, commcnt)
    {
    	for(var i=3; i <= commcnt; i++){
    		var obj = document.getElementById('div_commentin_'+i+'_'+cnt);
        	obj.style.display="block";
    	}
    	
    }
    
    function mhclose()
    {
    	var obj = document.getElementById('main_header');
    	if(obj.style.display=="none"){
    		obj.style.display="block";
    	}
    	else{
    		obj.style.display="none";
    	}
    }
    
    function contextclose(cnt)
    {
    	var obj = document.getElementById('context'+cnt);
    	var obj2 = document.getElementById('div_comment'+cnt);
    	var obj3 = document.getElementById('contextopen'+cnt);
    	obj.style.display="none";
    	obj2.style.display="none";
    	obj3.style.display="block";
    }
    function contextopen(cnt)
    {
    	var obj = document.getElementById('context'+cnt);
    	var obj2 = document.getElementById('div_comment'+cnt);
    	var obj3 = document.getElementById('contextopen'+cnt);
    	obj.style.display="block";
    	obj2.style.display="block";
    	obj3.style.display="none";
    }


</script>

	<script src='autosize.js'></script>
	<script>
		autosize(document.querySelectorAll('textarea'));
</script>

	<script type="text/javascript">
var oEditors = [];

var sLang = "ko_KR";	// 언어 (ko_KR/ en_US/ ja_JP/ zh_CN/ zh_TW), default = ko_KR

// 추가 글꼴 목록
//var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];

nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "ir1",
	sSkinURI: "posting/SmartEditor2Skin.html",	
	htParams : {
		bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
		bUseVerticalResizer : false,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
		bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
		bSkipXssFilter : true,		// client-side xss filter 무시 여부 (true:사용하지 않음 / 그외:사용)
		//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
		fOnBeforeUnload : function(){
			//alert("완료!");
		},
		I18N_LOCALE : sLang
	}, //boolean
	fOnAppLoad : function(){
		var sHTML = document.getElementById("updatecontextnum").value;
		oEditors.getById["ir1"].exec("PASTE_HTML", [sHTML]);
	},
	fCreator: "createSEditor2"

});


function pasteHTML(filepath)
{
    var sHTML = "<img src='D:/db_아이디istory/image/post/"+filepath+">'";

    oEditors.getById["ir1"].exec("PASTE_HTML", [sHTML]); 
}

function showHTML() {
	var sHTML = oEditors.getById["ir1"].getIR();
	alert(sHTML);
}
	
function submitContents(elClickedObj) {
	oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
	elClickedObj.form.submit();
	
	// 에디터의 내용에 대한 값 검증은 이곳에서 document.getElementById("ir1").value를 이용해서 처리하면 됩니다.
	/*var del = confirm("정말 포스트를 게시하겠습니까?");
	if(del==true){
		try {
			elClickedObj.form.submit();
		} catch(e) {}
	}else{
		return false;
	}*/
	
}

function setDefaultFont() {
	var sDefaultFont = '궁서';
	var nFontSize = 24;
	oEditors.getById["ir1"].setDefaultFont(sDefaultFont, nFontSize);
}

function clearTitle() {
	document.getElementById("post_title").value = "";
	document.getElementById("post_title").style.color = "black";
}

function isdelPost()
{
	var del = confirm("삭제한 글은 복구되지 않습니다. 정말 포스트를 삭제하시겠습니까?");
	if(del==true){
		document.form.submit();
	}else{
		return false;
	}
}
</script>


</body>
</html>