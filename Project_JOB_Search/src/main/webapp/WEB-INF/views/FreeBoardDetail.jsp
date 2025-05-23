<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<jsp:include page="../../resources/reset/header.jsp" />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="resources/common.css">
<link rel="stylesheet" href="resources/FreeBoard.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<div class = "main-container" >

	
	<h2>자유 게시판</h2>
	<div class="article_header">
		<div class="title_area">
		<span>${post.title}</span>
		</div>
	<div class ="wirter_info">
		<div class = profile_info>
	    <strong class="id">${post.id}</strong>
	    </div>
	    <div class="article_info"
	    <small class="created_date">${board.created_at}</small>
	    <small class="count_views">조회 ${post.views}</small>
	    </div>
	    
	     </div>
	      
	    
	    
	    <div class="article_container">
			<div class="career_main_text">
			<span>${post.content}</span>
	
			</div>
		
	<hr>
	<div>
	
		<button id="likeBtn">
		  <c:choose>
		    <c:when test="${liked}">
		      💔 좋아요 취소 (<span id="likeCount">${post.likes}</span>)
		    </c:when>
		    <c:otherwise>
		      ❤️ 좋아요 (<span id="likeCount">${post.likes}</span>)
		    </c:otherwise>
		  </c:choose>
		</button>

		<button id="likeBtn">💬 댓글수:${fn:length(comments)}</button>
	

	<div>

	<div class="commentBox">
		<div class = "comment_box">
		
	
		
	    
<c:forEach var="cmt" items="${comments}">
    <div class="comment_row" id="commentRow_${cmt.id}">
        <div class="comment_header">
            <strong class="comment_writer">${cmt.id}</strong>
        </div>
        <div class="comment_body" id="commentContentTd_${cmt.id}">
            <span class="comment_content" id="contentText_${cmt.id}">${cmt.cmt_content}</span>
            <textarea id="contentInput_${cmt.id}" class="content_write_board" style="display: none;">${cmt.cmt_content}</textarea>
        </div>

    </div>
</c:forEach>

		<div class="comment_write_box">
		 <div class="comment_id_info">${loginId}</div>
	    <form action="InsertComment" method="post">
	        <input type="hidden" name="post_idx" value="${post.post_idx}">
	        <textarea name="cmt_content" rows="3" cols="50" class="cmt_textarea" placeholder="댓글을 남겨주세요" required></textarea><br>
	         <div style="text-align: right;">
        <input type="submit" value="등록" class="cmt_submit">
    </div>
	    </form>
	</div>

	<div class="footer_right">
	<form action="FreeBoard">
		
		<input type="submit" value="목록">
		
	</form>
	</div>
	

	
	<script>

	//글 좋아요
	$(function() {
	    $('#likeBtn').click(function() {
	        $.post("ToggleLike", {
	            post_idx: '${post.post_idx}'
	        }, function(response) {
	            if (response.status === 'success') {
	                const likeCount = response.likeCount;
	                const liked = response.liked;
	
	                $('#likeCount').text(likeCount);
	                if (liked) {
	                    $('#likeBtn').text('💔 좋아요 취소 (' + likeCount + ')');
	                } else {
	                    $('#likeBtn').text('❤️ 좋아요 (' + likeCount + ')');
	                }
	            } else {
	                alert(response.message || "오류가 발생했습니다.");
	            }"src/main/webapp/WEB-INF/views/FreeBoardWrite.jsp"
	        });
	    });
	});


	</script>
	
	
</script>

<jsp:include page="../../resources/reset/footer.jsp" />
</body>
</html>



	