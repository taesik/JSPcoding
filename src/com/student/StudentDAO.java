package com.student;
/* DAO(Data Access Object) 클래스가 데이터 처리의 궁극적인 단계이다
 * 
 * CRUD 프로그램 구현
 * 기본적인 데이터 처리 기능인 입력(Create, insert), 조회(Read(꼬는 Retrieve), Select), 
 * 삭제(Delete), 기능을 구현헌 데이터 베이스 프로그램.
 */

import java.sql.*;
import java.sql.Connection;
import java.util.ArrayList;


//테이블 student를 위한 데이터베이스 연동 자바빈즈 프로그램
public class StudentDAO {
   //데이터 베이스 연결 관련 상수 선언
   private static final String JDBC_URL = "jdbc:oracle:thin:@127.0.0.1:1521:orcl";
   private static final String USER = "javauser";
   private static final String PASSWD = "java1234";
   
   private static StudentDAO instance = null;
   
   public static StudentDAO getInstance() {
      if(instance == null) {
         instance = new StudentDAO();
      }
      return instance;
   }
   
   private StudentDAO() {
      try {
         Class.forName("oracle.jdbc.driver.OracleDriver");
      } catch(ClassNotFoundException cnfe) {
         cnfe.printStackTrace();
      }
   }
   
   private Connection getConnection() throws SQLException {
      Connection con = DriverManager.getConnection(JDBC_URL, USER, PASSWD);
      return con;
   }
   
   /**********************************************************************
    * studentDelete() 메서드: 학생 정보 삭제
    * @param 삭제할 번호
    * @return boolean 자료형 리턴.
    **********************************************************************/
   
   public boolean studentDelete(int no) throws Exception{
      Connection con=null;
      PreparedStatement pstmt=null;
      boolean success=false;
      
      StringBuffer sql=new StringBuffer();
      sql.append("delete from student where no=?");
      
      try {
         con=getConnection();
         pstmt=con.prepareStatement(sql.toString());
         pstmt.setInt(1, no);
         int i=pstmt.executeUpdate();
         
         if(i==1) {
            success=true;
         }
         
      }catch(SQLException se) {
         System.out.println("쿼리문 studentDelete error = [ "+se+" ] ");
         se.printStackTrace();
         success=false;
      }catch(Exception e) {
         System.out.println("error studentDelete = [ "+e+" ]");
         e.printStackTrace();
         success=false;
      }finally {
         try {
            if(pstmt!=null) pstmt.close();
            if(con!=null) con.close();
         }catch(SQLException e) {
            System.out.println("디비 연동 해제 error = [ "+e+" ] ");
         }
      }
      return success;
   }
   
   /********************************************************************
    * idcheck()메서드: 학생 테이블의 id 존재여부 확인 메소드
    * @param (String 사용할 아이디)
    * @return int 자료형 리턴.
    **********************************************************************/
   
   public int idCheck(String sd_id) {
      Connection con=null;
      PreparedStatement pstmt=null;
      ResultSet rs=null;
      int result=0;
      
      StringBuffer sql=new StringBuffer();
      sql.append("select nvl((select 1 from student where sd_id=?),0) as state from dual");
      
      try {
         con=getConnection();
         pstmt=con.prepareStatement(sql.toString());
         pstmt.setString(1,sd_id);
         rs=pstmt.executeQuery();
         
         if(rs.next()) {
            result=rs.getInt("state");
         }
      }catch(SQLException se) {
         System.out.println("쿼리문 idCheck error = [ "+se+" ] ");
         se.printStackTrace();
      }catch(Exception e) {
         System.out.println("error idCheck= [ "+e+" ]");
         e.printStackTrace();
      }finally {
         try {
            if(rs!=null)rs.close();
            if(pstmt!=null) pstmt.close();
            if(con !=null) con.close();
         }catch(SQLException e) {
            e.printStackTrace();
         }
      }
      return result;
   }
   
   /************************************************************************************
    * studentInsert() 메서드: 학생 테이블의 레코드 입력 메서드
    * @param StudentVO.
    * @return int 자료형 리턴.
    * @throws Exception
    **************************************************************************************/
   
      public int studentInsert(StudentVO vo) {
         Connection con=null;
         PreparedStatement pstmt=null;
         
         StringBuffer sql = new StringBuffer();
         sql.append("insert into student(no,sd_num,sd_name,sd_id,sd_passwd,s_num,sd_birth,sd_phone,sd_address,sd_email,sd_date)"); 
         sql.append("values(student_seq.nextval,?,?,?,?,?,?,?,?,?,sysdate)");
         int rowCount=0;
         try {
            con=getConnection();
            pstmt=con.prepareStatement(sql.toString());
            
            pstmt.setString(1, vo.getSd_num());
            pstmt.setString(2, vo.getSd_name());
            pstmt.setString(3, vo.getSd_id());
            pstmt.setString(4, vo.getSd_passwd());
            pstmt.setString(5, vo.getS_num());
            pstmt.setString(6, vo.getSd_birth().replace("-",""));
            pstmt.setString(7, vo.getSd_phone());
            pstmt.setString(8, vo.getSd_address());
            pstmt.setString(9, vo.getSd_email());
            
            rowCount=pstmt.executeUpdate();
            
         }catch(SQLException se) {
            System.out.println("쿼리문 studentInsert error = [ "+se+" ] ");
            se.printStackTrace();
         }catch(Exception e) {
            System.out.println("error studentInsert = [ "+e+" ] ");
            e.printStackTrace();
         }finally {
            try {
               if(pstmt!=null) pstmt.close();
               if(con!=null) con.close();
            }catch(SQLException e) {
               e.printStackTrace();
            }
         }
         return rowCount;
      }
      
      /**************************************************************
       * getStudentNumbe(String subjectNum) 메소드 : 학번 생성 
       * @param subjectNum
       * @return String 타입
       * @throws Exception
       **************************************************************/
   
   public String getStudentNumber(String subjectNum) throws Exception{
      StringBuffer sql=new StringBuffer();
      sql.append("select nvl(lpad(max(to_number(ltrim(substr(sd_num,5,4),'0')))+1,4,'0'),'0001')as studentNumber from student where s_num=?");
      
      Connection con=null;
      PreparedStatement pstmt=null;
      ResultSet rs=null;
      String serialNumber="";
      
      try {
         con=getConnection();
         pstmt=con.prepareStatement(sql.toString());
         pstmt.setString(1, subjectNum);
         rs=pstmt.executeQuery();
         if(rs.next()){
            serialNumber=rs.getString("studentNumber");
         }
      }catch(SQLException se) {
         System.out.println("쿼리 getStudentNumber error = [ "+se+" ] ");
         se.printStackTrace();
      }catch(Exception e) {
         System.out.println("error getStudentNumber= [ "+e+" ] ");
      }finally {
         try {
            if(rs!=null)rs.close();
            if(pstmt!=null)pstmt.close();
            if(con !=null) con.close();
         }catch(SQLException e) {
            System.out.println("디비 연동 해제 error = [ "+e+" ] ");
         }
      }
      return serialNumber;
   }
   
   /**************************************************************************************
    * getStudentList() 메소드 : 학생정보 조회
    * @return ArrayList<StudentVO> 리턴.
    **************************************************************************************/
   
   public ArrayList<StudentVO> getStudentList(){
      Connection con = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      ArrayList<StudentVO> list = new ArrayList<StudentVO>();
      StudentVO vo = null;
      
      StringBuffer sql = new StringBuffer();
      sql.append("select st.no as no, sd_num, sd_name, sd_id, s_name as s_num, sd_birth, ");
      sql.append("sd_phone, sd_address, sd_email, sd_date from student st inner join subject su on st.s_num=su.s_num");
      
      try {
         con = getConnection();
         pstmt = con.prepareStatement(sql.toString());
         rs = pstmt.executeQuery();
         
         //ResultSet의 결과에서 모든 행을 각각의 StudentVO 객체에 저장
         while(rs.next()) {
            //한 행의 학생정보를 저장할 학생을 위한 빈즈 객체 생성
            vo = new StudentVO();
            
            //한 행의 학생정보를 자바 빈즈 객체에 저장
            vo.setNo(rs.getInt("no"));
            vo.setSd_num(rs.getString("sd_num"));
            vo.setSd_name(rs.getString("sd_name"));
            vo.setSd_id(rs.getString("sd_id"));
            vo.setS_num(rs.getString("s_num"));
            vo.setSd_birth(rs.getString("sd_birth"));
            vo.setSd_phone(rs.getString("sd_phone"));
            vo.setSd_address(rs.getString("sd_address"));
            vo.setSd_email(rs.getString("sd_email"));
            vo.setSd_date(rs.getString("sd_date"));
            
            list.add(vo);
         }
      } catch(SQLException e) {
         e.printStackTrace();
      } catch(Exception e) {
         e.printStackTrace();
      } finally {
         try {
            if(rs != null) rs.close();
            if(pstmt != null) pstmt.close();
            if(con != null) con.close();
         } catch(SQLException e) {
            e.printStackTrace();
         }
      }
      return list;
   } 
}