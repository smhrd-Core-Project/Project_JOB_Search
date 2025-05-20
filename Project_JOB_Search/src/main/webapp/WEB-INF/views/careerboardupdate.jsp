<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/common.css" />
</head>
<body>
<h2>게시글 수정</h2>
<form action="${pageContext.request.contextPath}/update" method="post">
    <input type="hidden" name="boardCareerId" value="${board.boardCareerId}" />

    제목: <input type="text" name="title" value="${board.title}" required /><br>
    내용: <textarea name="content" >${board.content}</textarea><br>
    진로주제: <input type="text" name="careerTopic" value="${board.careerTopic}" /><br>
    관련전공: <input type="text" name="relatedMajor" value="${board.relatedMajor}" /><br>
    질문유형: <select name="questionType" required>
			    <option value="" disabled>유형 선택</option>
			    <option value="Atype" <c:if test="${board.questionType == 'Atype'}"></c:if>공모전</option>
			    <option value="Btype" <c:if test="${board.questionType == 'Btype'}"></c:if>자격증</option>
			    <option value="Ctype" <c:if test="${board.questionType == 'Ctype'}"></c:if>직업</option>
			</select><br>

    <input type="submit" value="수정 완료" />
    <input type="button" value="뒤로가기" class="button fit" onclick="history.back()">
</form>
</body>
</html>