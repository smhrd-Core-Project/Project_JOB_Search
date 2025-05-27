<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../../resources/reset/header.jsp" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>자유게시판</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
     <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/common.css">
     <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/FreeBoard.css">
 <style>
        tr:hover td {
            color: #0000ff;
        }
        
@font-face {
		    font-family: 'GmarketSansMedium';
		    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
		    font-weight: normal;
		    font-style: normal;
		}
		
body {
    background: linear-gradient(to bottom right, #ecfae0, #fff);
    margin: 0;
    padding: 0;
}

h2 {
	font-family: 'GmarketSansMedium';
}

.main-container {
    margin: 0 auto 0 auto;
    padding: 28px 16px;
    background: #fff;
    box-shadow: 0 4px 18px rgba(0,0,0,0.08);
    min-height: 40vh;
    font-family: '맑은 고딕', sans-serif;
    box-sizing: border-box;
}
    </style>
</head>
<body>
    <div class="main-container">
        <div id="free_board">
            <div class="BoarderHeader">
                <h2>자유게시판</h2>
            </div>
            <div class="article-board">
                <table class="article-table">
                    <tr class="table-top">
                    	<th class="board-list-num">번호</th>
                        <th class="title">제목</th>
                        <th class="likes">❤️</th>    
                        <th class="comments">💬</th>
                        <th class="views">👁️</th>
                    </tr>
                    <c:forEach var="post" items="${list}" varStatus="status">
                        <tr class="board-list">
                            <td class="board-list-num">${status.index + 1}</td> 
                            <td class="board-list-title">
                                <a href="${pageContext.request.contextPath}/FreeBoardDetail?post_idx=${post.post_idx}">
                                    ${post.title}
                                </a>
            </td>
                            <td class="board-list-likes">${post.likes}</td>
                            <td class="board-list-comments">${post.comments}</td>
                            <td class="board-list-views">${post.views}</td>
                        </tr>
                    </c:forEach>
                </table>
            </div> 
	            <div class = "BoardBottonOption">
	            	<div class="option-area">
                    	<div class="right-area">
			 		<a href = "FreeBoardWrite"><button>✏️글쓰기</button></a>
				</div> 
				</div> 
				</div> 
				
                  
	    <div class="page">
	    <c:if test="${currentPage > 1}">
	        <a href="${pageContext.request.contextPath}/FreeBoard?page=${currentPage - 1}">이전</a>
	    </c:if>
	
	    <c:forEach begin="1" end="${totalPage}" var="i">
	        <c:choose>
	            <c:when test="${i == currentPage}">
	                <span style="font-weight: bold; color: red;">${i}</span>
	            </c:when>
	            <c:otherwise>
	                <a href="${pageContext.request.contextPath}/FreeBoard?page=${i}">${i}</a>
	            </c:otherwise>
	        </c:choose>
	    </c:forEach>

    <c:if test="${currentPage < totalPage}">
        <a href="${pageContext.request.contextPath}/FreeBoard?page=${currentPage + 1}">다음</a>
    </c:if>   
        </div>
    </div>
  
</div>



 	

<jsp:include page="../../resources/reset/footer.jsp" />
</body>
</html>