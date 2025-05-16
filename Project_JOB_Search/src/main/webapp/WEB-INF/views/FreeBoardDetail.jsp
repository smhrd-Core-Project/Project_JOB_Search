<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="resources/static/common.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<div class = "main-container" >
	
	<div>
	    <h2>${post.title}</h2>
	    <p>${post.id}</p>
	    <p>${post.content}</p>
	</div>
	<hr>
	
	<div>
	    <h3>댓글</h3>
	    <c:forEach var="cmt" items="${comments}">
	        <div>
	            <b>${cmt.writer}</b> - ${cmt.regdate}<br>
	            ${cmt.cmt_content}
	        </div>
	        <hr>
	    </c:forEach>    
	</div>
	
	<div>
	    <form action="InsertComment" method="post">
	        <input type="hidden" name="post_idx" value="${post.post_idx}">
	        <textarea name="cmt_content" rows="3" cols="50"></textarea><br>
	        <input type="submit" value="댓글 등록">
	    </form>
	</div>

</body>
</html>