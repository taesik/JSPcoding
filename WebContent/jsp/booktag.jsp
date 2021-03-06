<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<meta charset="utf-8" />
		<!-- html4 : 파일의 인코딩 방식 지정 -->
		<!--<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />-->

		<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1" />
		<!-- 브라우저의 호환성 보기 모드를 막고, 해당 브라우저에서 지원하는 가장 최신 버전의 방식으로 HTML 보여주도록 설정.-->
		
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
		<!--viewport : 화면에 보이는 영역을 제어하는 기술. width는 device-width로 설정(브라우저 너비를 장치 너비에 맞추어 표시). initial-scale는 초기비율(보이는 영역과 웹 페이지를 맞춤). user-scalable는 사용자가 화면축소를 하지 못하도록 설정.-->
      			
		<link rel="shortcut icon" href="../image/icon.png" />
		<link rel="apple-touch-icon" href="../image/icon.png" />
				
		<!-- IE8 이하에서 HTML5를 인식시키기 위해 아래의 패스필터를 적용-->
		<!--[if lt IE 9]>
			<script src="../js/html5shiv.js"></script>
		<![endif]--> 
		<script type="text/javascript" src="../js/jquery-1.12.4.min.js"></script>
      <script type="text/javascript">
         $(function(){
            $("input[type='button']").click(function(){
               if($("#bookerName").val().replace(/\s/g,"")==""){
                  alert("이름을 입력해주세요");
                  $("#bookerName").focus();
                  return;
               }
               if($("#bookerColor").val().replace(/\s/g,"")==""){
                  alert("점수를 입력해주세요");
                  $("#point").focus();
                  return;
               }
               $("#form1").attr({
                  "method":"post",
                  "action":"book.jsp"
               })
               $("#form1").submit();
            });
         });
      </script>

<title>Insert title here</title>
	</head>
	<body>
		<h3>요청 폼</h3>
		<hr>
		<form name="form1" id="form1">
         <div>
            <label>예약자명 : </label>
            <input type="text" name="bookerName" id="BookerName" maxlength="5" placeholder="dd">
         </div>
         <div>
            <label>예약컬러 : </label>
            <input type="color" name="bookerColor" id="bookerColor" maxlength="3" placeholder="88">
         </div>
         <div>
            <input type="button" value="예약완료">
            <input type="reset" value="다시쓰기">
         </div>
      </form>
		
		
	</body>
</html>