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
<c:import url="/header"/>
	<div class ="main-container">
		
		
		<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 인기 진로 게시판 -->
<section>
  <h3>인기 진로 게시판</h3>
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
                <c:out value="${item.title}"/>
              </a>
              <span>(댓글 ${item.comments})</span>
            </li>
          </c:if>
        </c:forEach>
      </ul>
    </c:otherwise>
  </c:choose>
  <a href="<c:url value='/careerboard'/>" class="btn">진로 게시판 가기</a>
</section>

<hr/>

<!-- 인기 자유 게시판 -->
<section>
	  <h3>인기 자유 게시판</h3>
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
	                <c:out value="${item.title}"/>
	              </a>
	              <span>(댓글 ${item.comments})</span>
	            </li>
	          </c:if>
	        </c:forEach>
	      </ul>
	    </c:otherwise>
	  </c:choose>
	  <a href="<c:url value='/FreeBoard'/>" class="btn">자유 게시판 가기</a>
	</section>
			

	    
	    
	    
    </div>
<c:import url="/footer"/>
</body>
</html>
