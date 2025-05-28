<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<jsp:include page="../../resources/reset/header.jsp" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta charset="UTF-8">
<title>진로게시판</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/common.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/careerboard.css" />
<style>
@font-face {
		    font-family: 'GmarketSansMedium';
		    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
		    font-weight: normal;
		    font-style: normal;
		}
		
body {
    background: linear-gradient(to bottom right, #ecfae0, #fff);
    margin: 0;
    padding: 0;
}

h2 {
	font-family: 'GmarketSansMedium';
}

.main-container {
    margin: 0 auto 0 auto;
    padding: 28px 16px;
    background: #fff;
    box-shadow: 0 4px 18px rgba(0,0,0,0.08);
    min-height: 30vh;
    font-family: '맑은 고딕', sans-serif;
    box-sizing: border-box;
}
</style>
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
			    <button type="submit" class="search-btn" style=" cursor:pointer;">
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
					<td class="board-list-title">
						<a href="${pageContext.request.contextPath}/CareerBoardDetail?boardCareerId=${mvo.boardCareerId}">
							<span class="question-type" style="color:#aaa;" >[${mvo.questionType}]</span>
					        <span class="related-major" style="color:#0064ffbd;">[${mvo.relatedMajor}]</span>
					        <span class="board-title">${mvo.title}</span></a></td>
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