<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>틴넥트 | 로그인</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
    	@font-face {
		    font-family: 'Freesentation-9Black';
		    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/2404@1.0/Freesentation-9Black.woff2') format('woff2');
		    font-weight: 900;
		    font-style: normal;
		}
		
        body {
            background: linear-gradient(to bottom right, #ecfae0, #fff);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        
        h3 {
        	font-family: Freesentation-9Black;
        }
    </style>

</head>
<body class="d-flex justify-content-center align-items-center vh-100 bg-light">
    <div class="card p-4 shadow" style="width: 350px;">
        <h3 class="text-center mb-4">로그인</h3>
        <form id="loginForm">
            <div class="mb-3">
                <label for="id" class="form-label">ID</label>
                <input type="text" class="form-control" id="id" required>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">비밀번호</label>
                <input type="password" class="form-control" id="password" required>
            </div>
            <div class="d-grid">
                <button type="submit" class="btn btn-primary">로그인</button>
            </div>
        </form>
        <div class="mt-3 text-center">
            <a href="<c:url value='/Signup'/>" class="btn btn-outline-primary w-100">회원가입</a>
        </div>
    </div>
		<div style="text-align: center;" class="mt-3">
  			<a href="https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=HQtWXqb3kJJoNO1pP8Md&redirect_uri=http%3A%2F%2Flocalhost%3A8083%2FnaverCallback&state=SMHRD123">
    		<img src="https://static.nid.naver.com/oauth/big_g.PNG" width="200" />
  			</a>
		</div>

		<div class="d-grid gap-2 mt-4">
    		<a href="<c:url value='/findIdForm'/>" class="btn btn-outline-secondary">아이디 찾기</a>
   			<a href="<c:url value='/resetPwForm'/>" class="btn btn-outline-warning">비밀번호 재설정</a>
			<a href="<c:url value='/Signup'/>" class="btn btn-outline-primary">회원가입</a>
		</div>
	</div>

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
	                    // 로그인 성공 시 이동
	                    window.location.href = '${pageContext.request.contextPath}/loginSuccess';
	                } else {
	                    alert(response.message); // 로그인 실패 메시지
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