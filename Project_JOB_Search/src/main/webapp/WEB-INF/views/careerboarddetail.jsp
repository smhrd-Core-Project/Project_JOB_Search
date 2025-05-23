<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="../../resources/reset/header.jsp" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시글 상세 보기</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/common.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/careerboard.css" />
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<div class="main-container">
    <h2>진로 게시판</h2>
    <div class="article_header">
		<div class="title_area">
			<span>${board.title}</span>
		</div>
		
		<div class="wirter_info">
			<div class = "profile_info">
			<strong class="id">${board.id}</strong>
			</div>
			<div class="article_info">
				<small class="created_date">${board.createdAtStr}</small>
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
				        <c:when test="${board.liked}">
				            <img id="likeImg" src="${pageContext.request.contextPath}/resources/img/빨간하트.png" style="width:11px; height:11px; vertical-align:middle;">
				        </c:when>
				        <c:otherwise>
				            <img id="likeImg" src="${pageContext.request.contextPath}/resources/img/빈하트.png" style="width:11px; height:11px; vertical-align:middle;">
				        </c:otherwise>
				    </c:choose>
				</button>
				<span class="like_article">좋아요<span id="likeCount">${board.likes} </span></span>
					<span>
				<img src="${pageContext.request.contextPath}/resources/img/댓글.png"style="width:12px; height:12px; vertical-align:middle;">
				   댓글 ${board.comments}
				    </span>
			</div>
		    <br>
<!-- 댓글 기능 -->
 <div class="commentBox">
    <div class="comment_box">
        <c:forEach var="c" items="${comments}">
            <div class="comment_row" id="commentRow_${c.commentId}">
                <div class="comment_header">
                    <strong class="comment_writer">${c.id}</strong>
                    
                </div>
                <div class="comment_body" id="commentContentTd_${c.commentId}">
                    <span class="comment_content" id="contentText_${c.commentId}">${c.content}</span>
                    <textarea id="contentInput_${c.commentId}" class="content_write_board" style="display: none;">${c.content}</textarea>
                </div>
                <div class="comment_footer_row">
                <small class="comment_date">${c.createdAtStr}</small>
                <c:if test="${loginId eq c.id}">
                    
                        <a href="javascript:void(0);" class="edit_link" id="editLink_${c.commentId}" onclick="showEdit(${c.commentId});">댓글수정</a>
                        <a href="javascript:void(0);" class="delete_link" id="deleteLink_${c.commentId}" onclick="deleteComment(${c.commentId});">삭제</a>
                        <span class="edit-action-btns" style="display:none;">
                         <a href="javascript:void(0);" class="cancel_link" id="cancelLink_${c.commentId}" style="display:none;" onclick="cancelEdit(${c.commentId});">취소</a>
                        <a href="javascript:void(0);" class="save_link" id="saveLink_${c.commentId}" style="display:none;" onclick="updateComment(${c.commentId});">저장</a>
                    	</span>
                </c:if>
                </div>
            </div>
        </c:forEach>
    </div>
    		<!-- 댓글 페이지화 -->
				<div class="comment_pagination" >
				  <c:if test="${commentTotalPage > 1}">
				    <c:forEach var="p" begin="1" end="${commentTotalPage}">
				      <c:choose>
				        <c:when test="${p == commentPage}">
				          <span >${p}</span>
				        </c:when>
				        <c:otherwise>
				          <a href="?boardCareerId=${board.boardCareerId}&commentPage=${p}" >${p}</a>
				        </c:otherwise>
				      </c:choose>
				    </c:forEach>
				  </c:if>
				</div>
    <br>

    <!-- 댓글 작성 -->
    <div class="comment_write_box">
    <div class="comment_id_info">${loginId}</div>
        <form action="${pageContext.request.contextPath}/commentInsert" method="post" >
            <div class="comment_write_inner" >
                <textarea name="content" class="content_write_board" placeholder="댓글을 남겨주세요" required ></textarea>
                <input type="hidden" name="boardCareerId" value="${board.boardCareerId}">
                </div>
                 <div class="comment_form_bottom">
            <!-- 왼쪽에 심볼을 넣지 않을거라면 span만 두거나 빈 div -->
		            <span></span>
		            <button type="submit" class="comment_submit_btn">등록</button>
		        </div> 
        </form>
    </div>

    <!-- 게시글 본인만 수정/삭제 -->
   <div class="board_footer_actions">
    <div class="footer_left">
        <c:if test="${loginId eq board.id}">
            <form action="${pageContext.request.contextPath}/updateForm" method="get" style="display:inline;">
                <input type="hidden" name="boardCareerId" value="${board.boardCareerId}" />
                <button type="submit">수정</button>
            </form>
            <form action="${pageContext.request.contextPath}/delete" method="post" style="display:inline;">
                <input type="hidden" name="boardCareerId" value="${board.boardCareerId}" />
                <button type="submit" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</button>
            </form>
        </c:if>
    </div>
    <div class="footer_right">
        <button type="button" onclick="location.href='${pageContext.request.contextPath}/careerboard'">목록</button>
    </div>
</div>
       
        

    
</div>
</div>
</div>
    <br>
  
    

   
<script>
$("#likeBtn").on("click", function() {
    const boardId = ${board.boardCareerId};

    $.ajax({
        url: "${pageContext.request.contextPath}/toggleLike",
        type: "POST",
        data: { boardCareerId: boardId },
        success: function(res) {
            if (res.error === "login_required") {
                alert("로그인 후 이용해주세요");
                return;
            }
            $("#likeCount").text(res.likeCount);
            $("#likeBtn").data("liked", res.liked);

            // 👉 하트 이미지만 바꾸기 (src만!)
            const imgSrc = res.liked
                ? "${pageContext.request.contextPath}/resources/img/빨간하트.png"
                : "${pageContext.request.contextPath}/resources/img/빈하트.png";
            $("#likeImg").attr("src", imgSrc);
        }
    });
});
</script>
<script>
function showEdit(commentId) {
    // 기존 텍스트 숨기고 textarea 표시
    $("#contentText_" + commentId).hide();
    $("#contentInput_" + commentId).show().focus();

    // 액션 버튼: 수정/삭제 숨김, 저장/취소 표시
    $("#editLink_" + commentId).hide();
    $("#deleteLink_" + commentId).hide();
    $("#saveLink_" + commentId).show();
    $("#cancelLink_" + commentId).show();
    
    $("#commentRow_" + commentId).find('.edit-action-btns').show();
    
    $("#commentRow_" + commentId).addClass("editing");
}

function cancelEdit(commentId) {
    // textarea → 원본 텍스트로 복구
    const originalText = $("#contentText_" + commentId).text();
    $("#contentInput_" + commentId).val(originalText);

    // textarea 숨기고 텍스트 보이기
    $("#contentText_" + commentId).show();
    $("#contentInput_" + commentId).hide();

    // 액션 버튼: 수정/삭제 표시, 저장/취소 숨김
    $("#editLink_" + commentId).show();
    $("#deleteLink_" + commentId).show();
    $("#saveLink_" + commentId).hide();
    $("#cancelLink_" + commentId).hide();
    
    $("#commentRow_" + commentId).removeClass("editing");
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
                $("#contentText_" + commentId).text(content).show();
                $("#contentInput_" + commentId).hide();

                // 버튼: 수정/삭제 표시, 저장/취소 숨김
                $("#editLink_" + commentId).show();
                $("#deleteLink_" + commentId).show();
                $("#saveLink_" + commentId).hide();
                $("#cancelLink_" + commentId).hide();
                
                $("#commentRow_" + commentId).removeClass("editing");
            } else if (res === "unauthorized") {
                alert("본인만 수정할 수 있습니다.");
            } else {
                alert("수정 실패");
            }
        }
    });
}
function deleteComment(commentId) {
    if (!confirm("댓글을 삭제하시겠습니까?")) return;

    $.ajax({
        url: "${pageContext.request.contextPath}/comment/delete",
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify({ commentId: commentId }),
        success: function(res) {
            if (res === "success") {
                alert("삭제 완료");
                $("#commentRow_" + commentId).remove();
                let $countSpan = $(".Reply_Box #boardCommentCount, .Reply_Box .comment-count, #boardCommentCount, .comment-count"); // 여러 방식 대응
                if ($countSpan.length) {
                    let current = parseInt($countSpan.text().replace(/[^0-9]/g, ''));
                    if (!isNaN(current) && current > 0) {
                        $countSpan.text(current - 1);
                    }
                } else {
                    // 만약 span이 아래와 같다면: 댓글 ${board.comments}
                    // "댓글 5" → "댓글 4"로 직접 처리
                    let $commentSpan = $(".Reply_Box span:contains('댓글')");
                    $commentSpan.each(function() {
                        let text = $(this).text();
                        let match = text.match(/댓글\s*(\d+)/);
                        if (match) {
                            let num = parseInt(match[1]);
                            if (num > 0) {
                                let newText = text.replace(/댓글\s*\d+/, "댓글 " + (num - 1));
                                $(this).text(newText);
                            }
                        }
                    });
                }
            } else if (res === "unauthorized") {
                alert("본인만 삭제 가능합니다.");
            } else {
                alert("삭제 실패");
            }
        },
        error: function(xhr, status, error) {
            alert("AJAX 500 Error: " + status + " / " + error + "\n" + xhr.responseText);
        }
    });
}
</script>

<jsp:include page="../../resources/reset/footer.jsp" />
</body>
</html>