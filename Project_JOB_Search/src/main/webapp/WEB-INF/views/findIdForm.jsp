<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>틴넥트 | 아이디 찾기</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="d-flex justify-content-center align-items-center vh-100 bg-light">
    <div class="card p-4 shadow" style="width: 350px;">
        <h4 class="text-center mb-3">아이디 찾기</h4>

        <form action="findId" method="post">
            <div class="mb-3">
                <label for="name" class="form-label">이름</label>
                <input type="text" name="name" id="name" class="form-control" required placeholder="이름 입력">
            </div>

            <div class="mb-3">
                <label for="email" class="form-label">이메일</label>
                <input type="email" name="email" id="email" class="form-control" required placeholder="이메일 입력">
            </div>
            
            <div class="mb-3">
            	<label class="form-label">휴대전화 번호</label>
            	<input type="text" class="form-control" name="phone_number"
                   pattern="[0-9]{10,11}" maxlength="11" inputmode="numeric"
                   placeholder="숫자만 입력 (예: 01012345678)" required>
        	</div>

            <div class="d-grid">
                <button type="submit" class="btn btn-primary">아이디 찾기</button>
            </div>
        </form>

        <c:if test="${not empty foundId}">
            <div class="alert alert-success mt-3 text-center">
                찾은 아이디: <strong>${foundId}</strong>
            </div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="alert alert-danger mt-3 text-center">
                ${error}
            </div>
        </c:if>

        <div class="mt-4 text-center">
            <a href="<c:url value='/Login'/>" class="btn btn-link">← 로그인으로 돌아가기</a>
        </div>
    </div>
</body>
</html>
