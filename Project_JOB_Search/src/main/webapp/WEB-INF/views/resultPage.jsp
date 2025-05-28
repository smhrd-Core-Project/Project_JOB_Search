<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>설문 결과</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
    	@font-face {
		    font-family: 'GmarketSansMedium';
		    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
		    font-weight: normal;
		    font-style: normal;
		}
		
        body {
        	background: linear-gradient(to bottom right, #ecfae0, #fff);
            font-family: 'Segoe UI', '맑은 고딕', sans-serif;
            background-color: #f4f4f4;
            text-align: center;
            padding: 40px 20px;
        }
        
        h2 {
        	font-family: 'GmarketSansMedium';
        }
        
        .result-wrapper {
            max-width: 900px;
            margin: auto;
        }

        .group-image-placeholder {
            width: 100%;
            max-width: 500px;
            height: 200px;
            margin: 30px auto;
            display: flex;
            justify-content: center;
            align-items: center;
            border-radius: 12px;
            font-size: 16px;
            color: #777;
        }

        .result-box {
            background: #ffffff;
            border-radius: 15px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.1);
            padding: 30px;
            margin-bottom: 20px;
        }

        .result-rank {
            font-size: 18px;
            font-weight: bold;
            color: #888;
        }

        .result-title {
            font-size: 24px;
            font-weight: bold;
            color: #333;
            margin: 10px 0;
        }

        .result-description {
            font-size: 15px;
            color: #555;
        }

        .signup-call {
            margin-top: 40px;
            font-size: 16px;
            color: #444;
        }

        .btn-signup {
            margin-top: 10px;
            margin-bottom: 15px;
            padding: 12px 24px;
            background-color: #00c853;
            color: white;
            font-weight: bold;
            border: none;
            border-radius: 30px;
            cursor: pointer;
            font-size: 14px;
            text-decoration: none;
            display: inline-block;
        }

        .btn-signup:hover {
            background-color: #00b44a;
        }
        
        /* 버튼 둘을 가로로 정렬하고 간격 주기 */
		.signup-buttons {
		  display: flex;
		  justify-content: center;  /* 가운데 정렬 */
		  gap: 10px;                /* 버튼 사이 여백 */
		  margin-top: 20px;         /* 위쪽 여백 */
		}
		
		/* 네이버 버튼 이미지 높이를 .btn-signup 높이에 맞추기 */
		.naver-login-btn img {
		  display: block;
		  height: calc(1em + 2 * 12px); /* font-size:14px + padding-top/bottom:12px */
		  /* 이 calc 과 같은 값이 약 38px 정도 됩니다 */
		  width: auto;
		  margin-top: 10px;
    	margin-bottom: 15px;
		  
		}
		
		/* 혹시 a 태그에 inline-block 처리 필요하면: */
		.naver-login-btn {
		  display: inline-block;
		}
        
    </style>
</head>
<body>

<div class="result-wrapper">
    <h2>🎓 설문 결과 추천 전공 🎓</h2>
	<c:set var="groupPrefix" value="${fn:substring(group, 0, fn:length(group) - 2)}"/>
    <!-- 계열 대표 이미지 자리 -->
	<div class="group-image-placeholder">
	   <img
	    src="resources/img/${groupPrefix}.png"
	    alt="${groupPrefix} 계열 대표 이미지"
	    style="max-width:100%; max-height:100%; object-fit:contain;"
	  />
	</div>


    <!-- 전공 1위 -->
    <div class="result-box">
        <div class="result-rank">1위</div>
        <div class="result-title">${recommendMajors[0]}</div>
        <div class="result-description">
            여러분의 흥미와 적성에 가장 부합하는 전공입니다!
        </div>
    </div>

    <!-- 전공 2위 -->
    <div class="result-box">
        <div class="result-rank">2위</div>
        <div class="result-title">${recommendMajors[1]}</div>
        <div class="result-description">
            고려해볼 만한 좋은 선택지입니다.
        </div>
    </div>

    <!-- 전공 3위 -->
    <div class="result-box">
        <div class="result-rank">3위</div>
        <div class="result-title">${recommendMajors[2]}</div>
        <div class="result-description">
            색다른 가능성을 가진 전공입니다.
        </div>
    </div>

    <!-- 회원가입 유도 -->
    <div class="signup-call">
        더 자세한 분석 결과를 보고 싶다면?<br>
        <strong>회원가입</strong>하고 모든 기능을 이용해보세요!
    </div>
     <div class="signup-buttons">
        <a href="${pageContext.request.contextPath}/Signup" class="btn-signup">회원가입하러 가기</a>
        <a href="https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=HQtWXqb3kJJoNO1pP8Md&redirect_uri=http%3A%2F%2Flocalhost%3A8083%2Fweb%2FnaverCallback&state=SMHRD123"
           class="naver-login-btn">
            <img src="https://static.nid.naver.com/oauth/big_g.PNG" alt="네이버 회원가입" />
        </a>
    </div>
</div>

<!-- SignupController에서 join() 전에 vo.setMajor1(ooo) 방식으로 받아올것  -->
<!-- 이에 관련된 DB도 필요? -->
<%
    session.setAttribute("group", request.getAttribute("group"));
%>


</body>
</html>
