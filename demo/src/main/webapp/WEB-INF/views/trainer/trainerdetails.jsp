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
            max-width: 960px;
            margin: 50px auto;
            background: white;
            border-radius: 16px;
            box-shadow: 0 8px 30px rgba(0,0,0,0.08);
            padding: 40px 50px 70px;
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
        }
        
         .profile-info p {
            margin-bottom: 16px; /* 항목 간 간격 늘림 */
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
            font-size: 16px;
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
    </style>
</head>
<body>
<div class="container">
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
				<c:out value="[요일] : ${trainerdetails.daysAvailable} -----  [시간] : ${trainerdetails.timeSlot}시" default="월~금 오전 10시 ~ 오후 6시"/>
            </div>
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

</body>
</html>
