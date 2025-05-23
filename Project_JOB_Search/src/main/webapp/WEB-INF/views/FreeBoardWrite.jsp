<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:include page="../../resources/reset/header.jsp" />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="resources/common.css">
<link rel="stylesheet" href="resources/FreeBoard.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class= "main-container">

<h2>자유 게시판</h2>
	<div class="title-category">
		<form action="InsertBoard" method="post">
			<input type="hidden" name="id" value="${loginUser.id}">

			<!-- 제목 -->
			<div class="write-category">
				<label for="title"></label>
				<input type="text" name="title" id="title" class="write-title" placeholder="제목을 입력하세요.">
			</div>

			<!-- 내용 -->
			<div class="contenttext-write">
				<textarea name="content" class="career-content-write" rows="15" placeholder="내용을 입력하세요."></textarea>
			</div>

			<!-- 등록 버튼 -->
			<div class="submit-write">
				
				<button type="button" class="button-fit" onclick="history.back()">뒤로가기</button>
				<input type="submit" class="button-fit" value="저장">
			</div>
		</form>
	</div>
</div>
<jsp:include page="../../resources/reset/footer.jsp" />
</body>
</html>