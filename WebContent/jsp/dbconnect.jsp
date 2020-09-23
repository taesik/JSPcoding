<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
   <head>
      <meta charset="UTF-8">
      <meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1" />
      <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />

      <title>데이터베이스 예제 : dbconnect.jsp</title>
      
      <link rel="shortcut icon" href="../image/icon.png" />
      <link rel="apple-touch-icon" href="../image/icon.png" />
      
      <!--[if lt IE 9]>
      <script src="../js/html5shiv.js"></script>
      <![endif]-->
   </head>
   
   <body>
      <h3>데이터베이스 드라이버와 Oracle 서버 연결 점검 프로그램</h3><hr />
      <%
         try{
            String driverName="oracle.jdbc.driver.OracleDriver";
            String dbURL="jdbc:oracle:thin:@localhost:1521:orcl";
            
            Class.forName(driverName);
            Connection con=DriverManager.getConnection(dbURL,"javauser","java1234");
            out.println("Oracle 서버에 성공적으로 접속했습니다");
            con.close();
         }
         catch(Exception e){
            out.println("Oracle 서버 접속에 문제가 있습니다. <hr/>");
            out.println(e.getMessage());
            e.printStackTrace();
         }
      %>
   </body>
</html>