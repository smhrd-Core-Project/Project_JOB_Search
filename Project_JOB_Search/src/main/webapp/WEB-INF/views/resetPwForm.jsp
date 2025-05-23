<%-- resetPasswordForm.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>틴넥트 | 비밀번호 재설정</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="d-flex justify-content-center align-items-center vh-100 bg-light">
    <div class="card p-4 shadow" style="width: 350px;">
        <h4 class="text-center mb-3">비밀번호 재설정</h4>

        <!-- 오류 메시지 표시 -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger text-center" role="alert">
                ${error}
            </div>
        </c:if>

        <form action="resetPassword" method="post">
            <div class="mb-3">
                <label for="id" class="form-label">ID</label>
                <input type="text" name="id" id="id" class="form-control" required placeholder="ID 입력">
            </div>
            <div class="mb-3">
                <label for="name" class="form-label">이름</label>
                <input type="text" name="name" id="name" class="form-control" required placeholder="이름 입력">
            </div>
            <div class="mb-3">
                <label for="email" class="form-label">이메일</label>
                <input type="email" name="email" id="email" class="form-control" required placeholder="이메일 입력">
            </div>
            <div class="mb-3">
                <label for="phone_number" class="form-label">휴대전화 번호</label>
                <input type="text" class="form-control" name="phone_number"
                       pattern="[0-9]{10,11}" maxlength="11" inputmode="numeric"
                       placeholder="숫자만 입력 (예: 01012345678)" required>
            </div>

            <div class="d-grid">
                <button type="submit" class="btn btn-primary">비밀번호 수정</button>
            </div>
        </form>

        <div class="mt-4 text-center">
            <a href="<c:url value='/Login'/>" class="btn btn-link">← 로그인으로 돌아가기</a>
        </div>
    </div>
</body>
</html>
