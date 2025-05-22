<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>

    <meta charset="UTF-8">
    <title>설문 메인 페이지</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/common.css" />
    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(to bottom right, #e0f7fa, #fff);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container-box {
            background: white;
            padding: 40px;
            border-radius: 16px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.1);
            text-align: center;
            width: 90%;
            max-width: 400px;
        }

        h1 {
            margin-bottom: 30px;
            font-weight: bold;
        }

        .btn {
            width: 100%;
            margin-bottom: 15px;
        }

        @media (max-width: 576px) {
            h1 {
                font-size: 1.5rem;
            }
        }
    </style>
</head>
<body>

<div class ="main-container">
	<div class="container-box">
	    <h1>틴넥트</h1>
	    <a href="Login" class="btn btn-primary">로그인</a>
	    <a href="Signup" class="btn btn-outline-primary">회원가입</a>
	</div>
</div>	

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
