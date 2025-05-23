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
  <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
  <script>
    Kakao.init('fdd0238f969814a44a7521bb3a34b641');
    console.log(Kakao.isInitialized());
  </script>
  
  <style>
  	@font-face {
		    font-family: 'Freesentation-9Black';
		    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/2404@1.0/Freesentation-9Black.woff2') format('woff2');
		    font-weight: 500;
		    font-style: normal;
		}
	
  	.main-container {
  		font-family: 'Segoe UI', '맑은 고딕', sans-serif;
  	}
  	
  	h3 {
  		font-family: 'Freesentation-9Black';
  	}
  	
  </style>
</head>

<body>
<div class="main-container">
		<div>
			<h3>
			<c:out value="${sessionScope.loginUser.name}" />
			<span>의 프로필</span></h3><br>
			<img src="https://item.kakaocdn.net/do/c48e67b9933f2f7a10892a0217b978518f324a0b9c48f77dbce3a43bd11ce785" id="img">
			<button onclick="downloadImage()" class="btn btn-outline-success">이미지 저장하기</button>
		</div>
		<hr>
		<div>
			<h3>진로 탐색 결과</h3> <br>
			<a href= "" class="btn btn-success">탐색 결과 자세히 보기</a><br><br>
			<a href= "surveyMain" class="btn btn-success">재탐색 하기</a>
			<hr>
			<h3>커뮤니티 활동</h3> <br>
			<a href="MyBoard"  class="btn btn-success">내 게시글 보기</a><br><br>
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
</div>
	
	
<script>
	function downloadImage() {
	    const imageUrl = document.getElementById("img").src;
	    const link = document.createElement('a');
	    link.href = imageUrl;
	    link.download = 'img.jpg'; // 다운로드될 파일 이름
	    document.body.appendChild(link);
	    link.click();
	    document.body.removeChild(link);
	}
	
	function shareKakao() {
		  Kakao.Link.sendDefault({
		    objectType: 'feed',
		    content: {
		      title: '나의 진로 이미지 결과',
		      description: '청소년 진로 탐색 결과를 공유합니다!',
		      imageUrl: document.getElementById("careerImage").src, // 현재 이미지 가져오기
		      link: {
		        mobileWebUrl: location.href,
		        webUrl: location.href
		      }
		    },
		    buttons: [
		      {
		        title: '결과 보러가기',
		        link: {
		          mobileWebUrl: location.href,
		          webUrl: location.href
		        }
		      }
		    ]
		  });
		}
	
</script>
<!-- FOOTER 입력 -->
<jsp:include page="../../resources/reset/footer.jsp" />
</body>
</html>