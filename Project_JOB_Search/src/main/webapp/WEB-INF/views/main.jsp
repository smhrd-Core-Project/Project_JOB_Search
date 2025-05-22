
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<<<<<<< HEAD

=======
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    com.smhrd.model.MemberVO mvo = (com.smhrd.model.MemberVO) session.getAttribute("loginUser");
    request.setAttribute("mvo", mvo);
%>
>>>>>>> branch 'Develop1.0' of https://github.com/smhrd-Core-Project/Project_JOB_Search.git
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>설문 메인 페이지</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(to bottom right, #e0f7fa, #fff);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container-box {
            background: white;
            padding: 40px;
            border-radius: 16px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.1);
            text-align: center;
            width: 90%;
            max-width: 400px;
        }

        h1 {
            margin-bottom: 20px;
            font-weight: bold;
        }

        .btn {
            width: 100%;
            margin-bottom: 15px;
        }
        
        .btn-mypage{
        	background-color: aqua;
        	width: 100%;
            margin-bottom: 15px;
        }
        
        .btn-mypage:hover {
   			background-color: #00bcd4; /* 호버 시 약간 어둡게 */
    		color: white;
		}

        .welcome-msg {
            font-size: 1.2rem;
            font-weight: 500;
            margin-bottom: 20px;
        }

        a {
            display: block;
            margin: 5px 0;
        }
    </style>
</head>
<body>

<div class="container-box">
    <h1>틴넥트</h1>

    <!-- 로그인 안 했을 때 -->
    <c:if test="${mvo == null}">
        <a href="Login" class="btn btn-primary">로그인</a>
        <a href="surveyMain" class="btn btn-outline-primary">설문조사 시작</a>
    </c:if>

    <!-- 로그인 했을 때 -->
    <c:if test="${mvo != null}">
        <div class="welcome-msg">${mvo.name} 님 반갑습니다!</div>
        <a href="surveyMain" class="btn btn-outline-primary">설문조사 시작</a>
        <a href="MyPage" class="btn btn-mypage">마이페이지</a>
        <a href="Logout" class="btn btn-secondary">로그아웃</a>

    </c:if>
</div>


</body>
</html>
