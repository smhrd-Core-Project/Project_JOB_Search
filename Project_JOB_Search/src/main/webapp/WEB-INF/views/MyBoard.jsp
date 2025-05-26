 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- HEADER 입력 -->
<jsp:include page="../../resources/reset/header.jsp" />

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="resources/common.css">
<meta charset="UTF-8">
<title>내 게시글</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
body {
    background: linear-gradient(to bottom right, #ecfae0, #fff);
    margin: 0;
    padding: 0;
}

.main-container {
    margin: 0 auto 0 auto;
    padding: 28px 16px;
    background: #fff;
    box-shadow: 0 4px 18px rgba(0,0,0,0.08);
    min-height: 30vh;
    font-family: 'GmarketSansMedium', '맑은 고딕', sans-serif;
    box-sizing: border-box;
}


}


</style>


</head>
<body>
<div class="main-container">
    <h3>진로 게시판 내 게시글</h3>
    <ul class>
        <c:forEach var="cmt" items="${careerBoard}">
            <li class="board-item">
                <span>${cmt.id}</span> 
                <span>${cmt.title}</span>
                  <form action="deleteBoard" method="post" style="display:inline;">
			            <input type="hidden" name="board_career_id" value="${cmt.board_career_id}" >
			            <input type="hidden" name="type" value="career" >
			            <button type="submit" onclick="return confirm('정말 삭제하시겠습니까?')">삭제</button>
			      </form>
			        <form action="UpdateBoard" method="get" style="display:inline;">
		                <input type="hidden" name="board_career_id" value="${cmt.board_career_id}" >
		                <input type="hidden" name="type" value="career" >
		                <button type="submit">수정하기</button>
		            </form>
            </li>
        </c:forEach>
        <c:if test="${empty careerBoard}">
            <li>진로 게시판에 작성한 게시글이 없습니다.</li>
        </c:if>
    </ul>
    
	<br><hr><br>
	
    <h3>자유 게시판 내 게시글</h3>
    <ul class>
    <c:if test="${not empty freeBoard}">
        <c:forEach var="cmt" items="${freeBoard}">
            <li class="board-item">
                <span>${cmt.id}</span> 
                <span>${cmt.title}</span>
                <form action="deleteBoard" method="post" style="display:inline;">
		            <input type="hidden" name="post_idx" value="${cmt.post_idx}" />
		            <input type="hidden" name="type" value="free" />
		            <button type="submit" onclick="return confirm('정말 삭제하시겠습니까?')">삭제</button>
		        </form>
		        <form action="UpdateBoard" method="get" style="display:inline;">
		        	<input type="hidden" name="post_idx" value="${cmt.post_idx}" >
		        	<input type="hidden" name="type" value="free" >
		            <button type="submit">수정하기</button>
		       </form>
		        
            </li>
        </c:forEach>
         </c:if>
        <c:if test="${empty freeBoard}">
            <li>자유 게시판에 작성한 게시글이 없습니다.</li>
        </c:if>
    </ul>
</div>
<!-- FOOTER 입력 -->
<jsp:include page="../../resources/reset/footer.jsp" />
</body>
</html>