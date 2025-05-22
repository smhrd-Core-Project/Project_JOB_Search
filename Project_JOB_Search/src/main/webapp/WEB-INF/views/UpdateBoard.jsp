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
	    
	    <c:if test="${type == 'career'}">
	        <input type="hidden" name="board_career_id" value="${board.board_career_id}" />
	        <input type="text" name="title" value="${board.title}" /><br>
	        <textarea name="content">${board.content}</textarea><br>
	    </c:if>
	
	    <c:if test="${type == 'free'}">
	        <input type="hidden" name="post_idx" value="${board.post_idx}" />
	        <input type="text" name="title" value="${board.title}" /><br>
	        <textarea name="content">${board.content}</textarea><br>
	    </c:if>
	
	    <input type="submit" value="수정">
	</form>
<<<<<<< HEAD
		
=======

<jsp:include page="../../resources/reset/footer.jsp" />	
>>>>>>> branch 'Develop1.0' of https://github.com/smhrd-Core-Project/Project_JOB_Search.git
</body>
</html>l>