<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="java.util.Arrays" %>

<html>
<head>
    <title>전문가 프로필</title>
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            margin: 0;
            padding: 0;
            background: #f2f0f9;
        }
        .container {
            max-width: 1000px;
            margin: 0px auto;
            background: white;
            border-radius: 16px;
            box-shadow: 0 8px 30px rgba(0,0,0,0.08);
            padding: 0px 50px 70px;
            position: relative; /* 추가 가능 */
        }
        .profile-header {
            display: flex;
            gap: 30px;
            align-items: center;
            margin-bottom: 30px;
        }
        .profile-header img {
            width: 220px;
            height: 220px;
            object-fit: cover;
            border-radius: 16px;
        }
        .profile-info {
            flex: 1;
            margin-top: 20px;
	        padding: 20px;
	        font-family: 'Noto Sans KR', sans-serif;
	        font-size: 18px; /* 전체 기본 폰트 사이즈 업 */
	        line-height: 1.8; /* 줄 간격 늘림 */
	        color: #333;
	        border: 1px solid #ddd; /* 연한 회색 테두리 */
		    border-radius: 16px;
		    box-shadow: 0 0 6px rgba(0, 0, 0, 0.02); /* 부드러운 입체감 */
		    background-color: #f8f7fc;  
        }
        
         .profile-info p {
            margin-bottom: 20px; /* 항목 간 간격 늘림 */
            font-size: 20px;
    	}
    	
    	 .profile-info strong {
            font-weight: bold;
            margin-right: 10px; /* strong 태그 오른쪽 간격 */
            font-size: 21px;
    	} 
        .profile-info h2 {
            margin: 0;
            font-size: 28px;
            color: #4a1760;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .heart-btn {
            font-size: 28px;
            background: none;
            border: none;
            cursor: pointer;
            color: #aaa;
            transition: color 0.3s ease;
        }
        .heart-btn.liked {
            color: #e74c3c;
        }
        .profile-info p {
            font-size: 18px;
            color: #555;
            margin: 8px 0;
        }
        .section {
            margin-top: 50px;
        }
        .section h3 {
            font-size: 22px;
            color: #4a1760;
            border-bottom: 2px solid #ddd;
            padding-bottom: 10px;
            margin-bottom: 20px;
        }
        .section-content {
            font-size: 16px;
            color: #444;
            line-height: 1.7;
        }
        .availability-info {
            display: flex;
            gap: 50px;
            margin-top: 10px;
            min-height: 60px; /* 최소 높이 지정 */
            justify-content: space-between; /* 좌우 정렬 */
            align-items: center; /* 세로로 가운데 정렬 */
				
        }
        .availability-info div {
            flex: 1; /* 각 항목이 동일한 비율로 차지하도록 */
            text-align: center; /* 수평 중앙 정렬 */
            background: #f8f7fc;
            padding: 14px 20px;
            border-radius: 10px;
        }
        .timetable {
            margin-top: 30px;
            overflow-x: auto;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 14px;
        }
        th, td {
            padding: 12px;
            text-align: center;
            border: 1px solid #ddd;
        }
        th {
            background: #eee9f8;
            color: #4a1760;
        }
        .available {
            background-color: #d6ecff;
            font-weight: bold;
        }
        .reserve-btn {
            display: block;
            width: 280px;
            margin: 50px auto 0;
            background: #6a1b9a;
            color: white;
            font-size: 20px;
            padding: 16px;
            text-align: center;
            border-radius: 12px;
            text-decoration: none;
            font-weight: bold;
            transition: background 0.3s ease;
        }
        .reserve-btn:hover {
            background: #4a1760;
        }
        
        .available {
        background-color: #d6ecff;
        font-weight: bold;
        cursor: pointer; /* 마우스 커서 손모양 */
        transition: background 0.2s;
    }
    .available.selected {
        background-color: #8dc3ff; /* 선택된 경우 진한 파랑 */
    }
	.banner-bar {
	    background-color: #000;      /* 완전한 검정색 */
	    width: 100%;                 /* container 가로 꽉 채움 */
	    height: 60px;                /* 약간 더 굵게 */
	    display: flex;
	    align-items: center;
	    justify-content: flex-start; /* 왼쪽 정렬 */
	}

.banner-bar img {
    height: 40px; /* 로고 크게 보이게 */
    margin-left: 20px; /* 로고와 왼쪽 간격 */
}
    </style>
</head>
<body>

<div class="container">

<div class="banner-bar"
     style="margin-left: -50px; margin-right: -50px; width: calc(100% + 100px); padding: 0 50px; overflow-x: hidden; box-sizing: border-box;">
  <div style="display: flex; justify-content: space-between; align-items: center; width: 100%; overflow: hidden;">

    <!-- ✅ 1. 로고 왼쪽 여백 축소 (margin-left → 0) -->
    <!-- ✅ 2. 메뉴 보라색 더 진하게 (#6C03FF) -->
    <div style="display: flex; align-items: center; gap: 20px;">
      <a href="/">
        <img src="${pageContext.request.contextPath}/resources/assets/images/teachers/logo3.png" alt="로고" style="height: 32px; margin-left: 0;">
      </a>
      <a href="/trainer" style="color: #6C03FF; font-weight: 600; text-decoration: none;">전문가 찾기</a>
      <a href="/reviewlist" style="color: #6C03FF; font-weight: 600; text-decoration: none;">커뮤니티</a>
    </div>

    <!-- ✅ 3. 로그아웃 ↔ 마이페이지 간격을 32px로 여유 있게 조정 -->
    <div style="display: flex; align-items: center; gap: 10px;">
      <sec:authorize access="isAuthenticated()">
        <a href="/logout" style="color: #6C03FF; font-weight: 600; text-decoration: none;">로그아웃</a>
        	&nbsp;&nbsp;
        <a href="/mypage" style="color: #6C03FF; font-weight: 600; text-decoration: none;">마이페이지</a>
      </sec:authorize>
    </div>

  </div>
</div>




<br>
    <div class="profile-header">
       <!-- defalt 이미지 <img src="https://images.unsplash.com/photo-1607746882042-944635dfe10e?auto=format&fit=crop&w=250&q=80" alt="전문가 사진">-->
		<c:choose>
			<c:when test="${not empty trainerdetails.profileImg}">
				<img src="<c:url value='${trainerdetails.profileImg}'/>" alt="트레이너">
			</c:when>
			<c:otherwise>
			 	<img src="https://images.unsplash.com/photo-1607746882042-944635dfe10e?auto=format&fit=crop&w=250&q=80" alt="트레이너">
			</c:otherwise>
		</c:choose>
        
        <div class="profile-info">
            <h2>
                <button class="heart-btn" id="heartBtn">🤍</button>
            </h2>
            <p><strong>이름:</strong> <c:out value="${trainerdetails.name}" default="체형 교정 트레이너"/></p>
            <p><strong>전문 분야:</strong> <c:out value="${trainerdetails.speciality}" default="5년"/></p>
            <p><strong>경력:</strong> <c:out value="${trainerdetails.experience}" default="PT, 체형 교정"/></p>
        </div>
    </div>

    <div class="section">
        <h3>자기소개</h3>
        <div class="section-content">
            <c:out value="${trainerdetails.content}" default="안녕하세요! 5년 경력의 체형 교정 전문가 홍길동입니다.건강하고 아름다운 몸을 만들어드립니다!"/>
        </div>
    </div>

    <div class="section">
        <h3>가능 지역 & 가능 시간대</h3>
        <div class="availability-info">
            <div>
                <strong>가능 지역</strong><br/><br>
                <c:out value="${trainerdetails.district} 전지역 가능, ${trainerdetails.town} 근처 좋아요! " default="서울 전지역, 경기 일부"/>
            </div>
            <div>
                <strong>가능 시간대</strong><br/><br>
				<c:out value="[요일] : ${trainerdetails.daysAvailable} ｜  [시간] : ${trainerdetails.timeSlot}시" default="월~금 오전 10시 ~ 오후 6시"/>
            </div>
        </div>
        
        <div style="font-size: 18px; font-weight: bold; color: #4a1760; text-align: center; margin: 30px 0 10px;">
    	아래 시간대에 수업이 가능합니다.<br/>
   		회원님께서 정기적으로 수업이 가능한 시간대를 선택하여 예약해주세요.
		</div>

        <!-- 해당 요일, 시간대 바둑판으로 표시 -->
        <div class="timetable">
            <table>
                <thead>
                <tr>
                    <th>시간대</th>
                    <th>월</th>
                    <th>화</th>
                    <th>수</th>
                    <th>목</th>
                    <th>금</th>
                    <th>토</th>
                    <th>일</th>
                </tr>
                </thead>
                
	                <!-- dayMapping을 안전하게 List로 구성 -->
					<c:set var="dayMapping" value="${empty dayMapping ? null : dayMapping}" />
					<c:if test="${dayMapping == null}">
					    <c:set var="dayMapping" value="${fn:split('Mon,Tue,Wed,Thu,Fri,Sat,Sun', ',')}" />
					</c:if>
					
					<!-- timeSlots와 daysAvailable split -->
					<c:set var="splitTimeSlots" value="${fn:split(timeSlots, ',')}" />
					<c:set var="splitDays" value="${fn:split(daysAvailable, ',')}" />


				 <tbody>
				    <c:forEach var="hour" begin="6" end="21">
				        <tr>
				            <td>${hour}:00~${hour+1}:00</td>
				            <c:set var="hourStr" value="${hour}" />
				            <c:forEach var="day" items="${dayMapping}">
				                <!-- 정확히 시간과 요일이 모두 일치하는지 확인 -->
				                <c:set var="timeMatch" value="false" />
				                <c:forEach var="t" items="${splitTimeSlots}">
				                    <c:if test="${t == hourStr}">
				                        <c:set var="timeMatch" value="true" />
				                    </c:if>
				                </c:forEach>
				
				                <c:set var="dayMatch" value="false" />
				                <c:forEach var="d" items="${splitDays}">
				                    <c:if test="${d == day}">
				                        <c:set var="dayMatch" value="true" />
				                    </c:if>
				                </c:forEach>
								
								<!-- daysAvailable와 timeSlots가 모두 해당할 때 ✔ 표시 -->
				                <td class="${timeMatch and dayMatch ? 'available' : ''}">
				                    <c:choose>
				                        <c:when test="${timeMatch and dayMatch}">
				                            ✔
				                        </c:when>
				                        <c:otherwise>
				                            &nbsp;
				                        </c:otherwise>
				                    </c:choose>
				                </td>
				            </c:forEach>
				        </tr>
				    </c:forEach>
				</tbody>
  
            </table>
        </div>
    </div>

    <div class="section">
        <h3>리뷰 이벤트</h3>
        <div class="section-content">
            첫 상담 후 리뷰 작성 시 <strong>10% 할인</strong> 이벤트 진행 중입니다!  
            지금 예약하고 혜택 받으세요 🎉
        </div>
    </div>

    <!-- 예약 및 결제 버튼 -->
    <a href="payment" class="reserve-btn">예약하기</a>
</div>

<script>
    const heartBtn = document.getElementById("heartBtn");
    let liked = false;

    heartBtn.addEventListener("click", () => {
        liked = !liked;
        heartBtn.innerText = liked ? "❤️" : "🤍";
        heartBtn.classList.toggle("liked", liked);
    });
</script>

<script>
    // 시간대 클릭 처리
    document.addEventListener("DOMContentLoaded", function () {
        const availableCells = document.querySelectorAll("td.available");

        availableCells.forEach(cell => {
            cell.addEventListener("click", () => {
                cell.classList.toggle("selected");
            });
        });
    });
</script>

</body>
</html>
