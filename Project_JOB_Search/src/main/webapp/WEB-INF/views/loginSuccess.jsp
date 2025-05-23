<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- HEADER 입력 -->
<jsp:include page="../../resources/reset/header.jsp" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>로그인 확인</title>
<link rel="stylesheet"
   href="${pageContext.request.contextPath}/resources/common.css" />
<link rel="stylesheet"
   href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<style>
body {
   font-family: 'Segoe UI', '맑은 고딕', sans-serif;
   background-color: #ffffff;
   text-align: center;
}

.main-container {
   max-width: 600px;
   margin: 0 auto 0 auto;
   padding: 30px 20px;
}

.welcome-banner {
   width: 100%;
   background-color: #d4edda;
   padding: 30px 0;
}

.welcome-inner {
    max-width: 500px;
    margin: auto;
    text-align: center;
}

.welcome-inner h2 {
   font-size: 20px;
   color: #2e7d32;
}

.btn-cute {
   background-color: #4caf50;
   color: white;
   padding: 10px 24px;
   font-size: 14px;
   border: none;
   border-radius: 30px;
   text-decoration: none;
   display: inline-block;
   margin-top: 10px;
}

.btn-cute:hover {
   background-color: #388e3c;
}

section {
   margin-bottom: 30px;
}

section h3 {
   font-size: 18px;
   font-weight: bold;
   text-align: left;
   margin-bottom: 10px;
}

ul {
   padding-left: 0;
   list-style: none;
   margin-bottom: 10px;
}

li {
   text-align: left;
   font-size: 15px;
   margin-bottom: 8px;
   display: flex;
   justify-content: space-between;
   align-items: center;
}

li a {
   text-decoration: none;
   color: #333;
}

.post-meta {
   font-size: 13px;
   color: #777;
}

.btn-wide-green {
   display: inline-block;
   background-color: #00c853;
   color: white;
   border: none;
   border-radius: 40px;
   padding: 14px 0;
   width: 100%;
   font-size: 16px;
   font-weight: bold;
   text-decoration: none;
}

.btn-wide-green:hover {
   background-color: #00b94c;
}
</style>
</head>
<body>
   <div class="main-container">

      
      <div class="welcome-banner">
         <div class="welcome-inner">
            <h2>
               🌿
               <c:out value="${name}" />
               님, 환영해요!
            </h2>
            <p>
               성공적으로 로그인되었어요! <br>좋은 하루 되세요 🌱
            </p>
         </div>
      </div>
	  <br>
      
      <section>
         <h3>진로 게시판</h3>
         <c:choose>
            <c:when test="${empty list_C}">
               <p>정보가 없습니다!</p>
            </c:when>
            <c:otherwise>
               <ul>
                  <c:forEach var="item" items="${list_C}" varStatus="stat">
                     <c:if test="${stat.index < 3}">
                        <li><a
                           href="<c:url value='/CareerBoardDetail?boardCareerId=${item.boardCareerId}'/>">
                              ${item.title} </a> <span class="post-meta">❤️ ${item.likes}
                              💬 ${item.comments}</span></li>
                     </c:if>
                  </c:forEach>
               </ul>
            </c:otherwise>
         </c:choose>
         <a href="<c:url value='/careerboard'/>" class="btn-wide-green">더
            보러 가기</a>
      </section>
	  <br>
      
      <section>
         <h3>자유 게시판</h3>
         <c:choose>
            <c:when test="${empty list_F}">
               <p>정보가 없습니다!</p>
            </c:when>
            <c:otherwise>
               <ul>
                  <c:forEach var="item" items="${list_F}" varStatus="stat">
                     <c:if test="${stat.index < 3}">
                        <li><a
                           href="<c:url value='/FreeBoardDetail?post_idx=${item.post_idx}'/>">
                              ${item.title} </a> <span class="post-meta">❤️ ${item.likes}
                              💬 ${item.comments}</span></li>
                     </c:if>
                  </c:forEach>
               </ul>
            </c:otherwise>
         </c:choose>
         <a href="<c:url value='/FreeBoard'/>" class="btn-wide-green">더 보러
            가기</a>
      </section>

   </div>
<!-- FOOTER 입력 -->
<jsp:include page="../../resources/reset/footer.jsp" />
</body>
</html>