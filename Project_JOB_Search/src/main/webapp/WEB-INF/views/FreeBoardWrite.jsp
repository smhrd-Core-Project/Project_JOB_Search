<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:include page="../../resources/reset/header.jsp" />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="resources/common.css">
<link rel="stylesheet" href="resources/FreeBoard.css">
<meta charset="UTF-8">
<title>자유게시판 작성</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
@font-face {
		    font-family: 'GmarketSansMedium';
		    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
		    font-weight: normal;
		    font-style: normal;
		}
		
body {
    background: linear-gradient(to bottom right, #ecfae0, #fff);
    margin: 0;
    padding: 0;
}

h2 {
	font-family: 'GmarketSansMedium';
}

.main-container {
    margin: 0 auto 0 auto;
    padding: 28px 16px;
    background: #fff;
    box-shadow: 0 4px 18px rgba(0,0,0,0.08);
    min-height: 40vh;
    font-family: '맑은 고딕', sans-serif;
    box-sizing: border-box;
}
</style>
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