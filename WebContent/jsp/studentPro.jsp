<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.student.StudentDAO" %>
<%
   StudentDAO dao=StudentDAO.getInstance();
   
   /*액션 태그를 사용하지 않았을 경우
   javabean.StudentVO vo= new com.student.StudentVO();
   vo.setSd_num(request.getParameter("sd_num"));
   vo.setS_num(request.getParameter("s_num"));
   ....*/
%>
<jsp:useBean id="vo" class="com.student.StudentVO" scope="page" />
<!DOCTYPE html>
<html>
   <head>
      <meta charset="UTF-8">
      <meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1" />
      <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />

      <title>Insert title here</title>
      
      <link rel="shortcut icon" href="../image/icon.png" />
      <link rel="apple-touch-icon" href="../image/icon.png" />
      
      <!--[if lt IE 9]>
      <script src="../js/html5shiv.js"></script>
      <![endif]-->
   </head>
   
   <body>
      <% request.setCharacterEncoding("UTF-8"); %>
      <jsp:setProperty name="vo" property="*" />
      <%
         int rowCount=dao.studentInsert(vo);
         if(rowCount==1){
      %>
         <script type="text/javascript">
            alert("학생정보를 등록 완료하였습니다.");
            location.href="studentList.jsp";
         </script>
      <%
         }else{
      %>
         <script type="text/javascript">
            alert("학생정보 등록 시 문제가 발생하여 등록 완료하지 못하였습니다.");
            history.go(-1);
         </script>
      <%
         }
      %>
   </body>
</html>