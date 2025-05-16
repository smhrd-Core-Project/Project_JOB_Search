<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<link rel="stylesheet"
	href="<c:url value='/resources/static/common.css' />">
</head>
<body>

	<div class="container main-container">
		<h2 class="mb-4 text-center">회원가입</h2>
		<form action="join" method="post" id="signupForm">

			<div class="mb-3">
				<label for="signupId" class="form-label">아이디</label> <input
					type="text" class="form-control" name="id" id="signupId"
					placeholder="아이디를 입력하세요" required>
			</div>

			<div class="mb-3">
				<label for="signupEmail" class="form-label">이메일</label> <input
					type="email" class="form-control" name="email" id="signupEmail"
					placeholder="이메일을 입력하세요" required>
			</div>

			<div class="mb-3">
				<label for="signupPassword" class="form-label">비밀번호</label> <input
					type="password" class="form-control" name="password"
					id="signupPassword" placeholder="비밀번호를 입력하세요" required>
			</div>

			<div class="mb-3">
				<label for="signupPasswordCheck" class="form-label">비밀번호 확인</label>
				<input type="password" class="form-control" id="signupPasswordCheck"
					placeholder="비밀번호를 다시 입력하세요" required>
				<div class="form-text text-danger" id="passwordMismatchMsg"
					style="display: none;">비밀번호가 일치하지 않습니다.</div>
			</div>

			<div class="mb-3">
				<label for="signupName" class="form-label">이름</label> <input
					type="text" class="form-control" name="name" id="signupName"
					placeholder="이름을 입력하세요" required>
			</div>

			<div class="mb-3">
				<label for="signupTel" class="form-label">연락처</label> <input
					type="tel" class="form-control" name="tel" id="signupTel"
					placeholder="-를 제외하고 입력해주세요" required>
			</div>

			<div class="mb-3">
				<label for="signupSchool" class="form-label">학교</label> <input
					type="text" class="form-control" name="school" id="signupSchool"
					placeholder="학교명을 입력하세요" required>
			</div>

			<div class="mb-3">
				<label class="form-label">성별</label><br>
				<div class="form-check form-check-inline">
					<input class="form-check-input" type="radio" name="gender"
						id="genderMale" value="M" required> <label
						class="form-check-label" for="genderMale">남자</label>
				</div>
				<div class="form-check form-check-inline">
					<input class="form-check-input" type="radio" name="gender"
						id="genderFemale" value="F"> <label
						class="form-check-label" for="genderFemale">여자</label>
				</div>
			</div>

			<div class="mb-3">
				<label for="signupGrade" class="form-label">학년</label> <select
					class="form-select" name="grade" id="signupGrade" required>
					<option value="" disabled selected>학년을 선택하세요</option>
					<option value="1">1학년</option>
					<option value="2">2학년</option>
					<option value="3">3학년</option>
				</select>
			</div>

			<div class="form-check mb-4">
				<input class="form-check-input" type="checkbox" id="termsCheck"
					disabled> <label class="form-check-label" for="termsCheck">
					<a href="#" data-bs-toggle="modal" data-bs-target="#termsModal">이용약관</a>에
					동의합니다
				</label>
			</div>

			<button type="submit" class="btn btn-primary w-100">회원가입</button>
		</form>
	</div>

	<!-- 약관 모달 -->
	<div class="modal fade" id="termsModal" tabindex="-1"
		aria-labelledby="termsModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">이용약관</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="닫기"></button>
				</div>
				<div class="modal-body" id="termsContent"
					style="height: 400px; overflow-y: auto;">
					<%@ include file="userSignupTerms.jsp"%>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 스크립트 -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script>
		document
				.addEventListener(
						'DOMContentLoaded',
						function() {
							const termsContent = document
									.getElementById('termsContent');
							const termsCheckbox = document
									.getElementById('termsCheck');
							const form = document.getElementById('signupForm');
							const pw = document
									.getElementById('signupPassword');
							const pwCheck = document
									.getElementById('signupPasswordCheck');
							const pwMsg = document
									.getElementById('passwordMismatchMsg');

							function validatePasswords() {
								if (pw.value !== pwCheck.value) {
									pwMsg.style.display = 'block';
									return false;
								} else {
									pwMsg.style.display = 'none';
									return true;
								}
							}

							pw.addEventListener('input', validatePasswords);
							pwCheck
									.addEventListener('input',
											validatePasswords);

							termsContent
									.addEventListener(
											'scroll',
											function() {
												const isBottom = termsContent.scrollTop
														+ termsContent.clientHeight >= termsContent.scrollHeight - 10;
												if (isBottom) {
													termsCheckbox.disabled = false;
												}
											});

							form.addEventListener('submit', function(e) {
								let valid = true;

								if (!termsCheckbox.checked) {
									alert('이용약관을 끝까지 읽고 동의해 주세요.');
									valid = false;
								}

								if (!validatePasswords()) {
									alert('비밀번호가 일치하지 않습니다.');
									valid = false;
								}

								if (!valid)
									e.preventDefault();
							});
						});
	</script>

</body>
</html>
