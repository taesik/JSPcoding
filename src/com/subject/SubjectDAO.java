package com.subject;

import java.sql.*;
import java.sql.Connection;
import java.util.ArrayList;

public class SubjectDAO {
   //데이터베이스 연결관련 상수들
   private static final String JDBC_URL="jdbc:oracle:thin:@127.0.0.1:1521:orcl";
   private static final String USER="javauser";
   private static final String PASSWD="java1234";
   private static SubjectDAO instance=null;
   
   public static SubjectDAO getInstance() {
      if(instance==null) {
         instance=new SubjectDAO();
      }
      return instance;
   }
   
   private SubjectDAO() {
      try {
         Class.forName("oracle.jdbc.driver.OracleDriver");
      }catch(ClassNotFoundException cnfe) {
         cnfe.printStackTrace();
      }
   }
   
   private Connection getConnection() throws SQLException{
      Connection con=DriverManager.getConnection(JDBC_URL,USER,PASSWD);
      return con;
   }
   
   public ArrayList<SubjectVO> getSubjectList(){
      Connection con=null;
      PreparedStatement pstmt=null;
      ResultSet rs=null;
      ArrayList<SubjectVO> list=new ArrayList<SubjectVO>();
      SubjectVO vo=null;
      
      StringBuffer sql=new StringBuffer();
      sql.append("select no, s_num, s_name from subject order by no");
      
      try {
         con=getConnection();
         pstmt=con.prepareStatement(sql.toString());
         rs=pstmt.executeQuery();
         
         while(rs.next()) {
            vo=new SubjectVO();
            
            vo.setNo(rs.getInt("no"));
            vo.setS_num(rs.getString("s_num"));
            vo.setS_name(rs.getString("s_name"));
            
            list.add(vo);
         }
      }catch(SQLException e) {
         e.printStackTrace();
      }catch(Exception e) {
         e.printStackTrace();
      }finally {
         try {
            if(rs!=null)rs.close();
            if(pstmt!=null)pstmt.close();
            if(con!=null)con.close();
         }catch(SQLException e) {
            e.printStackTrace();
         }
      }
      return list;
   }
}