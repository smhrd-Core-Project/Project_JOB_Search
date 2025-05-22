<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="resources/static/common.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="main-container">
		 <h3>진로 게시판 내 게시글</h3>
		    <ul class=>
		        <c:forEach var="post" items="${careerPosts}">
		            <li class="post-item">
		                <span>${post.title}</span> 
		                <span>${post.contnet}</span>
	
		                  <form action="deleteBoard" method="post" style="display:inline;">
					            <input type="hidden" name="board_id" value="${post.id}" >
					            <input type="hidden" name="type" value="career" >
					            <button type="submit" onclick="return confirm('정말 삭제하시겠습니까?')">삭제</button>
					      </form>
					        <form action="UpdateBoard" method="get" style="display:inline;">
				                <input type="hidden" name="board_id" value="${post.id}" >
				                <input type="hidden" name="type" value="career" >
				                <button type="submit">수정하기</button>
				            </form>
		            </li>
		        </c:forEach>
		        <c:if test="${empty careerPosts}">
		            <li>진로 게시판에 작성한 글이 없습니다.</li>
		        </c:if>
		    </ul>
		
		    <h3>자유 게시판 내 게시글</h3>
		    <ul class="comment-list">
		        <c:forEach var="post" items="${freePosts}">
		            <li class="post-item">
		                <span>${post.title}</span> 
		                <span>${post.contnet}</span>
		           
		                <form action="deleteBoard" method="post" style="display:inline;">
				            <input type="hidden" name="cmt_id" value="${post.id}" />
				            <input type="hidden" name="type" value="free" />
				            <button type="submit" onclick="return confirm('정말 삭제하시겠습니까?')">삭제</button>
				        </form>
				        <form action="UpdateBoard" method="get" style="display:inline;">
				        	<input type="hidden" name="cmt_idx" value="${post.id}" >
				        	<input type="hidden" name="type" value="free" >
				            <button type="submit">수정하기</button>
				       </form>
				        
		            </li>
		        </c:forEach>
		        <c:if test="${empty freePosts}">
		            <li>자유 게시판에 글이 없습니다.</li>
		        </c:if>
		    </ul>
		</div>

</body>
</html>