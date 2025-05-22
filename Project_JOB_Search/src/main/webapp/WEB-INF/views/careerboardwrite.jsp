<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<jsp:include page="../../resources/reset/header.jsp" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta charset="UTF-8">
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- Summernote CSS/JS -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote-lite.min.js"></script>
<title>진로게시글작성</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/common.css" />
</head>
<div class="main-container">
	<body>
	<h2>진로 게시판</h2>
	<nav id="menu">	
	<form action ="${pageContext.request.contextPath}/insert" method="post">
	
			<input type="text" name="title" placeholder="제목" required /><br><br>
    
		    <textarea id="summernote" name="content" placeholder="내용을 입력하세요"  required></textarea><br><br>
		    
		    <input type="text" name="careerTopic" placeholder="진로 주제" required /><br><br>
		    
		    <input type="text" name="relatedMajor" placeholder="관련 전공" required /><br><br>
		
		    <!-- ✅ select 방식 질문 유형 -->
		    <select name="questionType" required>
		        <option value="" disabled selected>질문 유형</option>
		        <option value="공모전">공모전</option>
		        <option value="자격증">자격증</option>
		        <option value="직업">직업</option>
		    </select>
		    <br><br>
					
				<input type="submit" value="저장" class="button fit">
				<input type="button" value="뒤로가기" class="button fit" onclick="history.back()">
					
				</form>
				</nav>
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