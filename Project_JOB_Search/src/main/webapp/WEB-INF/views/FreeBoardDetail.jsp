<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<jsp:include page="../../resources/reset/header.jsp" />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="resources/static/common.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<div class = "main-container" >

	<form action="FreeBoard">
		<input type="submit" value="뒤로 가기">
	</form>
	
	<div>
	    <h2>${post.title}</h2>
	    <p>${post.views}</p>
	    <p>${post.id}</p>
	    <p>${post.content}</p>
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

		<button>💬 댓글수:${fn:length(comments)}</button>

	<div>
	    <h3>댓글</h3>
	    <c:forEach var="cmt" items="${comments}">
	        <div>
	            <b>${cmt.id}</b> - ${cmt.created_at}<br>
	            ${cmt.cmt_content}
	            <button class = "cmt-like-btn">👍</button>
	            <button class = "cmt-dislike-btn">👎</button>
	        
	        
	        </div>
	        <hr>
	    </c:forEach>    
	</div>
	
	<div>
	    <form action="InsertComment" method="post">
	        <input type="hidden" name="post_idx" value="${post.post_idx}">
	        <textarea name="cmt_content" rows="3" cols="50"></textarea><br>
	        <input type="submit" value="댓글 등록">
	    </form>
	</div>
	
	<script>
	
	//댓글달기
    $(function() {
        $('#submitComment').click(function() {
            const postIdx = $('#post_idx').val();
            const content = $('#cmt_content').val().trim();

            if (content === "") {
                alert("댓글 내용을 입력해주세요.");
                return;
            }

            $.ajax({
                type: "POST",
                url: "InsertCommentAjax",
                data: {
                    post_idx: postIdx,
                    cmt_content: content
                },
                success: function(response) {
                    const newComment = `
                        <div class="comment">
                            <b>${response.writer}</b> - 방금 전<br>
                            ${response.cmt_content}
                        </div>
                        <hr>
                    `;
                    $('#commentList').append(newComment);
                    $('#cmt_content').val(""); // 초기화
                },
                error: function() {
                    alert("댓글 등록에 실패했습니다.");
                }
            });
        });
    });
	
	
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
	            }
	        });
	    });
	});
	
	
</script>

<jsp:include page="../../resources/reset/footer.jsp" />
</body>
</html>