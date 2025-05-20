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
    <div class="article_header">
		<div class="title_area">
			<h3>${board.title}</h3>
		</div>
		
		<div class="wirter_info">
			<div class = "profile_info">
			<strong class="id">${board.id}</strong>
			</div>
			<div class="article_info">
				<small class="created_date">${board.createdAt}</small>
				<small class="count_views">조회 ${board.views}</small>
			</div>
		</div>
	</div>
		<div class="article_container">
			<div class="career_main_text">
			<span>${board.content}</span>
	
			</div>
		   <div class="Reply_Box">
		        <button id="likeBtn" data-liked="${board.liked}">
				    <c:choose>
				        <c:when test="${board.liked}">❤️</c:when>
				        <c:otherwise>🤍</c:otherwise>
				    </c:choose>
				</button>
				<span class="like_article">좋아요<span id="likeCount"> ${board.likes} </span></span>
				<span>댓글 ${board.comments}</span>
			</div>
		    <br>

 	<div class ="commentBox">
 		<div class="comment_box">
 			<c:forEach var="c" items="${comments}">
        <div class="comment_row" id="commentRow_${c.commentId}">
            <div class="comment_header">
                <strong class="comment_writer">${c.id}</strong>
                <small class="comment_date">${c.createdAt}</small>
            </div>
        <div class="comment_body" id="commentContentTd_${c.commentId}">
            <span id="contentText_${c.commentId}">${c.content}</span>
            <textarea id="contentInput_${c.commentId}" style="display: none;">${c.content}</textarea>
        </div>
            <c:if test="${loginId == c.id}">
                <div class="comment_actions">
                    <button onclick="enableEdit(${c.commentId})">✏️</button>
                    <button onclick="updateComment(${c.commentId})">💾</button>
                    <button onclick="deleteComment(${c.commentId})">🗑️</button>
                </div>
            </c:if>
        </div>
    </c:forEach>

    <c:if test="${empty comments}">
        <div class="comment_row empty">등록된 댓글이 없습니다.</div>
    </c:if>
 		</div>

    <br>

    
    <div class="commentWriter">
    <div class="comment_inbox">
        <div class="comment_inbox_id">
            <strong class="comment_id_info">${loginId}</strong>
        </div>

        <!-- 댓글 등록 form 시작 -->
        <form action="${pageContext.request.contextPath}/commentInsert" method="post" style="margin-bottom: 10px;">
            <input type="hidden" name="boardCareerId" value="${board.boardCareerId}">
            <textarea name="content" placeholder="댓글을 남겨주세요" required ></textarea>

            <!-- 한 줄로 버튼 정렬 -->
            <div style="display: flex; gap: 10px; margin-top: 10px;">
                <button type="submit">댓글 등록</button>
            </div>
		</form>
                <c:if test="${loginId == board.id}">
                    <form action="${pageContext.request.contextPath}/updateForm" method="get">
                        <input type="hidden" name="boardCareerId" value="${board.boardCareerId}" />
                        <button type="submit">수정하기</button>
                    </form>

                    <form action="${pageContext.request.contextPath}/delete" method="post">
                        <input type="hidden" name="boardCareerId" value="${board.boardCareerId}" />
                        <button type="submit" onclick="return confirm('정말 삭제하시겠습니까?');">삭제하기</button>
                    </form>
                </c:if>

                <button type="button" onclick="location.href='${pageContext.request.contextPath}/careerboard'">목록으로</button>
            </div>
        </form>
        <!-- 댓글 등록 form 끝 -->

    </div>
</div>
</div>

    <br>
    <div>
    
   <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
   
<script>
    $("#likeBtn").on("click", function() {
        const boardId = ${board.boardCareerId};
        const liked = $(this).data("liked");

        $.ajax({
            url: "${pageContext.request.contextPath}/toggleLike",
            type: "POST",
            data: { boardCareerId: boardId},
            success: function(res) {
            	if(res.error === "login_required"){
            		alert("로그인 후 이용해주세요");
            		return;
            	}
                $("#likeCount").text(res.likeCount);
                $("#likeBtn").data("liked", res.liked);
                $("#likeBtn").text(res.liked ? "❤️" : "🤍");
            }
        });
    });
</script>
<script>
function enableEdit(commentId) {
    // 텍스트 숨기고 textarea 보이기
    $("#contentText_" + commentId).hide();
    $("#contentInput_" + commentId).show().focus();
}

function updateComment(commentId) {
    const content = $("#contentInput_" + commentId).val();

    $.ajax({
        url: "${pageContext.request.contextPath}/comment/update",
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify({
            commentId: commentId,
            content: content
        }),
        success: function(res) {
            if (res === "success") {
                alert("댓글 수정 완료");

                // textarea → 텍스트 반영 후 전환
                $("#contentText_" + commentId).text(content).show();
                $("#contentInput_" + commentId).hide();
            } else if (res === "unauthorized") {
                alert("본인만 수정할 수 있습니다.");
            } else {
                alert("수정 실패");
            }
        }
    });
}
function deleteComment(commentId, boardCareerId) {
    if (!confirm("댓글을 삭제하시겠습니까?")) return;

    $.ajax({
        url: "${pageContext.request.contextPath}/comment/delete",
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify({ commentId: commentId }),
        success: function(res) {
            if (res === "success") {
                alert("삭제 완료");
                $("#commentRow_" + commentId).remove(); // DOM에서 삭제
            } else if (res === "unauthorized") {
                alert("본인만 삭제 가능합니다.");
            } else {
                alert("삭제 실패");
            }
        }
    });
}
</script>
    
</body>
</html>