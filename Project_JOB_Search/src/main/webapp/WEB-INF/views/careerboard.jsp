<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<jsp:include page="../../resources/reset/header.jsp" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta charset="UTF-8">
<title>진로게시판</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/common.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/careerboard.css" />

</head>

<body>
<div class="main-container">
	<div id="career_board">
		<div class="BoarderHeader">
		<h2>진로게시판</h2>
		</div>
		<div class ="article-board">
			<div class="search-title">
			<form action="${pageContext.request.contextPath}/careerboard" method="get" >
			    <input type="text" name="keyword" class="search-keyword" placeholder="검색어를 입력하세요" value="${param.keyword}" >
			    <button type="submit" class="search-btn" cursor:pointer;">
      			  <img src="${pageContext.request.contextPath}/resources/img/검색.png" alt="검색" style="width:22px; height:22px; vertical-align:middle;">
   				 </button>
			</form>
			</div>
		<table class="article-table">
			
			<tr class="table-top">
				
				<th colspan="2" class="title">제목</th>
				<th class="likes">좋아요</th>	
				<th class="comments">댓글</th>
												
			</tr>
			
			<c:forEach items="${list}" var="mvo">
				<tr class="board-list">
					<td class="board-list-num">${mvo.boardCareerId}</td>
					<td class="board-list-title"><a href="${pageContext.request.contextPath}/CareerBoardDetail?boardCareerId=${mvo.boardCareerId}">${mvo.title}</a></td>
					<td class="board-list-likes">${mvo.likes}</td>
					<td class="board-list-comments">${mvo.comments}</td>		
				</tr>
			</c:forEach>
		</table>
		<div class="BoardBottonOption">
		<div class="option-area">
			<div class="left-area"></div>
			<div class="right-area">
				<a href="${pageContext.request.contextPath}/write" class="btn_write">✏️글쓰기</a>
			</div>
		</div>
		</div>
		</div>
	
	</div>
	<div class="page">
    <c:forEach var="i" begin="1" end="${totalPage}">
        <a href="${pageContext.request.contextPath}/careerboard?page=${i}${not empty param.keyword ? '&keyword=' : ''}${param.keyword}"
           class="page-btn${i == page ? ' active' : ''}">
            ${i}
        </a>
    </c:forEach>
</div>
		</div>	
<jsp:include page="../../resources/reset/footer.jsp" />
</body>
</html>