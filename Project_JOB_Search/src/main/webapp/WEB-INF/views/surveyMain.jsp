<<<<<<< HEAD
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>전공 설문 그룹 선택</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- 구글 폰트로 세련된 글꼴 적용 -->
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">

    <style>
        body {
            margin: 0;
            font-family: 'Noto Sans KR', sans-serif;
            background: linear-gradient(135deg, #e0eafc, #cfdef3);
            height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }

        .container {
            background-color: white;
            padding: 40px 30px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            text-align: center;
            width: 90%;
            max-width: 400px;
            animation: fadeIn 0.8s ease;
        }

        .title {
            font-size: 1.6rem;
            font-weight: 700;
            margin-bottom: 25px;
            color: #333;
        }

        .group-btn {
            display: block;
            margin: 12px auto;
            width: 100%;
            padding: 15px 0;
            border: none;
            border-radius: 12px;
            font-size: 1.1rem;
            font-weight: 600;
            background: linear-gradient(45deg, #4e54c8, #8f94fb);
            color: white;
            text-decoration: none;
            transition: transform 0.2s ease, box-shadow 0.3s ease;
            box-shadow: 0 4px 10px rgba(78, 84, 200, 0.3);
        }

        .group-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 14px rgba(78, 84, 200, 0.4);
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 480px) {
            .title {
                font-size: 1.3rem;
            }

            .group-btn {
                font-size: 1rem;
                padding: 13px 0;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <div class="title">어떤 계열의 전공을 희망하시나요?</div>

    <a href="survey?group=문과계열" class="group-btn">문과 계열</a>
    <a href="survey?group=이과계열" class="group-btn">이과 계열</a>
    <a href="survey?group=예체능계열" class="group-btn">예체능 계열</a>
</div>

</body>
</html>
=======
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>전공 설문 그룹 선택</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- 구글 폰트로 세련된 글꼴 적용 -->
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">

    <style>
        body {
            margin: 0;
            font-family: 'Noto Sans KR', sans-serif;
            background: linear-gradient(135deg, #e0eafc, #cfdef3);
            height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }

        .container {
            background-color: white;
            padding: 40px 30px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            text-align: center;
            width: 90%;
            max-width: 400px;
            animation: fadeIn 0.8s ease;
        }

        .title {
            font-size: 1.6rem;
            font-weight: 700;
            margin-bottom: 25px;
            color: #333;
        }

        .group-btn {
            display: block;
            margin: 12px auto;
            width: 100%;
            padding: 15px 0;
            border: none;
            border-radius: 12px;
            font-size: 1.1rem;
            font-weight: 600;
            background: linear-gradient(45deg, #4e54c8, #8f94fb);
            color: white;
            text-decoration: none;
            transition: transform 0.2s ease, box-shadow 0.3s ease;
            box-shadow: 0 4px 10px rgba(78, 84, 200, 0.3);
        }

        .group-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 14px rgba(78, 84, 200, 0.4);
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 480px) {
            .title {
                font-size: 1.3rem;
            }

            .group-btn {
                font-size: 1rem;
                padding: 13px 0;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <div class="title">어떤 계열의 전공을 희망하시나요?</div>

    <a href="survey?group=문과계열" class="group-btn">문과 계열</a>
    <a href="survey?group=이과계열" class="group-btn">이과 계열</a>
    <a href="survey?group=예체능계열" class="group-btn">예체능 계열</a>
</div>

</body>
</html>
>>>>>>> branch 'Develop1.0' of https://github.com/smhrd-Core-Project/Project_JOB_Search.git
