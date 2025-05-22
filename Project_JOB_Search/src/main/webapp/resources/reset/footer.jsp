<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%
    String context = request.getContextPath() + "/";
    request.setAttribute("context", context);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>footer</title>
<link rel="stylesheet" href="${context}resources/reset/footer.css" type="text/css">

</head>
<body>

   <div class="footer">
      <div class="footer_Content">
         <div class="inner">
            <img src="<%= request.getContextPath() %>/resources/img/teennect_logo.png" alt="logo">
            
            <div class="footer_teamInfo">
               TEAM TEENNECT | 팀원 : 김다현, 문경서, 박병록, 백경현, 차영주 | 서울 스마트인재개발원 <br>
               주소 : 서울 마포구 양화로 85 동현빌딩 5층 | 메일 : smhrd@smhrd.or.kr | 전화 : 1522-7800
            </div>

            <div class="footer_contentSummary">
               <p>TEAM TEENNECT는 서울 스마트인재개발원 데이터분석 SW 엔지니어 양성과정 핵심 프로젝트를 진행하고 있다.</p>
            </div>
         </div>
      </div>
   </div>

</body>
</html>