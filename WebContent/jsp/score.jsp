<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
            $("input[type='button']").click(function(){
               if($("#name").val().replace(/\s/g,"")==""){
                  alert("이름을 입력해주세요");
                  $("#name").focus();
                  return;
               }
               if($("#point").val().replace(/\s/g,"")==""){
                  alert("점수를 입력해주세요");
                  $("#point").focus();
                  return;
               }
               $("#form1").attr({
                  "method":"post",
                  "action":"scoretag.jsp"
               })
               $("#form1").submit();
            });
         });
      </script>
   </head>
   
   <body>
      <h2>이름과 점수를 입력하세요</h2>
      <form name="form1" id="form1">
         <div>
            <label>이름 : </label>
            <input type="text" name="name" id="name" maxlength="5" placeholder="홍길동">
         </div>
         <div>
            <label>점수 : </label>
            <input type="text" name="point" id="point" maxlength="3" placeholder="88">
         </div>
         <div>
            <input type="button" value="입력완료">
            <input type="reset" value="다시쓰기">
         </div>
      </form>
   </body>
</html>