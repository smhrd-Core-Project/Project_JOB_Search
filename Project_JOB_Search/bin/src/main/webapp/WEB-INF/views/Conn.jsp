<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!--  스프링에서 입력받기  -->
	<div name=input_data"">
		<form action="ConnV" method="post">
			숫자1 <input type="text" name="in_num1">
			숫자2 <input type="text" name="in_num2">
			<input type="submit" value="제출">
		</form>
	</div>

</body>
</html>