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

<title>Insert title here</title>
	</head>
	<body>
		<h3>자바 빈즈 StudentDAO를 통해 테이블 student 조회 프로그램</h3>
      	<hr/>
		<div class="tr"><input type = "button" value="학생정보등록"
		id="studentInsert" /></div>
		</div>
		<thead> 
			<tr>
				<th>학번 </th>
				<th>이름 </th>
				<th>아이디 </th>
				<th>학과명 </th>
				<th>생년월일 </th>
				<th>휴대폰 </th>
				<th>주소 </th>
				<th>이메일 </th>
				<th>등록일자 </th>
			</tr>
		</thead>
	</body>
	<% if(counter > 0) { 
			for(StudentVO stdt: list) {
	%>
				<tr class = "tc">
					<td><%= stdt.getSd_num() %> </td>
					<td><%= stdt.getSd_name() %> </td>
					<td class="tl"> </td>
					<td><%= stdt.getSd_num() %> </td>
					<td><%= stdt.getSd_birth() %> </td>
					<td><%= stdt.getSd_phone() %> </td>
					<td class ="tl"><%=stdt.getSd_address() %> </td>
					<td class ="tl"><%=stdt.getSd_email() %> </td>
					<td><%= stdt.getSd_date() %> </td>
				</tr>	
	<%
			}
		}else {	
	%>			
			<tr>
				<td colspan="9" class="tc"> 조회된 학생정보가 존재하지 않습니다. 
				</td>
			</tr>
	<%} %>				
</html>