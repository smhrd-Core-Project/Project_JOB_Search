<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta charset="UTF-8">
<title>진로게시글작성</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/common.css" />
</head>
	<body>
	<nav id="menu">	
	<form action ="${pageContext.request.contextPath}/write" method="post">
		<ul class="links">
					<li><input type="text" name="title" placeholder="제목"></li>
					<li><textarea name="content" placeholder="내용" rows="5" cols="40"></textarea></li>
					 <li><input type="text" name="careerTopic" placeholder="진로 주제"></li>
                <li><input type="text" name="relatedMajor" placeholder="관련 전공"></li>
                <li><input type="text" name="questionType" placeholder="질문 유형"></li>
					<li><input type="submit" value="저장" class="button fit"></li>
				
				</ul>
				</form>
				</nav>
</body>
</html>