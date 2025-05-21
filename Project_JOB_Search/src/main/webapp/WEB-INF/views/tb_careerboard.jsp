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
	<nav id="select">
		<h2>진로 게시판</h2>
		<form>
		<div class ="dropdown">
		<table border="1" style="margin: auto;">
			<tr>
				<td>번호</td>
				<td>제목</td>
				<td>좋아요</td>	
				<td>댓글</td>
												
			</tr>
			<c:forEach items="${list}" var="mvo">
				<tr>
					<td>${mvo.boardCarrerId}</td>
					<td><a href="#">${mvo.title}</a></td>
					<td>${mvo.likes}</td>
					<td>${mvo.comments}</td>
				
				</tr>
			</c:forEach>
		</table>
		</div>
		
		</form>
	
	</nav>

</body>
</html>