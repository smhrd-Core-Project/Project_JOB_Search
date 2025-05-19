<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="resources/static/common.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class= "main-container">

	<form action="FreeBoard">
		<input type="submit" value="뒤로 가기">
	</form>

	<form action ="InsertBoard" method="post">
		<input type="hidden" name="id" value="${loginUser.id}">
		제목:<input type="text" name="title"><br>
		내용:<textarea name="content"></textarea><br>
		제목:<input type="submit" value="등록"><br>
			
</div>
</body>
</html>