<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<jsp:include page="../../resources/reset/header.jsp" />   
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="resources/static/common.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class= "main-container">

	<form action="MyBoard">
		<input type="submit" value="뒤로 가기">
	</form>

	<form action="UpdateBoard" method="post">
	    <input type="hidden" name="type" value="${type}" />
	    
	    <c:if test="${param.type eq 'career'}">
	        <input type="hidden" name="comment_id" value="${post.comment_id}" />
	        <textarea name="content">${post.content}</textarea><br>
	    </c:if>
	
	    <c:if test="${param.type eq 'free'}">
	        <input type="hidden" name="cmt_idx" value="${post.cmt_idx}" />
	        <textarea name="cmt_content">${post.cmt_content}</textarea><br>
	    </c:if>
	
	    <input type="submit" value="수정">
	</form>

<jsp:include page="../../resources/reset/footer.jsp" />	
</body>
</html>l>