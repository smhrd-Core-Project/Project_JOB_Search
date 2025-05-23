<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String userId = request.getParameter("id");
%>
<jsp:include page="../../resources/reset/header.jsp" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원가입 완료</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Gamja+Flower&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.18/dist/sweetalert2.min.css">
    <style>
        @font-face {
            font-family: 'DungGeunMo';
            src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_six@1.2/DungGeunMo.woff') format('woff');
        }

        body {
            font-family: 'DungGeunMo', cursive;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-size: cover;
            background-position: 70% center;
            background-repeat: no-repeat;
            background-attachment: fixed;
            overflow: hidden;
        }

        body::before {
            content: "";
            position: fixed;
            top: 0; left: 0; right: 0; bottom: 0;
            background-color: rgba(255, 255, 255, 0.7);
            z-index: -1;
        }

        .container {
            text-align: center;
            background-color: rgba(255, 255, 255, 0.85);
            margin: 0 auto;
            padding: 30px 20px;
            border-radius: 0px;
            box-shadow: 4px 0px 10px -4px rgba(0,0,0,0.05),    /* 오른쪽 */
       					-4px 0px 10px -4px rgba(0,0,0,0.05);    /* 왼쪽 */
            z-index: 1;
            position: relative;
            max-width: 900px;
            min-width: 300px;
            width: 100%;
            box-sizing: border-box;
            backdrop-filter: blur(6px);
        }

        h1, h2 {
            margin-bottom: 1rem;
            color: #333;
        }

        p {
            font-size: 1rem;
            margin-bottom: 2rem;
        }

        .btn {
            display: inline-block;
            padding: 10px 20px;
            margin: 0 10px;
            border: none;
            border-radius: 5px;
            background-color: #3498db;
            color: white;
            text-decoration: none;
            font-size: 1rem;
            transition: background-color 0.3s ease;
        }

        .btn:hover {
            background-color: #2980b9;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1><%= userId %>님, TEENNECT에 오신 것을 환영합니다!</h1>
        <p>회원이 되신 것을 진심으로 축하드립니다.</p>
        <div class="buttons">
            <a href="${pageContext.request.contextPath}/Login" class="btn">로그인</a>
            <a href="${pageContext.request.contextPath}" class="btn">메인 페이지</a>
        </div>
    </div>
<jsp:include page="../../resources/reset/footer.jsp" />
</body>
</html>
