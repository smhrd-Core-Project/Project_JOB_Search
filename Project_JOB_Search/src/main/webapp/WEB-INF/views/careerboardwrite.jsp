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
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
@font-face {
		    font-family: 'GmarketSansMedium';
		    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
		    font-weight: normal;
		    font-style: normal;
		}
		
body {
    background: linear-gradient(to bottom right, #ecfae0, #fff);
    margin: 0;
    padding: 0;
}

h2 {
	font-family: 'GmarketSansMedium';
}

.main-container {
    margin: 0 auto 0 auto;
    padding: 28px 16px;
    background: #fff;
    box-shadow: 0 4px 18px rgba(0,0,0,0.08);
    min-height: 30vh;
    font-family: 'GmarketSansMedium', '맑은 고딕', sans-serif;
    box-sizing: border-box;
}
</style>
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
				
				<!--제목 입력이 안되어있는경우-->
				<script>
				document.querySelector('.submit-write button[type="submit"]').addEventListener('click', function(e) {
				    var title = document.getElementById('board-write-title').value.trim();
				    var careerTopic = document.querySelector('input[name="careerTopic"]').value.trim();
				    var relatedMajor = document.querySelector('input[name="relatedMajor"]').value.trim();
				    var questionType = document.querySelector('select[name="questionType"]').value;
				    var content = document.querySelector('textarea[name="content"]').value.trim();
				    if (title === '') {
				        alert('제목을 입력해주세요.');
				        document.getElementById('board-write-title').focus();
				        e.preventDefault(); // 폼 제출 막기
				    }
				    if (careerTopic === '') {
				        alert('진로 주제를 입력해주세요.');
				        document.querySelector('input[name="careerTopic"]').focus();
				        e.preventDefault();
				        return;
				    }
				    if (relatedMajor === '') {
				        alert('관련 전공을 입력해주세요.');
				        document.querySelector('input[name="relatedMajor"]').focus();
				        e.preventDefault();
				        return;
				    }
				    if (!questionType) {
				        alert('질문 유형을 선택해주세요.');
				        document.querySelector('select[name="questionType"]').focus();
				        e.preventDefault();
				        return;
				    }
				    if (content === '') {
				        alert('내용을 입력해주세요.');
				        document.querySelector('textarea[name="content"]').focus();
				        e.preventDefault();
				        return;
				    }
				});
				</script>
<jsp:include page="../../resources/reset/footer.jsp" />				
</body>
</html>