<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>틴넥트 | 로그인</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body class="d-flex justify-content-center align-items-center vh-100 bg-light">
    <div class="card p-4 shadow" style="width: 350px;">
        <h3 class="text-center mb-4">로그인</h3>
        <form id="loginForm">
            <div class="mb-3">
                <label for="id" class="form-label">ID</label>
                <input type="text" class="form-control" id="id" name="id" required >
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">비밀번호</label>
                <input type="password" class="form-control" id="password" name="pw" required>
            </div>
            <div class="d-grid">
                <button type="submit" class="btn btn-primary">로그인</button>
            </div>
        </form>
        <div class="mt-3 text-center">
            <a href="<c:url value='/Signup'/>">회원가입</a>
        </div>
    </div>

    <script>
    $(document).ready(function () {
        $('#loginForm').on('submit', function (e) {
            e.preventDefault();

            $.ajax({
                url: '${pageContext.request.contextPath}/login',
                method: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({
                    id: $('#id').val(),
                    password: $('#password').val()
                }),
                dataType: 'json',
                success: function (response) {
                    if (response.success) {
                        window.location.href = '${pageContext.request.contextPath}/loginSuccess';
                    } else {
                        alert(response.message);
                    }
                },
                error: function () {
                    alert("서버 오류가 발생했습니다.");
                }
            });

        });
    });
    </script>
</body>
</html>