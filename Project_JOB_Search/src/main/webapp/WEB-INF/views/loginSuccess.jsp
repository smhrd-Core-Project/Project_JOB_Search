<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>로그인 확인</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/common.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            font-family: 'Segoe UI', '맑은 고딕', sans-serif;
            background: linear-gradient(135deg, #e9fbe9, #d4f1d4);
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .welcome-banner {
            background-color: #f0fff0;
            padding: 60px 30px;
            width: 100%;
            max-width: 800px;
            text-align: center;
            border-bottom: 2px dashed #b2dfdb;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            margin-top: 30px;
            border-radius: 20px;
        }

        .welcome-banner h2 {
            font-size: 28px;
            color: #4caf50;
            margin-bottom: 10px;
        }

        .welcome-banner p {
            font-size: 16px;
            color: #4e6e4e;
        }

        .btn-cute {
            margin-top: 20px;
            background-color: #a5d6a7;
            color: white;
            font-weight: bold;
            padding: 12px 24px;
            border: none;
            border-radius: 30px;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }

        .btn-cute:hover {
            background-color: #81c784;
        }

        .main-container {
            background-color: #ffffff;
            padding: 40px;
            max-width: 900px;
            width: 100%;
            margin: 30px auto;
            border-radius: 16px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.06);
            text-align: center;
        }

        section h3 {
            color: #2e7d32;
            margin-bottom: 15px;
        }

        ul {
            list-style: none;
            padding-left: 0;
            margin-bottom: 20px;
        }

        li {
            margin-bottom: 10px;
            font-size: 15px;
        }

        hr {
            border: 1px dashed #a5d6a7;
            margin: 40px 0;
        }

        .btn {
            background-color: #81c784;
            color: white;
            border-radius: 20px;
            padding: 8px 16px;
            font-size: 14px;
        }

        .btn:hover {
            background-color: #66bb6a;
        }
    </style>
</head>
<body>

    
    <div class="welcome-banner">
        <h2>🌿 <c:out value="${name}" /> 님, 환영해요!</h2>
        <p>성공적으로 로그인되었어요! <br>좋은 하루 되세요 🌱</p>
        <a href="${pageContext.request.contextPath}/" class="btn-cute">메인 페이지로 가기 🏡</a>
    </div>

    
    <c:import url="/header" />
    <div class="main-container">

        <!-- 인기 진로 게시판 -->
        <section>
            <h3>📘 인기 진로 게시판</h3>
            <c:choose>
                <c:when test="${empty list_C}">
                    <p>정보가 없습니다!</p>
                </c:when>
                <c:otherwise>
                    <ul>
                        <c:forEach var="item" items="${list_C}" varStatus="stat">
                            <c:if test="${stat.index < 8}">
                                <li>
                                    <a href="<c:url value='/CareerBoardDetail?boardCareerId=${item.boardCareerId}'/>">
                                        <c:out value="${item.title}" />
                                    </a> <span>(댓글 ${item.comments})</span>
                                </li>
                            </c:if>
                        </c:forEach>
                    </ul>
                </c:otherwise>
            </c:choose>
            <a href="<c:url value='/careerboard'/>" class="btn">진로 게시판 가기</a>
        </section>

        <hr />

        <!-- 인기 자유 게시판 -->
        <section>
            <h3>🗨️ 인기 자유 게시판</h3>
            <c:choose>
                <c:when test="${empty list_F}">
                    <p>정보가 없습니다!</p>
                </c:when>
                <c:otherwise>
                    <ul>
                        <c:forEach var="item" items="${list_F}" varStatus="stat">
                            <c:if test="${stat.index < 8}">
                                <li>
                                    <a href="<c:url value='/FreeBoardDetail?post_idx=${item.post_idx}'/>">
                                        <c:out value="${item.title}" />
                                    </a> <span>(댓글 ${item.comments})</span>
                                </li>
                            </c:if>
                        </c:forEach>
                    </ul>
                </c:otherwise>
            </c:choose>
            <a href="<c:url value='/FreeBoard'/>" class="btn">자유 게시판 가기</a>
        </section>

    </div>
    <c:import url="/footer" />
</body>
</html>
