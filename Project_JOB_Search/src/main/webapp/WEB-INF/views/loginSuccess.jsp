<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/common.css" />
    <meta charset="UTF-8">
    <title>로그인 확인</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin-top: 100px;
        }
        .btn {
            display: inline-block;
            margin-top: 30px;
            padding: 10px 20px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 6px;
            text-decoration: none;
        }
        .btn:hover {
            background-color: #2980b9;
        }
    </style>
</head>
<body>
	<div class ="main-container">

	    <h2>환영합니다, <c:out value="${name}" />님!</h2>
	    <p>로그인이 성공적으로 완료되었습니다.</p>
	    <a href="${pageContext.request.contextPath}/" class="btn">메인 페이지로 이동</a>
	    
	    <a href="Mypage" class="btn"> 마이페이지 가기</a>
	    <a href="careerBoard" class="btn"> 진로 게시판 가기</a>
	    <a href="FreeBoard" class="btn"> 자유 게시판 가기</a>
	    
    </div>
</body>
</html>
