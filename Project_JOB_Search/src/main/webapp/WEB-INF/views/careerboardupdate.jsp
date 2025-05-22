<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../../resources/reset/header.jsp" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- Summernote CSS/JS -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote-lite.min.js"></script>
<title>Insert title here</title>
<link rel="stylesheet" href="/Project_JOB_Search/src/main/webapp/resources/careerboard.css" />
</head>
<body>
<div class="main-container">
<h2>진로 게시판</h2>

<form action="${pageContext.request.contextPath}/update" method="post">
    <input type="hidden" name="boardCareerId" value="${board.boardCareerId}" />

    제목: <input type="text" name="title"  value="${board.title}" required /><br><br>
    내용: <textarea id="summernote" name="content" >${board.content}</textarea><br><br>
    진로주제: <input type="text" name="careerTopic" value="${board.careerTopic}" /><br><br>
    관련전공: <input type="text" name="relatedMajor" value="${board.relatedMajor}" /><br><br>
    질문유형: <select name="questionType" required>
			    <option value="" disabled>유형 선택</option>
			    <option value="공모전" <c:if test="${board.questionType == '공모전'}">selected="selected"</c:if>>공모전</option>
				<option value="자격증" <c:if test="${board.questionType == '자격증'}">selected="selected"</c:if>>자격증</option>
				<option value="직업" <c:if test="${board.questionType == '직업'}">selected="selected"</c:if>>직업</option>
			</select><br><br>

    <input type="submit" value="수정 완료" />
    <input type="button" value="뒤로가기" class="button fit" onclick="history.back()">
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