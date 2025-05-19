<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시글 상세 보기</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/common.css" />
</head>
<body>
    <h2>게시글 상세 보기</h2>

    <table border="1" style="margin: auto; width: 60%;">
        <tr>
            <th>제목</th>
            <td>${board.title}</td>
        </tr>
        <tr>
            <th>작성자</th>
            <td>${board.id}</td>
        </tr>
        <tr>
            <th>진로 주제</th>
            <td>${board.careerTopic}</td>
        </tr>
        <tr>
            <th>관련 전공</th>
            <td>${board.relatedMajor}</td>
        </tr>
        <tr>
            <th>질문 유형</th>
            <td>${board.questionType}</td>
        </tr>
        <tr>
            <th>작성일</th>
            <td>${board.createdAt}</td>
        </tr>
        <tr>
            <th>수정일</th>
            <td>${board.updatedAt}</td>
        </tr>
        <tr>
            <th>내용</th>
            <td><pre>${board.content}</pre></td>
        </tr>
    </table>

    <br>

    <h3 style="text-align: center;">댓글 목록</h3>
    <table border="1" style="margin: auto; width: 60%;">
        <c:forEach var="c" items="${comments}">
            <tr>
                <td><strong>${c.id}</strong></td>
                <td>${c.content}</td>
                <td style="text-align: right;"><small>${c.createdAt}</small></td>
            </tr>
        </c:forEach>
        <c:if test="${empty comments}">
            <tr><td colspan="3" style="text-align:center;">등록된 댓글이 없습니다.</td></tr>
        </c:if>
    </table>

    <br>

    <h3 style="text-align: center;">댓글 작성</h3>
    <div style="text-align: center;">
    <form action="${pageContext.request.contextPath}/commentInsert" method="post" style="text-align: center;">
        <input type="hidden" name="boardCareerId" value="${board.boardCareerId}">
        <textarea name="content" rows="3" cols="60" placeholder="댓글을 입력하세요" required></textarea><br><br>

   		 <div style="margin-top: 10px;">
            <button type="submit" style="display: inline-block; margin-right: 10px;">댓글 등록</button>

            <button type="button" onclick="location.href='${pageContext.request.contextPath}/careerboard'">목록으로</button>
     </div>
    </form>
   
		</div>

    <br>
    <div style="text-align:center;">
        <c:if test="${loginId == board.id}">
    <form action="${pageContext.request.contextPath}/updateForm" method="get" style="display:inline-block; margin-right:10px;">
        <input type="hidden" name="boardCareerId" value="${board.boardCareerId}" />
        <input type="submit" value="수정하기" />
    </form>

    <form action="${pageContext.request.contextPath}/delete" method="post" style="display:inline-block;">
        <input type="hidden" name="boardCareerId" value="${board.boardCareerId}" />
        <input type="submit" value="삭제하기" onclick="return confirm('정말 삭제하시겠습니까?');" />
    </form>
</c:if>
   
    
</body>
</html>