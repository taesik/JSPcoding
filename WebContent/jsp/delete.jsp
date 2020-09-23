<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.student.StudentDAO" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%
   String no=request.getParameter("no");

   StudentDAO dao=StudentDAO.getInstance();
   boolean result=dao.studentDelete(Integer.parseInt(no));
   
   out.print(result);
%>