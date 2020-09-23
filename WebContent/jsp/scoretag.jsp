<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="score" class="javabean.ScoreBean" scope="page" />
<!DOCTYPE html>
<html>
   <head>
      <meta charset="UTF-8">
      <meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1" />
      <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />

      <title>JSP 예제 : scoretag.jsp</title>
      
      <link rel="shortcut icon" href="../image/icon.png" />
      <link rel="apple-touch-icon" href="../image/icon.png" />
      
      <!--[if lt IE 9]>
      <script src="../js/html5shiv.js"></script>
      <![endif]-->
   </head>
   
   <body>
      <%--<h4>이름과 성적을 javaBeans ScoreBean에 저장</h4>
      <p>
         이름 : 홍길동, 성적 : 85
      </p>
      <jsp:setProperty name="score" property="name" value="홍길동"/>
      <jsp:setProperty name="score" property="point" value="85"/>--%>
      <hr/>
      
      <h4> 폼에서 전달받은 이름과 성적을 JavaBeans ScoreBean에 저장</h4>
      
      <%--<jsp:setProperty name="score" property="name" 
      value="<%= request.getParameter(\"name\") %>" />
      <jsp:setProperty name="score" property="point" 
      value="<%= Integer.parseInt(request.getParameter(\"point\")) %>" /> --%>
      
      <%-- <jsp:setProperty name="score" property="name"/>
      <jsp:setProperty name="score" property="point"/> --%>
      
      <jsp:setProperty name="score" property="*" />
      
      
      <h4>JavaBeans ScoreBean에 저장된 정보를 조회 출력</h4>
      <p>
         이름: <jsp:getProperty name="score" property="name" /><br/>
         성적: <jsp:getProperty name="score" property="point" /><br />
     학점: <jsp:getProperty name="score" property="grade" /><br />
      </p>
   </body>
</html>