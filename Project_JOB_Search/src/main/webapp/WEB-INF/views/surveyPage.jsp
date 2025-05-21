<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>${group} 설문조사</title>
</head>
<body>
    <h2>${group} 설문조사</h2>
    <form action="sendSurvey.do" method="post">
        <c:forEach var="item" items="${surveys}" varStatus="status">
            <div>
                <p>
                    ${status.index + 1}.
                    <label>${item}</label>
                </p>

                <!-- 질문 텍스트 전송 -->
                <input type="hidden" name="q${status.index + 1}_text" value="${item}" />

                <!-- 응답값: 아니다 or 보통이다 or 그렇다 전송 -->
                <label>
                    <input type="radio" name="q${status.index + 1}_score" value="아니다" required> 아니다
                </label>
                <label>
                    <input type="radio" name="q${status.index + 1}_score" value="보통이다"> 보통이다
                </label>
                <label>
                    <input type="radio" name="q${status.index + 1}_score" value="그렇다"> 그렇다
                </label>
            </div>
            <hr/>
        </c:forEach>

        <!-- 전공 타입도 함께 전송 -->
        <input type="hidden" name="major_type" value="${group}" />

        <input type="submit" value="제출하기" />
    </form>
</body>
</html>
