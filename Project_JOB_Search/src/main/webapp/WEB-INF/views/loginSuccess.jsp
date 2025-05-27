<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- HEADER 입력 -->
<jsp:include page="../../resources/reset/header.jsp" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>로그인 확인</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
   href="${pageContext.request.contextPath}/resources/common.css" />
<link rel="stylesheet"
   href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<style>

@font-face {
    font-family: 'GmarketSansMedium';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
body {
	background: linear-gradient(to bottom right, #ecfae0, #fff);
   font-family: 'Segoe UI', '맑은 고딕', sans-serif;
   background-color: #ffffff;
   text-align: center;
}

.main-container {
   max-width: 900px;
   margin: 0 auto 0 auto;
   padding: 30px 20px;
}

.welcome-banner {
   width: 100%;
   background-color: #d4edda;
   padding: 30px 0;
}

.welcome-inner {
    max-width: 860px;
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

.major-content {
  display: flex;
  align-items: center;     /* 세로 중앙정렬 */
  justify-content: center;
  gap: 40px;
  padding: 0 20px;
  margin-top: 20px;
}

/* 이미지 쪽 컨테이너는 flex 내에서 크기 고정 */
.major-division-logo img {
  width: 300px;   /* PC에서 이미지 크게 */
  max-width: 300px;
  min-width: 120px;
  height: auto;
  border-radius: 10px;
  display: block;
}

/* 전공 리스트 컨테이너도 크기 고정 후 오른쪽 여백 확보 */
.major-list {
  font-family: 'GmarketSansMedium';
  text-align: left;
  font-size: 1.15rem;
  line-height: 2.0;
  min-width: 180px;
  max-width: 250px;
  /* 아래 추가! */
  display: flex;
  flex-direction: column;
  justify-content: center;
  gap: 0.3em;
  /* justify-content: space-between 이기 때문에 
     패딩만으로도 오른쪽 공백이 생기지만, 
     더욱 확실히 주고 싶으면 margin-right 추가 가능 */
  /* margin-right: 20px; */
}	

.major-list p, .major-list li {
  margin: 0;
  white-space: nowrap;      /* 한 줄에 표시 */
  overflow: hidden;
  text-overflow: ellipsis;
}

	/* 모바일 반응형 처리 */
@media (max-width: 600px) {
  .major-content {
    flex-direction: column;
    align-items: center;
    gap: 10px;
    padding: 0 4vw;
  }
  .major-division-logo img {
    width: 70vw;
    min-width: 0;
    max-width: 95vw;
    margin-bottom: 10px;
  }
  .major-list {
    font-size: 1rem;
    text-align: center;
    min-width: 0;
    max-width: 100vw;
    line-height: 1.7;
    align-items: center;
  }
  .major-list p, .major-list li {
    white-space: normal;
    text-align: center;
  }
}

</style>
</head>
<body>
   <div class="main-container">
	<c:url var="searchUrl" value="/MySearch_result"/>
	
	<!-- 클릭 시 이동하도록 onclick, 커서 포인터 추가 -->
	<div  class="welcome-banner" onclick="location.href='${searchUrl}'" style="cursor:pointer;">
	  <div class="welcome-inner">
	    <h2>🌿 <c:out value="${name}" /> 님, 환영해요!</h2>
	    <p>추천된 전공은 <strong>${sessionScope.major_type} 계열 입니다!</strong></p>
	
	    <!-- 굵은 박스: 계열 이미지 + 전공 리스트 -->
	    <div class="major-content">
	      <div class="major-division-logo">
	        <c:if test="${not empty sessionScope.major_type}">
	          <img 
	            src="resources/img/${sessionScope.major_type}.png" 
	            alt="${sessionScope.major_type} 계열 로고" />
	        </c:if>
	        
	      </div>
	
	      <div class="major-list">
	        <c:if test="${not empty firstMajor}">
	          <p>1순위: <c:out value="${firstMajor}" /></p>
	        </c:if>
	        <c:if test="${not empty secondMajor}">
	          <p>2순위: <c:out value="${secondMajor}" /></p>
	        </c:if>
	        <c:if test="${not empty thirdMajor}">
	          <p>3순위: <c:out value="${thirdMajor}" /></p>
	        </c:if>
	      </div>
	    </div>
	    
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