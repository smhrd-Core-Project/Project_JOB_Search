<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta charset="UTF-8">
<title>진로게시판</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/common.css" />
</head>

<body style ="text-align: left;">
	
		<h2>진로 게시판</h2>
		<div class ="dropdown">
		
		<table border="1" style="margin: auto;">
			<tr>
				<th>번호</th>
				<th>제목</th>
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
			<a href="${pageContext.request.contextPath}/write">글쓰기</a>
		</div>
	

</body>
</html>