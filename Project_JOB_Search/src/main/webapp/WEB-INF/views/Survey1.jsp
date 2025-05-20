<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>설문조사</title>
</head>
<body>
    <h2>설문조사</h2>
    <form action="submitSurvey" method="post">
        <c:forEach var="item" items="${surveys}" varStatus="status">
            <div>
                <p>${status.index + 1}. ${item}</p>
                <label>
                    <input type="radio" name="answer${status.index}" value="아니다" required> 아니다
                </label>
                <label>
                    <input type="radio" name="answer${status.index}" value="보통이다"> 보통이다
                </label>
                <label>
                    <input type="radio" name="answer${status.index}" value="그렇다"> 그렇다
                </label>
            </div>
            <hr>
        </c:forEach>
        <input type="submit" value="제출하기">
    </form>
</body>
</html>
