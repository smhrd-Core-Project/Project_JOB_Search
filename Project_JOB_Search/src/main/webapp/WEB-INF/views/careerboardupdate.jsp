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
	<textarea id="board-write-update" class="write-title" name="title" placeholder="제목을 입력해 주세요." required>${board.title}</textarea><br>
   <input type="hidden" name="boardCareerId" value="${board.boardCareerId}" />
	<div class="write-category">
				    <input type="text" name="careerTopic" class="category-style" placeholder="진로 주제" value="${board.careerTopic}" />
				    <input type="text" name="relatedMajor" class="category-style" placeholder="관련 전공" value="${board.relatedMajor}" />
				    
						<select name="questionType" class="category-style">
						    <option value="" disabled ${empty board.questionType ? 'selected' : ''}>유형 선택</option>
						    <option value="공모전" ${board.questionType == '공모전' ? 'selected' : ''}>공모전</option>
						    <option value="자격증" ${board.questionType == '자격증' ? 'selected' : ''}>자격증</option>
						    <option value="직업" ${board.questionType == '직업' ? 'selected' : ''}>직업</option>
						</select>
		</div>
	</div>
	<div class="contenttext-write">
	<textarea name="content" class="career-content-write" placeholder="내용을 입력하세요" >${board.content}</textarea>
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

				<script>
				document.querySelector('.submit-write button[type="submit"]').addEventListener('click', function(e) {
				    // 제목
				    var title = document.getElementById('board-write-update').value.trim();
				    // 진로 주제
				    var careerTopic = document.querySelector('input[name="careerTopic"]').value.trim();
				    // 관련 전공
				    var relatedMajor = document.querySelector('input[name="relatedMajor"]').value.trim();
				    // 질문 유형
				    var questionType = document.querySelector('select[name="questionType"]').value;
				    // 내용
				    var content = document.querySelector('textarea[name="content"]').value.trim();
				
				    if (title === '') {
				        alert('제목을 입력해주세요.');
				        document.getElementById('board-write-update').focus();
				        e.preventDefault();
				        return;
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