<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import=java.util.ArrayList, com.student.StudentVO,com.student.StudentDAO" %>
<%
	StudentDAO dao = StudentDAO.getInstance();
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
      <script type="text/javascript">
         $(function(){
            $("#studentInsert").click(function(){
               location.href="studentForm.jsp";
            });
            $(".deleteBtn").click(function(){
               if(confirm("선택한 학생 정보를 삭제하시겠습니까?")){
                  var tr=$(this).parents("tr");
                  var no=tr.attr("data-no");
                  //console.log(no);
                  $.ajax({
                     url:"delete.jsp",
                     type:"post",
                     data:"no="+no,
                     dataType:"text",
                     success:function(data){
                        if(Boolean(data)==true){
                           alert("선택한 학생 정보가 삭제를 완료되었습니다.");
                           view(tr);
                        }else{
                           alert("선택한 학생 정보를 정상적으로 완료하지 못하였습니다. \n잠시 후 다시 시도해 주세요.");
                        }
                     },
                     error:function(xhr,textStatus,errorThrown){
                        alert("잠시 후에 다시 도전해라");
                     }
                  });   
               }
            });
         });
         
         function view(target){
            target.remove();
            var counter=parseInt($("#counter").html());
            $("#counter").html(--counter);
         }
      </script>
   </head>
   
   <body>
      <h3>자바 빈즈 StudentDAO를 통해 테이블 student 조회 프로그램</h3>
      <hr/>
      <div class="tr"><input type="button" value="학생정보등록" id="studentInsert" /></div>
      <table>
         <thead>
            <tr>
               <th>학번</th>
               <th>이름</th>
               <th>아이디</th>
               <th>학과명</th>
               <th>생년월일</th>
               <th>휴대폰</th>
               <th>주소</th>
               <th>이메일</th>
               <th>등록일</th>
               <th>삭제여부</th>
            </tr>
         </thead>
         <tbody>
            <%if(counter > 0){
               for(StudentVO stdt:list){
                  /*for(int i=0; i<counter;i++){
                     StudentVO stdt=list.get(i);*/
            %>
               <tr class="tc" data-no="<%=stdt.getNo() %>">
                  <td><%=stdt.getSd_num() %></td>
                  <td><%=stdt.getSd_name() %></td>
                  <td class="tl"><%=stdt.getSd_id() %></td>
                  <td><%=stdt.getS_num() %></td>
                  <td><%=stdt.getSd_birth() %></td>
                  <td><%=stdt.getSd_phone() %></td>
                  <td class="tl"><%=stdt.getSd_address() %></td>
                  <td class="tl"><%=stdt.getSd_email() %></td>
                  <td><%=stdt.getSd_date() %></td>
                  <td><button type="button"class="deleteBtn">삭제</button></td>
               </tr>
            <%
                }
               }else{
            %>
               <tr>
                  <td colspan="9" class="tc">조회된 학생 정보가 존재하지 않습니다.</td>
               </tr>
            <%} %>
         </tbody>
      </table>
      <div class="tr">조회된 학생 수가 <span id="counter"><%=counter %></span>명 입니다.</div>
   </body>
</html>