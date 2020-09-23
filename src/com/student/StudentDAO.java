package com.student;
/* DAO(Data Access Object) Ŭ������ ������ ó���� �ñ����� �ܰ��̴�
 * 
 * CRUD ���α׷� ����
 * �⺻���� ������ ó�� ����� �Է�(Create, insert), ��ȸ(Read(���� Retrieve), Select), 
 * ����(Delete), ����� ������ ������ ���̽� ���α׷�.
 */

import java.sql.*;
import java.sql.Connection;
import java.util.ArrayList;


//���̺� student�� ���� �����ͺ��̽� ���� �ڹٺ��� ���α׷�
public class StudentDAO {
   //������ ���̽� ���� ���� ��� ����
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
    * studentDelete() �޼���: �л� ���� ����
    * @param ������ ��ȣ
    * @return boolean �ڷ��� ����.
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
         System.out.println("������ studentDelete error = [ "+se+" ] ");
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
            System.out.println("��� ���� ���� error = [ "+e+" ] ");
         }
      }
      return success;
   }
   
   /********************************************************************
    * idcheck()�޼���: �л� ���̺��� id ���翩�� Ȯ�� �޼ҵ�
    * @param (String ����� ���̵�)
    * @return int �ڷ��� ����.
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
         System.out.println("������ idCheck error = [ "+se+" ] ");
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
    * studentInsert() �޼���: �л� ���̺��� ���ڵ� �Է� �޼���
    * @param StudentVO.
    * @return int �ڷ��� ����.
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
            System.out.println("������ studentInsert error = [ "+se+" ] ");
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
       * getStudentNumbe(String subjectNum) �޼ҵ� : �й� ���� 
       * @param subjectNum
       * @return String Ÿ��
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
         System.out.println("���� getStudentNumber error = [ "+se+" ] ");
         se.printStackTrace();
      }catch(Exception e) {
         System.out.println("error getStudentNumber= [ "+e+" ] ");
      }finally {
         try {
            if(rs!=null)rs.close();
            if(pstmt!=null)pstmt.close();
            if(con !=null) con.close();
         }catch(SQLException e) {
            System.out.println("��� ���� ���� error = [ "+e+" ] ");
         }
      }
      return serialNumber;
   }
   
   /**************************************************************************************
    * getStudentList() �޼ҵ� : �л����� ��ȸ
    * @return ArrayList<StudentVO> ����.
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
         
         //ResultSet�� ������� ��� ���� ������ StudentVO ��ü�� ����
         while(rs.next()) {
            //�� ���� �л������� ������ �л��� ���� ���� ��ü ����
            vo = new StudentVO();
            
            //�� ���� �л������� �ڹ� ���� ��ü�� ����
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