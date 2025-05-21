<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>${group} 설문조사</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        body {
            font-family: '맑은 고딕', sans-serif;
            text-align: center;
            padding: 40px;
        }
        .question-box {
            background: #f1f1f1;
            padding: 20px;
            border-radius: 20px;
            font-size: 1.3rem;
            margin-bottom: 20px;
            display: inline-block;
        }
        .answer-btn {
            display: block;
            margin: 10px auto;
            width: 80%;
            max-width: 300px;
            padding: 15px;
            border: none;
            border-radius: 10px;
            font-size: 1rem;
            background-color: #444;
            color: white;
            cursor: pointer;
        }
        .answer-btn:hover {
            background-color: #666;
        }
    </style>
</head>
<body>

<form id="surveyForm" action="sendSurvey.do" method="post">
    <input type="hidden" name="major_type" value="${group}" />
</form>

<h2 id="progress"></h2>
<div class="question-box" id="question"></div>

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
        if (current >= questions.length) {
            document.getElementById("surveyForm").submit();
            return;
        }

        document.getElementById("progress").innerText = (current + 1) + " / " + questions.length;
        document.getElementById("question").innerText = questions[current];
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
