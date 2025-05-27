<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<jsp:include page="../../resources/reset/header.jsp" />   
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="resources/common.css">
<link rel="stylesheet" href="resources/FreeBoard.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class= "main-container">


	<form action="UpdateBoard" method="post">
	    <input type="hidden" name="type" value="${type}" />
	    
	    <c:if test="${type == 'career'}">
	        <input type="hidden" name="board_career_id" value="${board.board_career_id}" />
	        <div class="write-category">
		        <input type="text" name="title" class="write-title" value="${board.title}" /><br>
		    </div>
		    <div class="contenttext-write">
		        <textarea name="content" class="career-content-write">${board.content}</textarea><br>
		    </div>
	    </c:if>
	
	    <c:if test="${type == 'free'}">
	    
	        <input type="hidden" name="post_idx" value="${board.post_idx}" />
	    
	    <div class="write-category">
	        <input type="text" name="title"  class="write-title" value="${board.title}" /><br>
	    </div>
	    <div class="contenttext-write">
	        <textarea name="content" class="career-content-write">${board.content}</textarea><br>
	    </div>
	    </c:if>
	
		
	    	<input type="submit" value="수정" class="button-fit">
	   
	</form>

<jsp:include page="../../resources/reset/footer.jsp" />	
</body>
</html>