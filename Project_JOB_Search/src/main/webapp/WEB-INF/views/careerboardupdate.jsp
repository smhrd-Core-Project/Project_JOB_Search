<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../../resources/reset/header.jsp" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/common.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/careerboard.css" />
</head>
<body>
<div class="main-container">
<h2>진로 게시판</h2>
<div class="writing-contents">
<form action="${pageContext.request.contextPath}/update" method="post">
	<div class="title-category">
	<textarea id="board-write-update" class="write-title" name="title" required>${board.title}</textarea><br>
   <input type="hidden" name="boardCareerId" value="${board.boardCareerId}" />
	<div class="write-category">
				    <input type="text" name="careerTopic" class="category-style" value="${board.careerTopic}" />
				    <input type="text" name="relatedMajor" class="category-style" value="${board.relatedMajor}" />
				    
					<select name="questionType" class="category-style" required>
					    <option value="" disabled>유형 선택</option>
					
					    <option value="공모전"<c:if test="${board.questionType == '공모전'}">selected</c:if>>공모전</option>
					    <option value="자격증"<c:if test="${board.questionType == '자격증'}">selected</c:if>>자격증</option>
					    <option value="직업"<c:if test="${board.questionType == '직업'}">selected</c:if>>직업</option>
					</select>
		</div>
	</div>
	<div class="contenttext-write">
	<textarea name="content" class="career-content-write" >${board.content}</textarea>
    </div>
    <br><br>
</div>
<div class="submit-write">
    <button type="button" class="button-fit" onclick="history.back()">뒤로가기</button>
	<button type="submit" class="button-fit">수정</button>
    </div>
</form>
</div>
<script>
				  $(document).ready(function() {
				    $('#summernote').summernote({
				      height: 300,
				      lang: 'ko-KR',
				      callbacks: {
				        onImageUpload: function(files) {
				          for (let i = 0; i < files.length; i++) {
				            sendFile(files[i]);
				          }
				        }
				      }
				    });
				
				    function sendFile(file) {
				      var formData = new FormData();
				      formData.append("file", file);
				
				      $.ajax({
				        url: "${pageContext.request.contextPath}/uploadImage", // 이미지 업로드 컨트롤러
				        type: "POST",
				        data: formData,
				        contentType: false,
				        processData: false,
				        success: function(url) {
				          $('#summernote').summernote('insertImage', url);
				        }
				      });
				    }
				  });
				</script>	

<jsp:include page="../../resources/reset/footer.jsp" />
</body>
</html>