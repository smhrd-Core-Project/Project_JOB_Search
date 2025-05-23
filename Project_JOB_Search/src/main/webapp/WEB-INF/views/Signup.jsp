<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>

<c:set var="cpath" value="${pageContext.request.contextPath}" />
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
    			<label for="signupId" class="form-label">아이디</label> 
    			<input type="text" class="form-control" name="id" id="signupId"
           			value="${naverJoinInfo.id}" placeholder="아이디를 입력하세요" required>
    			<span id="idFeedback" class="form-text"></span> <!-- 추가 -->
			</div>

			<div class="mb-3">
				<label for="signupEmail" class="form-label">이메일</label> 
				<input type="email" class="form-control" name="email" id="signupEmail"
					value="${naverJoinInfo.email}" placeholder="이메일을 입력하세요" required>
				<span id="emailFeedback" class="form-text"></span>
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
					value="${naverJoinInfo.name}" placeholder="이름을 입력하세요" required>
			</div>

			<div class="mb-3">
    			<label for="signupTel" class="form-label">연락처</label>
    			<input type="text" class="form-control" name="phone_number" id="signupTel"
        				placeholder="숫자만 입력해주세요" inputmode="numeric" pattern="[0-9]{10,11}"
        				maxlength="11" required>
			</div>

			<div class="mb-3">
				<label for="signupSchool" class="form-label">학교</label> <input
					type="text" class="form-control" name="school" id="signupSchool"
					placeholder="학교명을 입력하세요" required>
			</div>

			<div class="mb-3">
				<label class="form-label">성별</label><br>
				<div class="form-check form-check-inline">
					<input class="form-check-input" type="radio" name="gender" id="genderMale" value="M"
    					<c:if test="${naverJoinInfo.gender == 'M'}">checked</c:if> >
						<label class="form-check-label" for="genderMale">남자</label>
				</div>
				<div class="form-check form-check-inline">
					<input class="form-check-input" type="radio" name="gender" id="genderFemale" value="F"
   						 <c:if test="${naverJoinInfo.gender == 'F'}">checked</c:if> >
						 <label class="form-check-label" for="genderFemale">여자</label>
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
					style="height: 400px; overflow-y: auto; padding: 20px;">
					<%@ include file="userSignupTerms.jsp"%>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>

	<!-- JS 스크립트 -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js">
	</script>
	
	<script>
	const cpath = '${cpath}';
    let isIdAvailable = false;
    let isEmailAvailable = false;

    document.addEventListener('DOMContentLoaded', function () {
        const termsContent = document.getElementById('termsContent');
        const termsCheckbox = document.getElementById('termsCheck');
        const form = document.getElementById('signupForm');
        const pw = document.getElementById('signupPassword');
        const pwCheck = document.getElementById('signupPasswordCheck');
        const pwMsg = document.getElementById('passwordMismatchMsg');

        // 비밀번호 일치 여부 확인
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
        pwCheck.addEventListener('input', validatePasswords);

        // 약관 스크롤 끝까지 읽었을 때 체크박스 활성화
        termsContent.addEventListener('scroll', function () {
            const isBottom = termsContent.scrollTop + termsContent.clientHeight >= termsContent.scrollHeight - 10;
            if (isBottom) {
                termsCheckbox.disabled = false;
            }
        });
        
        
     	// 숫자 이외 입력 시 자동 제거
        document.getElementById("signupTel").addEventListener("input", function () {
            this.value = this.value.replace(/[^0-9]/g, '');
        });
        
        

        // 아이디 중복 확인 
        $('#signupId').on('blur', function () {
            const id = $(this).val().trim();
            if (!id) return;

            $.ajax({
                url: cpath + '/checkId',
                type: 'GET',
                data: { id: id },
                dataType: 'json',
                success: function (data) {
                    if (data.available) {
                        $('#idFeedback').text('사용 가능한 아이디입니다.').css('color', 'green');
                        isIdAvailable = true;
                    } else {
                        $('#idFeedback').text('중복된 아이디입니다.').css('color', 'red');
                        isIdAvailable = false;
                    }
                },
                error: function () {
                    $('#idFeedback').text('서버 오류 발생').css('color', 'red');
                    isIdAvailable = false;
                }
            });
        });

        // 이메일 중복 확인 (jQuery AJAX)
        $('#signupEmail').on('blur', function () {
            const email = $(this).val().trim();
            if (!email) return;

            $.ajax({
                url: cpath + '/checkEmail',
                type: 'GET',
                data: { email: email },
                dataType: 'json',
                success: function (data) {
                    if (data.available) {
                        $('#emailFeedback').text('사용 가능한 이메일입니다.').css('color', 'green');
                        isEmailAvailable = true;
                    } else {
                        $('#emailFeedback').text('중복된 이메일입니다.').css('color', 'red');
                        isEmailAvailable = false;
                    }
                },
                error: function () {
                    $('#emailFeedback').text('서버 오류 발생').css('color', 'red');
                    isEmailAvailable = false;
                }
            });
        });

        // 최종 submit 검사
        form.addEventListener('submit', function (e) {
            let valid = true;

            if (!isIdAvailable) {
                alert('이미 사용 중인 아이디입니다.');
                valid = false;
            }

            if (!isEmailAvailable) {
                alert('이미 사용 중인 이메일입니다.');
                valid = false;
            }

            if (!validatePasswords()) {
                alert('비밀번호가 일치하지 않습니다.');
                valid = false;
            }

            if (termsCheckbox.disabled || !termsCheckbox.checked) {
                alert('이용약관을 끝까지 읽고 동의해 주세요.');
                valid = false;
            }

            if (!valid) {
                e.preventDefault();
            }
        });
    });
		
	</script>

</body>
</html>
