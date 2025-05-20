<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>

  <link rel="stylesheet" href="resources/static/common.css">
  <meta charset="UTF-8">
  <title>Insert title here</title>
  <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
  <script>
    Kakao.init('fdd0238f969814a44a7521bb3a34b641');
    console.log(Kakao.isInitialized());
  </script>
</head>
<body>

<div class="main-container">
		<div>
			<img src="https://item.kakaocdn.net/do/c48e67b9933f2f7a10892a0217b978518f324a0b9c48f77dbce3a43bd11ce785" id="img">
			
			<hr>
			<button onclick="downloadImage()">이미지 저장하기</button>
			<hr>
			<button onclikc="shareKakao()"></button>
			<button>인스타그램</button>
			
		</div>
		<hr>
		<div>
			<a href=>탐색 결과 자세히 보기</a>
			<hr>
			<a href="MyComment">내 댓글 보기</a>
			<hr>
			<a href=>내 게시글 보기</a>
			<hr>
			<a href=>로그아웃</a>
			<a href=>/회원 정보 수정</a>
			<a href=>/탈퇴하기</a>
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

</body>
</html>