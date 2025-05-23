
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    com.smhrd.model.MemberVO mvo = (com.smhrd.model.MemberVO) session.getAttribute("loginUser");
    request.setAttribute("mvo", mvo);
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>설문 메인 페이지</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
    	@font-face {
		    font-family: 'Freesentation-9Black';
		    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/2404@1.0/Freesentation-9Black.woff2') format('woff2');
		    font-weight: 900;
		    font-style: normal;
		}
		
        body {
            background: linear-gradient(to bottom right, #ecfae0, #fff);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container-box {
            background: white;
            padding: 40px 20px;
            border-radius: 18px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.1);
            text-align: center;
            width: 100%;
            max-width: 400px;
            margin : 0 auto;
        }

        h1 {
        	font-family :'Freesentation-9Black';
        	font-size: 2rem;
            margin-bottom: 28px;
            font-weight: bold;
        }

        .btn {
            width: 100%;
            margin-bottom: 15px;
        }
        
        .btn-mypage{
        	background-color: #bde69c;
        	width: 100%;
            margin-bottom: 15px;
        }
        
        .btn, .btn-mypage {
		    width: 80%;
		    min-width: 170px;
		    font-size: 1.1rem;
		    font-weight: 600;
		    padding: 12px 0;
		    border-radius: 9px;
		    margin: 0 auto 15px auto;
		    display: block;
		}
        
        
        .btn-mypage:hover {
   			background-color: #76b541; /* 호버 시 약간 어둡게 */
    		color: white;
		}
		

        .welcome-msg {
            font-size: 1.15rem;
            font-weight: 700;
            margin-bottom: 24px;
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
