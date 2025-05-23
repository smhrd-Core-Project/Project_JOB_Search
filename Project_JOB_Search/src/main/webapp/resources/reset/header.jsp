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
<title>Header</title>
<link rel="stylesheet" href="${context}resources/reset/header.css" type="text/css">

</head>

<body>
    <div class="header-container">
        <!-- 좌측: 뒤로가기 -->
        <div class="header-side">
            <button class="header-btn" onclick="history.back();">
                <img src="<%= request.getContextPath() %>/resources/img/back.png" alt="back">

            </button>
        </div>
        
        <!-- 중앙: 로고 -->
        <div class="header-logo">
            <a href="${context}loginSuccess">
                <img src="<%= request.getContextPath() %>/resources/img/teennect_logo.png" alt="logo">

            </a>
        </div>
        
        <!-- 우측: 마이페이지 -->
        <div class="header-side">
            <a class="header-btn" href="${context}MyPage">
                <img src="<%= request.getContextPath() %>/resources/img/myPage.png" alt="MyPage">

            </a>
        </div>
    </div>
</body>
</html>
