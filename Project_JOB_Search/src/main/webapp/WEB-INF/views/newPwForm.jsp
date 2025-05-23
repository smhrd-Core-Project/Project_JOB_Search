<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>틴넥트 | 새 비밀번호 설정</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="d-flex justify-content-center align-items-center vh-100 bg-light">
    <div class="card p-4 shadow" style="width: 350px;">
        <h4 class="text-center mb-3">새 비밀번호 설정</h4>

        <form action="updatePassword" method="post">
            <input type="hidden" name="id" value="${verifiedUserId}">

            <div class="mb-3">
                <label for="newPassword" class="form-label">새 비밀번호</label>
                <input type="password" id="newPassword" name="password" class="form-control" required placeholder="새 비밀번호 입력">
            </div>
            <div class="mb-3">
                <label for="confirmPassword" class="form-label">비밀번호 확인</label>
                <input type="password" id="confirmPassword" class="form-control" required placeholder="비밀번호 재입력">
                <div class="form-text text-danger" id="mismatchMsg" style="display: none;">비밀번호가 일치하지 않습니다.</div>
            </div>

            <div class="d-grid">
                <button type="submit" class="btn btn-primary">비밀번호 변경</button>
            </div>
        </form>
    </div>

    <script>
        const pw = document.getElementById("newPassword");
        const confirmPw = document.getElementById("confirmPassword");
        const msg = document.getElementById("mismatchMsg");

        function validate() {
            if (pw.value !== confirmPw.value) {
                msg.style.display = "block";
            } else {
                msg.style.display = "none";
            }
        }

        pw.addEventListener("input", validate);
        confirmPw.addEventListener("input", validate);
    </script>
</body>
</html>
