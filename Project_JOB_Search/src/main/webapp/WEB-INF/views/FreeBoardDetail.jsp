<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<jsp:include page="../../resources/reset/header.jsp" />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="resources/common.css">
<link rel="stylesheet" href="resources/FreeBoard.css">
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
.comment-save-btn {
    color: #0000007a;
    font-weight: 600;
    padding: 4px 10px;
    border-radius: 4px;
    background: none;
    font-size: 15px; 
    cursor: pointer;
    transition: background 0.15s;
    text-decoration: none;
    border: none;

    text-align: right;    /* 텍스트 오른쪽 정렬 */
    display: block;       /* 버튼이 블록 요소면 효과 확실 */
    width: 100%;          /* 부모 너비만큼 꽉 채우기 */
}

.comment-edit-textarea{
	border:1px solid #dee2e6;
			border-radius:4px;
			margin-bottom:5px;
			margin-top:5px;
			padding: 12px 18px 14px 12px;

} 

</style>
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
	    <div class="article_info">
		    <small class="created_date">
			  <fmt:formatDate value="${post.createdAt}" pattern="yyyy-MM-dd HH:mm" />
			</small>
		    <small class="count_views">조회 ${post.views}</small>
	    </div>
	    
	     </div>
	      
	    
	    
	    <div class="article_container">
			<div class="career_main_text">
			<hr>
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
    <div class="comment_row" id="commentRow_${cmt.cmt_idx}">
        <div class="comment_header">
            <strong class="comment_writer">${cmt.id}</strong>
        </div>
        <div class="comment_body" id="commentContentTd_${cmt.cmt_idx}">
            <span class="comment_content" id="contentText_${cmt.cmt_idx}">${cmt.cmt_content}</span>
            <textarea id="contentInput_${cmt.cmt_idx}" class="content_write_board" style="display: none;">${cmt.cmt_content}</textarea>
        </div>
		
		<div>
		
		  <small class="created_date">
			  <fmt:formatDate value="${cmt.created_at}" pattern="yyyy-MM-dd HH:mm" />
			</small>
        <!-- 본인 댓글일 경우에만 수정/삭제 버튼 표시 -->
        <c:if test="${loginId eq cmt.id}">
           
            	 <small class="comment-action" onclick="editComment('${cmt.cmt_idx}')">댓글 수정</small>
				<small class="comment-action" onclick="deleteComment(${cmt.cmt_idx})">삭제</small>
            
          
        </c:if>
		</div>
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
	
	<script>
  var contextPath = '${pageContext.request.contextPath}';

  function editComment(cmt_idx) {
    const textSpan = document.getElementById("contentText_" + cmt_idx);
    const textarea = document.getElementById("contentInput_" + cmt_idx);

    if (textarea.style.display === "none") {
        textarea.style.display = "block";
      
        textSpan.style.display = "none";

        textarea.classList.add("comment-edit-textarea");
        
        if (!document.getElementById("saveBtn_" + cmt_idx)) {
            const saveBtn = document.createElement("button");
            saveBtn.innerText = "저장";
            saveBtn.id = "saveBtn_" + cmt_idx;
            saveBtn.className = "comment-save-btn"; // 필요하면 클래스 추가 가능

            saveBtn.onclick = function () {
                const newContent = textarea.value;

                $.post(contextPath + "/FreeBoard/editComment", {
                    cmt_idx: cmt_idx,
                    cmt_content: newContent
                }, function(response) {
                    if (response.status === 'success') {
                        textSpan.innerText = newContent;
                        textarea.style.display = "none";
                        textSpan.style.display = "inline";
                        saveBtn.remove();
                    } else {
                        alert("수정에 실패했습니다.");
                    }
                });
            };

            textarea.parentNode.appendChild(saveBtn);
        }
    }
  }
</script>
	
	<script>
function deleteComment(cmt_idx) {
    if (!confirm('댓글을 삭제하시겠습니까?')) return;

    $.ajax({
        url: 'DeleteComment',
        type: 'POST',
        data: { cmt_idx: cmt_idx },
        success: function(response) {
            if (response.status === 'success') {
                alert('댓글이 삭제되었습니다.');
                // 삭제한 댓글 요소를 화면에서 제거
                $('#commentRow_' + cmt_idx).remove();
            } else {
                alert('삭제 실패: ' + (response.message || '알 수 없는 오류'));
            }
        },
        error: function() {
            alert('서버와 통신 중 오류가 발생했습니다.');
        }
    });
}
</script>

<jsp:include page="../../resources/reset/footer.jsp" />
</body>
</html>



	