<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.student.StudentVO, com.student.StudentDAO"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%
   String sd_id=request.getParameter("sd_id");
   
   StudentDAO dao=StudentDAO.getInstance();
   int result=dao.idCheck(sd_id);
   out.print(result);
   
%>