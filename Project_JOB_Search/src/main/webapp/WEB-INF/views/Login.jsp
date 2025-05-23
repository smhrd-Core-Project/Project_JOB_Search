<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>틴넥트 | 로그인</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        @font-face {
            font-family: 'Freesentation-9Black';
            src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/2404@1.0/Freesentation-9Black.woff2') format('woff2');
            font-weight: 900;
            font-style: normal;
        }

        body {
            background: linear-gradient(to bottom right, #ecfae0, #fff);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .card {
            background: white;
            padding: 40px 20px !important;
            border-radius: 18px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.10);
            width: 100%;
            max-width: 400px;
            margin: 0 auto;
        }

        h3 {
            font-family: 'Freesentation-9Black';
            font-size: 2rem;
            margin-bottom: 28px;
            font-weight: 900;
        }

        .form-label {
            font-size: 1.1rem;
            font-weight: 700;
        }

        .form-control {
            font-size: 1.1rem;
            height: 50px;
            padding: 0 18px;
            border-radius: 12px;
        }

        .custom-btn-width, .btn {
            width: 80%;
            min-width: 170px;
            font-size: 1.1rem;
            font-weight: 600;
            padding: 12px 0;
            border-radius: 9px;
            margin: 0 auto 13px auto;
            display: block;
        }

        .naver-login-img {
            width: 80%;
            min-width: 170px;
            max-width: 240px;
            display: block;
            margin: 0 auto 20px auto;
        }

        .mt-4, .mt-3, .d-grid, .d-flex {
            text-align: center !important;
            justify-content: center !important;
        }

        @media (max-width: 500px) {
            .card {
                padding: 30px 4vw !important;
                max-width: 98vw;
            }
            h3 {
                font-size: 1.3rem;
            }
            .form-control, .custom-btn-width, .btn {
                font-size: 1rem;
                padding: 10px 0;
            }
        }
    </style>
</head>
<body>
    <div class="card">
        <h3 class="text-center">로그인</h3>
        <form id="loginForm">
            <div class="mb-3">
                <label for="id" class="form-label">ID</label>
                <input type="text" class="form-control" id="id" required>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">비밀번호</label>
                <input type="password" class="form-control" id="password" required>
            </div>
            <div class="mt-3">
                <a href="https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=HQtWXqb3kJJoNO1pP8Md&redirect_uri=http%3A%2F%2Flocalhost%3A8083%2FnaverCallback&state=SMHRD123">
                    <img src="https://static.nid.naver.com/oauth/big_g.PNG" class="naver-login-img" alt="네이버 로그인">
                </a>
            </div>
            <button type="submit" class="btn btn-primary custom-btn-width">로그인</button>
        </form>
        <div class="mt-4">
            <a href="<c:url value='/findIdForm'/>" class="btn btn-outline-secondary custom-btn-width">아이디 찾기</a>
            <a href="<c:url value='/resetPwForm'/>" class="btn btn-outline-warning custom-btn-width">비밀번호 재설정</a>
            <a href="<c:url value='/Signup'/>" class="btn btn-outline-primary custom-btn-width">회원가입</a>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
    $(document).ready(function () {
        $('#loginForm').on('submit', function (e) {
            e.preventDefault();

            const loginData = {
                id: $('#id').val(),
                password: $('#password').val()
            };

            $.ajax({
                url: '${pageContext.request.contextPath}/login',
                method: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(loginData),
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
