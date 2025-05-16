<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .signup-container {
            max-width: 600px;
            margin: 50px auto;
            padding: 30px;
            background: white;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0,0,0,0.1);
        }
        .form-label {
            font-weight: bold;
        }
    </style>
</head>
<body>

<div class="container signup-container">
    <h2 class="mb-4 text-center">회원가입</h2>
    <form action="/register" method="post" id="signupForm">
        <div class="mb-3">
            <label for="signupEmail" class="form-label">이메일</label>
            <input type="email" class="form-control" name="userId" id="signupEmail" placeholder="이메일을 입력하세요" required>
        </div>

        <div class="mb-3">
            <label for="signupPassword" class="form-label">비밀번호</label>
            <input type="password" class="form-control" name="password" id="signupPassword" placeholder="비밀번호를 입력하세요" required>
        </div>

        <div class="mb-3">
            <label for="signupPasswordCheck" class="form-label">비밀번호 확인</label>
            <input type="password" class="form-control" id="signupPasswordCheck" placeholder="비밀번호를 다시 입력하세요" required>
        </div>

        <div class="mb-3">
            <label for="signupName" class="form-label">이름</label>
            <input type="text" class="form-control" name="userName" id="signupName" placeholder="이름을 입력하세요" required>
        </div>

        <div class="mb-3">
            <label for="signupTel" class="form-label">연락처</label>
            <input type="tel" class="form-control" name="userTel" id="signupTel" placeholder="-를 제외하고 입력해주세요" required>
        </div>

        <div class="mb-3">
            <label class="form-label">성별</label><br>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="gender" id="genderMale" value="M" required>
                <label class="form-check-label" for="genderMale">남자</label>
            </div>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="gender" id="genderFemale" value="F">
                <label class="form-check-label" for="genderFemale">여자</label>
            </div>
        </div>

        <div class="mb-3">
            <label for="signupBirthdate" class="form-label">생년월일</label>
            <input type="date" class="form-control" name="birthDate" id="signupBirthdate" required>
        </div>

        <div class="form-check mb-4">
            <input class="form-check-input" type="checkbox" id="termsCheck" disabled>
            <label class="form-check-label" for="termsCheck">
                <a href="#" data-bs-toggle="modal" data-bs-target="#termsModal">이용약관</a>에 동의합니다
            </label>
        </div>

        <button type="submit" class="btn btn-primary w-100">회원가입</button>
    </form>
</div>

<!-- 약관 모달 -->
<div class="modal fade" id="termsModal" tabindex="-1" aria-labelledby="termsModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">이용약관</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
            </div>
            <div class="modal-body" id="termsContent" style="height: 400px; overflow-y: auto;">
                <%@ include file="userSignupTerms.jsp" %>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>

<!-- 스크립트 추가 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
document.addEventListener('DOMContentLoaded', function () {
    const termsContent = document.getElementById('termsContent');
    const termsCheckbox = document.getElementById('termsCheck');
    const form = document.getElementById('signupForm');

    termsContent.addEventListener('scroll', function () {
        const isBottom = termsContent.scrollTop + termsContent.clientHeight >= termsContent.scrollHeight - 10;
        if (isBottom) {
            termsCheckbox.disabled = false;
        }
    });

    form.addEventListener('submit', function (e) {
        if (!termsCheckbox.checked) {
            e.preventDefault();
            alert('이용약관을 끝까지 읽고 동의해 주세요.');
        }
    });
});
</script>

</body>
</html>
