<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="resources/common.css"/>
<meta charset="UTF-8">
<style>
@font-face {
    font-family: 'GmarketSansMedium';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}

/* From Uiverse.io by gharsh11032000 */ 
.card-container {
  width: 600px;
  height:800px;
  position: relative;
  border-radius: 10px;
  margin-bottom: 20px;  /* 카드별 간격 */
  
}

.card-container::before {
  content: "";
  z-index: -1;
  position: absolute;
  inset: 0;
  background: linear-gradient(-45deg, #e5ffde 0%, #a7ce9d 100%);
  transform: translate3d(0, 0, 0) scale(0.95);
  filter: blur(20px);
}

.card {
  width: 600px;
  height: 800px;
  border-radius: inherit;
  position: relative;
  overflow: hidden;
  
}

.card .img-content {
  height: 100%;
  /*display: flex;*/
  align-items: center;
  justify-content: center;
  background: linear-gradient(-45deg, #e5ffde 0%, #a7ce9d 100%);
  transition: transform 0.6s ease, filter 1s ease;
   /* 추가 ↓ */
  font-size: 18px;  /* 원하시는 사이즈로 조정 */
  font-family: 'GmarketSansMedium';
  line-height: 1.5;
  color: #000; /* 글자색도 필요에 따라 추가 */
  overflow-y: auto; /* 내용이 많으면 스크롤 */
  padding: 15px;
  text-align: left; /* 텍스트 왼쪽 정렬 */
  min-height: 350px; /* 필요에 따라 최소 높이만 지정 */
  position: relative;
  z-index: 1;
  
  
}



.card .content {
max-height: 0;
  overflow: hidden;
  pointer-events: none;
  position: absolute;
  font-family: 'GmarketSansMedium';
  font-size: 19px;
  top: 0;
  left: 0;
  width: 570px;
  height: 100%;
  /*display: flex;*/
  flex-direction: column;
  justify-content: center;
  gap: 10px;
  color: #000000;
  padding: 15px;
  line-height: 1.5;
  border-radius: 5px;
  opacity: 0;
  pointer-events: none;
  transform: translateY(50px);
  transition: all 0.6s cubic-bezier(0.23, 1, 0.320, 1);
  position: absolute;
  z-index: 1;
  
}

.card .content .heading {
  font-size: 20px;
  font-weight: 700;
}
.card-container .img-content .heading {
  font-size: 20px;
  font-weight: 700; 
}

.card.active  .content {
  opacity: 1;
  transform: translateY(0);
  max-height: calc(100% - 30px);  /* 카드 높이에서 상하 padding(15px×2) 제외 */
  overflow-y: auto;
  pointer-events: auto;
}

.card.active .img-content {
  scale: 2.5;
  filter: blur(7px);
}

.card.activer .img-content svg {
  fill: transparent;
}

.major-cards {
  display: flex;
  justify-content: center;
  align-items: center;
  flex-wrap: wrap;   /* 필요 시 줄 바꿈 허용 */
  gap: 20px;   
}
</style>



<title>나의 탐색 결과 확인</title>
</head>
<body>

<div class="main-container">
  <!-- 1. 상단에 계열 이미지 한 번만 출력 (전공이 있을 때만) -->
  <c:if test="${not empty Myresult_major}">
    <p style="font-weight:bold; text-align:center; margin-bottom:30px; font-size:25px; font-family: 'GmarketSansMedium';">
  	추천된 계열은 ${Myresult_major[0].majorDivision}/${Myresult_major[0].majorIclass} 입니다
  	</p>
    <div style="text-align:center; margin-bottom:30px;">
      <img src="resources/img/${fn:replace(Myresult_major[0].majorDivision, '계열', '')}.png"
     alt="${Myresult_major[0].majorDivision}"
     style="max-width:500px; height:auto;">
    </div>
  </c:if>

	<div class="major-cards">
	  <!-- 전공별 카드 반복 출력 -->
	  <c:choose>
	    <c:when test="${not empty Myresult_major}">
	      <c:forEach var="major" items="${Myresult_major}">
	        <div class="card-container">
	          <div class="card">
	            <div class="img-content" style="background:
	              <c:choose>
	                <c:when test="${fn:replace(major.majorDivision, '계열', '') == '이과'}">
	                  linear-gradient(#d1f4ff 0%, #77b2ff 100%);
	                </c:when>
	                <c:when test="${fn:replace(major.majorDivision, '계열', '') == '문과'}">
	                  linear-gradient( #fffbe5 0%, #f0e6cf 100%);
	                </c:when>
	                <c:when test="${fn:replace(major.majorDivision, '계열', '') == '예체능'}">
	                  linear-gradient( #ffe5fa 0%, #ffb3de 100%);
	                </c:when>
	                <c:otherwise>
	                  linear-gradient( #e5ffde 0%, #a7ce9d 100%);
	                </c:otherwise>
	              </c:choose>
	            ">
	              <p class="heading">${major.majorName} <small>(${major.majorDivision}/${major.majorIclass})</small></p>
	              <p><b>학교:</b> ${major.university}</p>
	              <p><b>전공 설명:</b><br/>${major.majorDescription}</p>
	              <p><b>전공 스킬:</b><br/>${major.majorSkill}</p>
	              <p><b>공통 과목:</b><br/>${major.commonSubj}</p>
	              <p><b>일반 선택 과목:</b><br/>${major.noMarlSubj}</p>
	              <p><b>진로 선택 과목:</b><br/>${major.careerSelec}</p>
	            </div>
	            
					            
	        <div class="content">
				  <p class="heading">직업정보</p>				
				  <p>
				    <b>1순위:</b><br>
				    <c:choose>
				      <c:when test="${not empty sessionScope.firstJobMap[major.majorIdx]}">
				        ${sessionScope.firstJobMap[major.majorIdx].jobName}
				        <small>(${sessionScope.firstJobMap[major.majorIdx].jobDesc})</small><br>
				        <span><b>연봉:</b> ${sessionScope.firstJobMap[major.majorIdx].jobSalary}</span>
				      </c:when>
				      <c:otherwise>정보없음</c:otherwise>
				    </c:choose>
				  </p>
				
				  <p>
				    <b>2순위:</b><br>
				    <c:choose>
				      <c:when test="${not empty sessionScope.secondJobMap[major.majorIdx]}">
				        ${sessionScope.secondJobMap[major.majorIdx].jobName}
				        <small>(${sessionScope.secondJobMap[major.majorIdx].jobDesc})</small><br>
				        <span><b>연봉:</b> ${sessionScope.secondJobMap[major.majorIdx].jobSalary}</span>
				      </c:when>
				      <c:otherwise>정보없음</c:otherwise>
				    </c:choose>
				  </p>
				
				  <p>
				    <b>3순위:</b><br>
				    <c:choose>
				      <c:when test="${not empty sessionScope.thirdJobMap[major.majorIdx]}">
				        ${sessionScope.thirdJobMap[major.majorIdx].jobName}
				        <small>(${sessionScope.thirdJobMap[major.majorIdx].jobDesc})</small><br>
				        <span><b>연봉:</b> ${sessionScope.thirdJobMap[major.majorIdx].jobSalary}</span>
				      </c:when>
				      <c:otherwise>정보없음</c:otherwise>
				    </c:choose>
				  </p>
				</div>
            
	          </div>
	        </div>
	      </c:forEach>
	    </c:when>
	    <c:otherwise>
	      <div class="card-container">
	        <div class="card">
	          <div class="img-content">
	            <p class="heading">추천 받은 전공이 없습니다.</p>
	          </div>
	        </div>
	      </div>
	    </c:otherwise>
	  </c:choose>
	</div>

<script type="text/javascript">
//클릭할 때 .active 클래스 토글
document.querySelectorAll('.card').forEach(card => {
  card.addEventListener('click', () => {
    card.classList.toggle('active');
  });
});

</script>
</body>
</html>