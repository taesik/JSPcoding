<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
    String pagefile=request.getParameter("page");
    if(pagefile==null){
       pagefile="newitem";
    }
    String pagefileex=".jsp";
    
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
      <link href='http://fonts.googleapis.com/css?family=Paytone+One' rel='stylesheet' type='text/css'>
      <link href="http://netdna.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.css" rel="stylesheet">
      
      <link rel="stylesheet" href="../contents/css/contents.css">
      
      <script type="text/javascript" src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
      <script type="text/javascript">
         $(function(){
            $("#menubtn").click(function(){
               $("#menu").slideToggle();
            });
         });
      </script>
   </head>
   
   <body class="contents">
      <jsp:include page="top.jsp"/>

      <div class="box7">
         <jsp:include page="<%=pagefile+pagefileex %>"/>
         
         <jsp:include page="left.jsp"/>
      </div>
      <jsp:include page="bottom.jsp"/>
   </body>
</html>