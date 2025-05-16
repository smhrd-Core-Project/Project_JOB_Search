<%@ page language="java" contentType="text/html; charset=UTF-8"pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link rel="stylesheet" href="resources/assets/css/main.css" />
		<!-- jQuery library -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
		
		<!-- Latest compiled JavaScript -->
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<style>

</style>
<body style ="text-align: center;">
	<nav id="select">
		<h2>진로 게시판</h2>
		<form class="form-inline">
		<div class ="dropdown">
		<table border="1" style="margin: auto;">
			<tr>
				<td>번호</td>
				<td>제목</td>
				<td>작성자</td>	
				<td>작성 시간</td>								
			</tr>
			<c:forEach items="${list}" var="mvo">
				<tr>
					<td><a href="#">${mvo.}</a></td>
					<td><a href="#">${mvo.email}</a></td>
					<td><a href="#">${mvo.email}</a></td>
					<td><a href="#">${mvo.email}</a></td>
				</tr>
			</c:forEach>
		</table>
		</div>
		
		</form>
	
	</nav>

</body>
</html>