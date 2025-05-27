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


	<form action="UpdateComment" method="post">
	    <input type="hidden" name="type" value="${type}" />
	    
	    <c:if test="${param.type eq 'career'}">
	    	<div class="write-category">
	        	<input type="hidden" name="comment_id" class="write-title" value="${comment.comment_id}" />
	        </div>
	        <div class="contenttext-write">
	        	<textarea name="content" class="career-content-write" rows="8">${comment.content}</textarea><br>
	        </div>
	    </c:if>
	
	    <c:if test="${param.type eq 'free'}">
	    	<div class="write-category">
	        	<input type="hidden" name="cmt_idx" class="write-title" value="${comment.cmt_idx}" />
	        </div>
	        <div class="contenttext-write">
	        	<textarea name="cmt_content" class="career-content-write" rows="8">${comment.cmt_content}</textarea><br>
	        </div>
	    </c:if>

	    <input type="submit" value="수정" class="button-fit">
	
	</form>
	
	
	
<jsp:include page="../../resources/reset/footer.jsp" />
</body>
</html>