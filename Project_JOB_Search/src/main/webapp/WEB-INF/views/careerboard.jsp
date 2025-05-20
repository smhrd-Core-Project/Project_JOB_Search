<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta charset="UTF-8">
<title>진로게시판</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/common.css" />
</head>

<body>
	<div id="career_board">
		<div class="BoarderHeader">
		<h2>진로 게시판</h2>
		</div>
		<div class ="article-board">
		
		<table class="article-table">
			
			<tr>
				<th colspan="2" class="title">제목</th>
				<th>좋아요</th>	
				<th>댓글</th>
												
			</tr>
			
			<c:forEach items="${list}" var="mvo">
				<tr>
					<td>${mvo.boardCareerId}</td>
					<td><a href="${pageContext.request.contextPath}/detail?boardCareerId=${mvo.boardCareerId}">${mvo.title}</a></td>
					<td>${mvo.likes}</td>
					<td>${mvo.comments}</td>		
				</tr>
			</c:forEach>
		</table>
			<input type="button" value="글쓰기" onclick="location.href='${pageContext.request.contextPath}/write'" />
		</div>
	
	</div>
</body>
</html>