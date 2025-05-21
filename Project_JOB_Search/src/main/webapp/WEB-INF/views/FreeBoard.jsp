<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<style>
    tr:hover td {
    color: #0000ff;
	}
</style>

<head>
<link rel="stylesheet" href="resources/static/common.css">
<meta charset="UTF-8">
<title>자유게시판</title>
</head>
<body>

<div class="main-container">
 	<h2>자유게시판</h2>
 	<div>
 		 	<table border="1">
 		<tr>
 			<td>번호</td>
 			<td>제목</td>
 			<td>좋아요</td>
 			<td>댓글</td>
 		</tr>
 		
 		
	 	<c:forEach var="post" items="${list}" varStatus="status">
	    <tr onclick="location.href='FreeBoardDetail?post_idx=${post.post_idx}'" style="cursor:pointer;">
	        <td>${status.index + 1}</td> 
	        <td>${post.title}</td>
	        <td>${post.likes}</td>
	        <td>${post.comments}</td>
	    </tr>
		</c:forEach>
 		
 	</table>
 	
 	</div>

 	
 	<div>
 		<a href = "FreeBoardWrite"><button>글쓰기</button></a>
	</div>
</div>

 	
</body>
</html>