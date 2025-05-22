<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../../resources/reset/header.jsp" />
<!DOCTYPE html>
<html>

<style>
    tr:hover td {
    color: #0000ff;
	}
</style>

<head>
<link rel="stylesheet" href="resources/static/common.css">
<meta charset="UTF-8">
<title>자유게시판</title>
</head>
<body>
	<div id="free_board">
		<div class="BoarderHeader">
 		<h2>자유게시판</h2>
 		</div>
	 	<div class ="article-board">
		<table class="article-table">
				
				<tr class="table-top">
					
					<th colspan="2" class="title">제목</th>
					<th class="likes">❤️</th>	
					<th class="comments">💬</th>
													
				</tr>
 		
	 	<c:forEach var="post" items="${list}" varStatus="status">
	    <tr onclick="location.href='FreeBoardDetail?post_idx=${post.post_idx}'" style="cursor:pointer;">
	        <td class="board-list-num">${status.index + 1}</td> 
	        <td class="board-list-title">${post.title}</td>
	        <td class="board-list-likes">${post.likes}</td>
	        <td class="board-list-comments">${post.comments}</td>
	    </tr>
		</c:forEach>
 		
 	</table>
 	
 	</div>

 	
 	<div>
 		<a href = "FreeBoardWrite"><button>글쓰기</button></a>
	</div>
</div>

<<<<<<< HEAD
	<c:forEach var="i" begin="1" end="${totalPage}">
		    <a href="${pageContext.request.contextPath}/careerboard?page=${i}">
		        ${i}
		    </a>
		</c:forEach>

 	
=======
<jsp:include page="../../resources/reset/footer.jsp" />
>>>>>>> branch 'Develop1.0' of https://github.com/smhrd-Core-Project/Project_JOB_Search.git
</body>
</html>