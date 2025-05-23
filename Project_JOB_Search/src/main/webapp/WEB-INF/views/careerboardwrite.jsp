<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<jsp:include page="../../resources/reset/header.jsp" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">

<title>진로게시글작성</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/common.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/careerboard.css" />
</head>
	<body>
	<div class="main-container">
	<h2>진로 게시판</h2>
	<nav id="menu">	
	<div class="writing-contents">
	<form action ="${pageContext.request.contextPath}/insert" method="post">
			<div class="title-category">
			<textarea id="board-write-title" class="write-title" name="title" placeholder="제목을 입력해 주세요." required ></textarea><br>
		<div class="write-category">
			<input type="text" name="careerTopic" class="category-style" placeholder="진로 주제" required />
		    
		    <input type="text" name="relatedMajor" class="category-style" placeholder="관련 전공" required />
		
		    <!-- ✅ select 방식 질문 유형 -->
		    <select name="questionType" class="category-style" required>
		        <option value="" disabled selected>질문 유형</option>
		        <option value="공모전">공모전</option>
		        <option value="자격증">자격증</option>
		        <option value="직업">직업</option>
		    </select>
		    </div>
   			 </div>	
   			 <div class="contenttext-write">
		    <textarea name="content" class="career-content-write" placeholder="내용을 입력하세요" ></textarea><br><br>
		    </div>	
		    
		    <br><br>
				</div>
				<div class="submit-write">
					<button type="button" class="button-fit" onclick="history.back()">뒤로가기</button>
					<button type="submit" class="button-fit">저장</button>
				</div>
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