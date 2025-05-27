<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>틴넥트 | 아이디 찾기</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
	<style>
        @font-face {
            font-family: 'GmarketSansMedium';
            src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
            font-weight: normal;
            font-style: normal;
        }

        body {
            background: linear-gradient(to bottom right, #ecfae0, #fff);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: '맑은 고딕', sans-serif;
        }

		.card {
            background: white;
            padding: 40px 20px;
            border-radius: 18px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.10);
            width: 100%;
            max-width: 400px;
            margin: 0 auto;
            display: flex;
		    flex-direction: column;
		    min-height: 600px;
		    justify-content: center;
		    padding-top: 80px;
		    }

        h4 {
		    font-family: 'GmarketSansMedium';
		    font-size: 2rem;
		    margin-bottom: 28px;
		    font-weight: 900;
		    text-align: center;
		    letter-spacing: -0.04em;
		}

        .form-label {
            font-size: 1.1rem;
            font-weight: 700;
            margin-bottom: 0.3rem;
        }

        .form-control {
		    font-size: 1.1rem;
		    height: 50px;
		    padding: 0 18px;
		    border-radius: 12px;
		    border: 1px solid #ddd;
		}

        .btn-primary, .btn-link {
		    width: 80%;
		    min-width: 170px;
		    font-size: 1.1rem;
		    font-weight: 600;
		    padding: 12px 0;
		    border-radius: 9px;
		    margin: 0 auto 13px auto;
		    display: block;
		    letter-spacing: -0.02em;
		}

        .mt-4, .d-grid, .text-center {
            text-align: center !important;
            justify-content: center !important;
        }

        @media (max-width: 500px) {
		    .card {
		        height: 480px;
		        min-height: 480px;
		    }
            h4 {
                font-size: 1.3rem;
            }
            .form-control, .btn-primary, .btn-link {
                font-size: 1rem;
                padding: 10px 0;
            }
        }
    </style>

</head>
<body>
    <div class="card">
        <h4 class="text-center mb-3">아이디 찾기</h4>

        <form action="findId" method="post">
            <div class="mb-3">
                <label for="name" class="form-label">이름</label>
                <input type="text" name="name" id="name" class="form-control" required placeholder=" 이름 입력">
            </div>

            <div class="mb-3">
                <label for="email" class="form-label">이메일</label>
                <input type="email" name="email" id="email" class="form-control" required placeholder=" 이메일 입력">
            </div>
            
            <div class="mb-3">
            	<label class="form-label">휴대전화 번호</label>
            	<input type="text" class="form-control" name="phone_number"
                   pattern="[0-9]{10,11}" maxlength="11" inputmode="numeric"
                   placeholder=" 숫자만 입력 (예: 01012345678)" required>
        	</div>

            <div class="d-grid">
                <button type="submit" class="btn btn-primary custom-btn-width">아이디 찾기</button>
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
