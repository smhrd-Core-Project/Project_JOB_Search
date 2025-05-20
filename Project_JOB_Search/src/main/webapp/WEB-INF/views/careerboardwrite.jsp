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
			제목: <input type="text" name="title" required /><br><br>
    
		    내용: <textarea name="content" rows="5" cols="60" required></textarea><br><br>
		    
		    진로 주제: <input type="text" name="careerTopic" required /><br><br>
		    
		    관련 전공: <input type="text" name="relatedMajor" required /><br><br>
		
		    <!-- ✅ select 방식 질문 유형 -->
		    질문 유형:
		    <select name="questionType" required>
		        <option value="" disabled selected>유형 선택</option>
		        <option value="Atype">공모전</option>
		        <option value="Btype">자격증</option>
		        <option value="Ctype">직업</option>
		    </select>
		    <br><br>
					
				<input type="submit" value="저장" class="button fit">
				<input type="button" value="뒤로가기" class="button fit" onclick="history.back()">
					
				</form>
				</nav>
</body>
</html>