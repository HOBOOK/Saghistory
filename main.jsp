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
<meta name="viewport" content="initial-scale=1.0; maximum-scale=1.0; minimum-scale=1.0; user-scalable=no;" /> 
<link rel="stylesheet" href="main.css">
<script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>

<title>신애 경호 이야기♪ Saghistory</title>
</head>
<body>
<script src="http://cdn.jsdelivr.net/mojs/latest/mo.min.js"></script>
  <script>
    var first = new mojs.Shape({
      shape: 'circle',
      radius: {
        0: 40
      },
      stroke: 'cyan',
      strokeWidth: {
        20: 0
      },
      fill: 'none',
      left: 0,
      top: 0,
      duration:300
    });
    var seconds = [];
    var colors = ['deeppink', 'magenta', 'blue', 'tomato'];
    for (var i = 0; i < 4; i++) {
      var second = new mojs.Shape({
        parent: first.el,
        shape: 'circle',
        radius: {
          0: 'rand(30,90)'
        },
        stroke: colors[i],
        strokeWidth: {
          10: 0
        },
        fill: 'none',
        left: '50%',
        top: '50%',
        x:'rand(-100, 100)',
        y:'rand(-100, 100)',
        delay:250
      });
      seconds.push(second);
    }
 
    document.addEventListener('click', function (e) {
      first.tune({
        x: e.pageX,
        y: e.pageY
      }).replay();
      for(var i=0; i<seconds.length; i++){
        seconds[i].generate().replay();
      }
    })
  </script>

	
	<div id ="wrapper">
	
		<div id="header">

		</div>
		
		<div id="center">
			<a href="index.jsp">
			<img src="image/logo_1.png" alt=""/>
			
			<p> 들어가기 </p>
			</a>
		</div>
            
		<div id="footer">
		
		
		</div>
	
	
	</div>
	
    
    
</body>
</html>