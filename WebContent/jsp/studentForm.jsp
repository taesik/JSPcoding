<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, com.subject.SubjectVO, com.subject.SubjectDAO" %>
<%
   SubjectDAO dao=SubjectDAO.getInstance();
   ArrayList<SubjectVO> list=dao.getSubjectList();
   int counter=list.size();
%>
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
      <script type="text/javascript" src="../js/jquery-1.12.4.min.js"></script>
      <script type="text/javascript" src="../js/common.js"></script>
      <script type="text/javascript">
         $(function(){
            $("#s_num").change(function(){
               if($("#s_num > option:selected").index()>0){
                  $.ajax({
                     url:"result.jsp",
                     type:"post",
                     data:"s_num="+$("#s_num").val(),
                     dataType:"text",      //받는 값 (result.jsp로 부터)
                     success:function(data){
                        $("#sd_num").val(data);
                     },
                     error: function(xhr,textStatus,errorThrown){
                        alert("잠시 후에 다시 시도해 주세요.");
                     }
                  });
               }else{
                  $("#sd_num").val("");
               }
            });
            
            //아이디 중복 체크
            $("#sd_name").keyup(function(){
               
               if($("#sd_id").val().replace(/\s/g,"")!=""){
                  $.ajax({
                     url:"idcheck.jsp",
                     type:"post",
                     data:"sd_id="+$("#sd_id").val(),
                     dataType:"text",
                     success:function(data){
                        if(parseInt(data)==1){
                           //alert("중복된 아이디 입니다. 다시 입력해 주세요.");
                           $("#sd_id").val("");
                           $("#sd_id").focus();
                           $("#sd_id").attr("placeholder","중복된 아이디 입니다. 다시 입력해주세요.");
                        }
                     },
                     error:function(xhr,textStatus,errorThrown){
                        alert("잠시 후에 다시 도전해라");
                     }
                  });
               }
            });
            
            //다시쓰기 버튼 제어
            $("#resetBtn").click(function(){
               $("#student").each(function(){
                  this.reset();
               })
            })
            
            //목록으로 돌아가기
            $("#listBtn").click(function(){
               location.href="studentList.jsp";
            })
            
               // "입력완료" 버튼 제어
               $("#insertBtn").click(function(){
                  /*if(!chkSubmit($('#sd_num'),"학생 번호를")) return;
                  else */ if($("#s_num > option:selected").index() == 0){
                     alert("학과명 선택해주세요");
                     return;
                  }
                  else if(!chkSubmit($('#sd_id'),"아이디를")) return;
                  else if(!chkSubmit($('#sd_name'),"이름을")) return;
                  else if(!chkSubmit($('#sd_birth'),"생년월일을")) return;
                  else if(!chkSubmit($('#sd_passwd'),"비밀번호를")) return;
                  else if(!chkSubmit($('#sd_phone'),"휴대전화번호를")) return;
                  else if(!chkSubmit($('#sd_email'),"이메일을")) return;
                  else if(!chkSubmit($('#sd_address'),"주소를")) return;
                  else {
                     $("#student").attr({
                        "method":"post",
                        "action":"studentPro.jsp"
                     });
                     $("#student").submit();
                  }
                     
               });
         })
      </script>
   </head>
   
   <body>
      <h3>테이블 student 학생 정보 등록 프로그램</h3>
      <hr />
      <form id="student" name="student">
         <table summary="학생 정보 등록을 위한 입력 페이지">
            <colgroup>
            <thead>
               <tr>
                  <th colspan="2">학생 정보 등록</th>
               </tr>
            </thead>
            <tbody>
               <tr>
                  <th class="ls3">학생 번호</th>
                  <td class="t2"><input type="text" name="sd_num" id="sd_num" placeholder="학과명을 선택하면 자동으로 부여" readonly="readonly" maxlength="8"></td>
               </tr>
               <tr>
                  <th class="ls5">학과 명</th>
                  <td class="t2">
                     <select name="s_num" id="s_num">
                        <option>학과를 선택해 주세요</option>
                        <%
                           if(counter>0){
                              for(SubjectVO stdt:list){
                        %>
                        <option value="<%=stdt.getS_num() %>"><%=stdt.getS_name() %></option>
                        <%
                              }
                           }
                        %>
                     </select>
                  </td>
               </tr>
               <tr>
                  <td class="t1">아이디</td>
                  <td class="t2"><input type="text" name="sd_id" id="sd_id" maxlength="14"></td>
               </tr>
               <tr>
                  <td class="t1">학생 이름</td>
                  <td class="t2"><input type="text" name="sd_name" id="sd_name" maxlength="8"></td>
               </tr>
               <tr>
                  <td class="t1">생년 월일</td>
                  <td class="t2"><input type="date" name="sd_birth" id="sd_birth"></td>
               </tr>
               <tr>
                  <td class="t1">비밀 번호</td>
                  <td class="t2"><input type="password" name="sd_passwd" id="sd_passwd" maxlength="20"></td>
               </tr>
               <tr>
                  <td class="t1">전화 번호</td>
                  <td class="t2"><input type="text" name="sd_phone" id="sd_phone" maxlength="20"></td>
               </tr>
               <tr>
                  <td class="t1">이메일</td>
                  <td class="t2"><input type="email" name="sd_email" id="sd_email" maxlength="50"></td>
               </tr>
               <tr>
                  <td class="t1">학생 주소</td>
                  <td class="t2"><input type="text" name="sd_address" id="sd_address"></td>
               </tr>
               <tr>
                  <td colspan="2" align="center">
                     <input type="button" value="입력완료" id="insertBtn">
                     <input type="button" value="다시쓰기" id="resetBtn">
                     <input type="button" value="목록" id="listBtn">
                  </td>
               </tr>
            </tbody>
         </table>
      </form>
   </body>
</html>