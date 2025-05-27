<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="../../resources/reset/header.jsp" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원정보 수정</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/common.css">
	<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
	
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
            margin: 0;
            padding: 0;
            
		}
		
		 .main-outer {
            min-height: calc(100vh - 180px); /* header/footer 높이 빼고 가운데 맞춤용, 필요시 조정 */
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .main-container {
            background: white;
            padding: 40px 20px 30px 20px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.10);
            max-width: 900px;
            width: 100%;
            margin: 0 auto;
            text-align: center;
        }

		 .update-form-title {
            font-family: 'GmarketSansMedium';
            font-size: 2rem;
            margin-bottom: 28px;
            font-weight: 900;
        }
        .update-form-label {
            font-size: 1.1rem;
            font-weight: 700;
            display: block;
            margin-top: 18px;
            margin-bottom: 6px;
        }
        .update-form-input {
            width: 100%;
            font-size: 1.1rem;
            height: 50px;
            padding: 0 18px;
            border-radius: 12px;
            border: 1px solid #ddd;
            margin-bottom: 6px;
        }
        .btn-wide-green {
            display: block;
            background-color: #00c853;
            color: white;
            border: none;
            border-radius: 40px;
            padding: 14px 0;
            width: 100%;
            font-size: 1.1rem;
            font-weight: bold;
            margin-top: 22px;
            margin-bottom: 10px;
            text-decoration: none;
            transition: background 0.2s;
        }
        .btn-wide-green:hover {
            background: #03b74a;
        }

        @media (max-width: 500px) {
            .main-container {
                padding: 30px 4vw 20px 4vw;
                max-width: 98vw;
            }
            .update-form-title {
                font-size: 1.3rem;
            }
        }

		.btn-wide-green {
			display: inline-block;
			background-color: #00c853;
			color: white;
			border: none;
			border-radius: 40px;
			padding: 14px 0;
			width: 100%;
			font-size: 16px;
			font-weight: bold;
			text-decoration: none;
		}
</style>
</head>

<body>
    <div class="main-container">
        <div class="update-form-title">회원정보수정</div>
        <form action="Update2" method="post">
            <span class="update-form-label">접속한 ID</span>
            <c:out value="${sessionScope.loginUser.name}" /><br>
            <input type="hidden" name="id" value="<c:out value="${sessionScope.loginUser.id}" />"><br>
            <span class="update-form-label">이메일 변경</span>
            <input type="text" name="email" class="update-form-input" placeholder="변경할 이메일 주소를 입력하세요"><br>
            <span class="update-form-label">학교 변경</span>
            <input type="text" name="school" class="update-form-input" placeholder="변경할 학교 이름을 입력하세요"><br>
            <input type="submit" value="정보 수정" class="btn-wide-green">
        </form>
    </div>
    <jsp:include page="../../resources/reset/footer.jsp" />
</body>
</html>
