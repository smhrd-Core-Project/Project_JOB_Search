<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="../../resources/reset/header.jsp" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원정보 수정</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/common.css">
	<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
	
<style>
body {
	font-family: 'Segoe UI', '맑은 고딕', sans-serif;
	background-color: #ffffff;
	margin: 0;
	padding: 0;
	text-align: center;
}

.main-container {
	max-width: 500px;
	margin: 0 auto;
	padding: 0 20px;
}	
.btn-wide-green {
	display: inline-block;
	background-color: #00c853;
	color: white;
	border: none;
	border-radius: 40px;
	padding: 14px 0;
	width: 100%;
	font-size: 16px;
	font-weight: bold;
	text-decoration: none;
}
</style>
</head>

<body>
    <div class="main-container">
        <div class="update-form-title">회원정보수정</div>
        <form action="Update2" method="post">
            <span class="update-form-label">접속한 ID</span>
            <c:out value="${sessionScope.loginUser.name}" /><br>
            <input type="hidden" name="id" value="<c:out value="${sessionScope.loginUser.id}" />"><br>
            <span class="update-form-label">이메일 변경</span>
            <input type="text" name="email" class="update-form-input" placeholder="변경할 이메일 주소를 입력하세요"><br>
            <span class="update-form-label">학교 변경</span>
            <input type="text" name="school" class="update-form-input" placeholder="변경할 학교 이름을 입력하세요"><br>
            <input type="submit" value="정보 수정" class="btn-wide-green">
        </form>
    </div>
    <jsp:include page="../../resources/reset/footer.jsp" />
</body>
</html>
