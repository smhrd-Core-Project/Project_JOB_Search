<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>${group} 설문조사</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">

    <style>
        body {
            margin: 0;
            font-family: 'Noto Sans KR', sans-serif;
            background: linear-gradient(135deg, #fdfbfb, #ebedee);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            text-align: center;
            padding: 20px;
        }

        #surveyForm {
            display: none;
        }

        .progress {
            font-size: 1rem;
            margin-bottom: 15px;
            color: #666;
        }

        .question-box {
            background-color: white;
            padding: 30px 25px;
            border-radius: 20px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
            font-size: 1.4rem;
            min-height: 120px;
            max-width: 90%;
            width: 500px;
            opacity: 0;
            transform: translateY(20px);
            transition: all 0.4s ease;
        }

        .question-box.show {
            opacity: 1;
            transform: translateY(0);
        }

        .answer-btn {
            display: block;
            width: 100%;
            max-width: 300px;
            margin: 12px auto;
            padding: 15px;
            border: none;
            border-radius: 12px;
            font-size: 1rem;
            background: linear-gradient(45deg, #667eea, #764ba2);
            color: white;
            font-weight: bold;
            cursor: pointer;
            transition: transform 0.2s ease, box-shadow 0.3s ease;
            box-shadow: 0 5px 12px rgba(118, 75, 162, 0.3);
        }

        .answer-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 18px rgba(118, 75, 162, 0.4);
        }

        @media (max-width: 500px) {
            .question-box {
                font-size: 1.2rem;
                padding: 20px;
            }

            .answer-btn {
                font-size: 0.95rem;
            }
        }
    </style>
</head>
<body>

<form id="surveyForm" action="sendSurvey.do" method="post">
    <input type="hidden" name="major_type" value="${group}" />
</form>

<h2 class="progress" id="progress"></h2>
<div class="question-box" id="questionBox"></div>

<button class="answer-btn" onclick="chooseAnswer('그렇다')">그렇다</button>
<button class="answer-btn" onclick="chooseAnswer('보통이다')">보통이다</button>
<button class="answer-btn" onclick="chooseAnswer('아니다')">아니다</button>

<script>
    const questions = [
        <c:forEach var="item" items="${surveys}" varStatus="status">
            "${item}"<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ];

    let current = 0;

    function renderQuestion() {
        const questionBox = document.getElementById("questionBox");
        if (current >= questions.length) {
            document.getElementById("surveyForm").submit();
            return;
        }

        document.getElementById("progress").innerText = (current + 1) + " / " + questions.length;

        // 트랜지션 효과를 위해 class 제거 → 내용 변경 → 다시 추가
        questionBox.classList.remove("show");
        setTimeout(() => {
            questionBox.innerText = questions[current];
            questionBox.classList.add("show");
        }, 150);
    }

    function chooseAnswer(answerText) {
        const form = document.getElementById("surveyForm");

        const qText = document.createElement("input");
        qText.type = "hidden";
        qText.name = "q" + (current + 1) + "_text";
        qText.value = questions[current];

        const qScore = document.createElement("input");
        qScore.type = "hidden";
        qScore.name = "q" + (current + 1) + "_score";
        qScore.value = answerText;

        form.appendChild(qText);
        form.appendChild(qScore);

        current++;
        renderQuestion();
    }

    window.onload = renderQuestion;
</script>

</body>
</html>
