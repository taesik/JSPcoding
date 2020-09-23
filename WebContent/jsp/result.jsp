<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.student.StudentVO, com.student.StudentDAO, java.util.Calendar"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%
   String s_num=request.getParameter("s_num");
   String num=null;
   Calendar calendar=Calendar.getInstance();
   String year=String.valueOf(calendar.get(Calendar.YEAR)).substring(2);
   
   StudentDAO dao=StudentDAO.getInstance();
   String number=dao.getStudentNumber(s_num);
   
   out.print(year+s_num+number);
   
%>