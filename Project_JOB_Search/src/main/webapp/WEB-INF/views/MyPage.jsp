<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- HEADER 입력 -->
<jsp:include page="../../resources/reset/header.jsp" />

<!DOCTYPE html>
<html>
<head>
  <!-- 로그인성공 화면 부트스트랩 입력 -->
  <link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
  <!-- 공통CSS 입력 -->
  <link rel="stylesheet" href="resources/common.css">
  <!-- 버튼 부트스트랩 -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  <meta charset="UTF-8">
  <title>마이페이지</title>

  
  <style>
  	@font-face {
	    font-family: 'GmarketSansMedium';
	    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
	    font-weight: normal;
	    font-style: normal;
	}
	
  	.main-container {
  		font-family: 'Segoe UI', '맑은 고딕', sans-serif;
  	}
  	
  	h3 {
  		font-family: 'GmarketSansMedium';
  	}
  	
  	.btn {
  		margin-bottom: 15px;
  	}
  	
  </style>
</head>

<body>
<div class="main-container">
		<div>
			<h3>
			<c:out value="${sessionScope.loginUser.name}" />
			<span>의 프로필</span></h3><br>
			<div style="display: flex; align-items: center; margin-bottom: 20px;">
			  <!-- 프로필 이미지 -->
			  <div>
			    <img id="img" style="width: 130px; object-fit:cover;"src="<c:choose>
			         <c:when test='${not empty loginUser.user_profile}'>
			           ${pageContext.request.contextPath}${loginUser.user_profile}
			         </c:when>
			         <c:otherwise>
			           ${pageContext.request.contextPath}/resources/img/user_profile/default/default.jpg
			         </c:otherwise>
			       </c:choose>"
				>
			    
			  </div>
			
			  <!-- 우측에 개인정보 영역 -->
			  <div style="margin-left: 32px;">
			    <div style="font-weight: bold; font-size: 18px; margin-bottom: 8px;">
			      <c:out value="${sessionScope.loginUser.name}" /> 님
			    </div>
			    <div>ID : <c:out value="${sessionScope.loginUser.id}" /></div>
			    <div>이메일 : <c:out value="${sessionScope.loginUser.email}" /></div>
			    <div>학교 : <c:out value="${sessionScope.loginUser.school}" /></div>
			    <div>학년 : <c:out value="${sessionScope.loginUser.grade}" /></div>
			    <!-- 필요하면 다른 정보도 추가 가능 -->
			  </div>
			</div>
			<button onclick="Myprofile_Image()" class="btn btn-outline-success">프로필 사진 지정하기</button>
		</div>
		<hr>
		<div>
			<h3>진로 탐색 결과</h3> <br>
			<a href="MySearch_result" class="btn btn-success">탐색 결과 자세히 보기</a><br>
			<a href= "surveyMain" class="btn btn-success">재탐색 하기</a>
			<hr>
			<h3>커뮤니티 활동</h3> <br>
			<a href="MyBoard"  class="btn btn-success">내 게시글 보기</a><br>
			<a href="MyComment"  class="btn btn-success">내 댓글 보기</a>
			<hr>
			<div style="text-align: center;">
			<a href="Logout" class="btn btn-outline-success">로그아웃</a>
			<a href="Update" class="btn btn-outline-success">회원 정보 수정</a>
			  <c:if test="${updateSuccess}">
			    <script>
 			     alert("비밀번호가 성공적으로 변경되었습니다!");
 			   </script>
 			  </c:if>
			<a href="DeleteUser" class="btn btn-outline-success" onclick="return confirm('정말 탈퇴하시겠습니까?');">탈퇴하기</a>
			</div>
		</div>


  <div class="main-container">
    …
    <button id="openProfileModal" class="btn btn-outline-success">
      프로필 사진 지정하기
    </button>
    …
  </div>

  <!-- 프로필 사진 모달 -->
<div class="modal fade" id="profileModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <form id="profileForm"
            action="${pageContext.request.contextPath}/updateProfileImage"
            method="post"
            enctype="multipart/form-data">
        <div class="modal-header">
          <h5 class="modal-title">
            프로필 사진
            <c:choose>
              <c:when test="${not empty sessionScope.loginUser.user_profile}">
                수정
              </c:when>
              <c:otherwise>등록</c:otherwise>
            </c:choose>
          </h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
        </div>
        <div class="modal-body text-center">
		<c:set var="previewSrc"
		       value="${not empty sessionScope.loginUser.user_profile
		                 ? pageContext.request.contextPath.concat(sessionScope.loginUser.user_profile)
                 : pageContext.request.contextPath.concat('/resources/img/user_profile/default/default.jpg')}" />

          <div class="mb-3">
            <img
			  id="profilePreview"
			  src="${previewSrc}"
			  class="img-thumbnail mb-3"
			  style="width:100px; height:100px; object-fit:cover; display:block; margin:0 auto;"
			  alt="프로필 사진 미리보기">
            <input class="form-control" type="file" name="profileImage" id="profileImageInput" required>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button"
                  class="btn btn-secondary"
                  data-bs-dismiss="modal">취소</button>
          <button type="submit"
                  class="btn btn-primary">
            <c:choose>
              <c:when test="${not empty sessionScope.loginUser.user_profile}">
                수정하기
              </c:when>
              <c:otherwise>등록하기</c:otherwise>
            </c:choose>
          </button>
        </div>
      </form>
    </div>
  </div>
</div>


  
</div>

<!-- 플래시 에러 메시지 얼럿 -->
  <c:if test="${not empty profileError}">
    <script>
      alert('${profileError}');
    </script>
  </c:if>
  
  <!-- Bootstrap JS (modal 동작용) -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script>
  document.addEventListener('DOMContentLoaded', function() {
	  const input = document.getElementById('profileImageInput');
	  const preview = document.getElementById('profilePreview');
	  input.addEventListener('change', function(e) {
	    const [file] = this.files;
	    if (file) {
	      const reader = new FileReader();
	      reader.onload = function(evt) {
	        preview.src = evt.target.result;
	      }
	      reader.readAsDataURL(file);
	    }
	  });
	});
//프로필 사진 모달을 띄우는 함수
  function Myprofile_Image() {
    // 모달 엘리먼트
    const modalEl = document.getElementById('profileModal');
    if (!modalEl) {
      console.error('profileModal 엘리먼트를 찾을 수 없습니다.');
      return;
    }
    // Bootstrap Modal 인스턴스 생성 및 표시
    const modal = new bootstrap.Modal(modalEl);
    modal.show();
  }
  </script>
</body>
</html>


<!-- FOOTER 입력 -->
<jsp:include page="../../resources/reset/footer.jsp" />
</body>
</html>