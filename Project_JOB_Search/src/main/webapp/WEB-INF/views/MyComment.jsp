<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 댓글</title>

</head>
<body>
<div class="main-container">
    <h3>진로 게시판 내 댓글</h3>
    <ul class="comment-list">
        <c:forEach var="cmt" items="${careerComments}">
            <li class="comment-item">
                <span>${cmt.id}</span> 
                <span>${cmt.cmt_content}</span>
                <span class="comment-actions">
                    <button onclick="deleteComment(${cmt.cmt_idx})">삭제</button>
                    <button onclick="editComment(${cmt.cmt_idx})">수정</button>
                </span>
            </li>
        </c:forEach>
        <c:if test="${empty careerComments}">
            <li>진로 게시판에 작성한 댓글이 없습니다.</li>
        </c:if>
    </ul>

    <h3>자유 게시판 내 댓글</h3>
    <ul class="comment-list">
        <c:forEach var="cmt" items="${freeComments}">
            <li class="comment-item">
                <span>${cmt.id}</span> 
                <span>${cmt.cmt_content}</span>
                <span class="comment-actions">
                    <button onclick="deleteComment(${cmt.cmt_idx})">삭제</button>
                    <button onclick="editComment(${cmt.cmt_idx})">수정</button>
                </span>
            </li>
        </c:forEach>
        <c:if test="${empty freeComments}">
            <li>자유 게시판에 작성한 댓글이 없습니다.</li>
        </c:if>
    </ul>
</div>

</body>
</html>