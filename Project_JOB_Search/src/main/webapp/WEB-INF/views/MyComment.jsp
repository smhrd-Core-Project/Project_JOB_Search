<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="resources/static/common.css">
<meta charset="UTF-8">
<title>나의 댓글</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
body {
		background: linear-gradient(to bottom right, #ecfae0, #fff);
	}
</style>
</head>
<body>
<div class="main-container">
    <h3>진로 게시판 내 댓글</h3>
    <ul class="comment-list">
        <c:forEach var="cmt" items="${careerComments}">
            <li class="comment-item">
                <span>${cmt.id}</span> 
                <span>${cmt.content}</span>
                  <form action="deleteComment" method="post" style="display:inline;">
			            <input type="hidden" name="comment_id" value="${cmt.comment_id}" >
			            <input type="hidden" name="type" value="career" >
			            <button type="submit" onclick="return confirm('정말 삭제하시겠습니까?')">삭제</button>
			      </form>
			        <form action="UpdateComment" method="get" style="display:inline;">
		                <input type="hidden" name="comment_id" value="${cmt.comment_id}" >
		                <input type="hidden" name="type" value="career" >
		                <button type="submit">수정하기</button>
		            </form>
            </li>
        </c:forEach>
        <c:if test="${empty careerComments}">
            <li>진로 게시판에 작성한 댓글이 없습니다.</li>
        </c:if>
    </ul>

	<br><hr><br>

    <h3>자유 게시판 내 댓글</h3>
    <ul class="comment-list">
        <c:forEach var="cmt" items="${freeComments}">
            <li class="comment-item">
                <span>${cmt.id}</span> 
                <span>${cmt.cmt_content}</span>
                <form action="deleteComment" method="post" style="display:inline;">
		            <input type="hidden" name="cmt_idx" value="${cmt.cmt_idx}" />
		            <input type="hidden" name="type" value="free" />
		            <button type="submit" onclick="return confirm('정말 삭제하시겠습니까?')">삭제</button>
		        </form>
		        <form action="UpdateComment" method="get" style="display:inline;">
		        	<input type="hidden" name="cmt_idx" value="${cmt.cmt_idx}" >
		        	<input type="hidden" name="type" value="free" >
		            <button type="submit">수정하기</button>
		       </form>
		        
            </li>
        </c:forEach>
        <c:if test="${empty freeComments}">
            <li>자유 게시판에 작성한 댓글이 없습니다.</li>
        </c:if>
    </ul>
</div>

</body>
</html>