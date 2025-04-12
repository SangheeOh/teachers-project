<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>운동 전문가 찾기</title>
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #fff;
            margin: 0;
            padding: 0;
            text-align: center;
        }

        .container {
            max-width: 1100px;
            margin: 0 auto;
            padding: 40px 20px;
        }

        .filter {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            justify-content: center;
            margin-bottom: 20px;
        }

        .filter select,
        .filter input[type="text"] {
            padding: 10px 15px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 16px;
            flex: 1 1 180px;
            background-color: #f5f5f5; /* 흐릿한 회색 배경 */
        }

        .search-btn {
            padding: 14px 24px;
            font-size: 16px;
            background-color: #7A5FFF;
            color: #fff;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            width: 400px;
            margin-top: 15px;
        }

        .search-btn:hover {
            background-color: #634de3;
        }

        .title {
            font-size: 22px;
            font-weight: bold;
            margin: 40px 0 10px;
        }

        .subtitle {
            color: #666;
            font-size: 14px;
            margin-bottom: 30px;
        }

        .experts {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 30px;
            justify-items: center;
            margin-top: 30px;
        }

        .expert-card {
            width: 100%;
            max-width: 500px;
            background-color: #f9f9f9;
            border-radius: 16px;
            padding: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            text-align: left;
        }

        .expert-card img {
            width: 100%;
            height: 300px;
            object-fit: cover;
            border-radius: 10px;
            margin-bottom: 15px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            cursor: pointer;
        }

        .expert-card img:hover {
            transform: scale(1.02);
            box-shadow: 0 0 12px rgba(123, 97, 255, 0.4);
        }

        .badge {
            background-color: #7A5FFF;
            color: white;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
            margin-bottom: 8px;
            display: inline-block;
        }

        .expert-title {
            font-weight: bold;
            margin-bottom: 10px;
            font-size: 17px;
        }

        .tags {
            color: #888;
            font-size: 13px;
        }

        @media (max-width: 768px) {
            .experts {
                grid-template-columns: 1fr;
            }
        }
        
        input[readonly] {
  			background-color: #fff !important; /* 회색 말고 흰색 */
  			cursor: pointer; /* 클릭 가능하게 보이도록 */
		}
        
    </style>
    

    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    
    <script>
        function execDaumPostcode() {
            new daum.Postcode({
                oncomplete: function(data) {
                    const city = data.sido;
                    const district = data.sigungu;
                    const town = data.bname;

                    const fullAddr = city + ' ' + district + ' ' + town;
                    document.getElementById("regionDisplay").value = fullAddr;
                    document.getElementById("regionHidden").value = fullAddr;

                    document.getElementById("city").value = city;
                    document.getElementById("district").value = district;
                    document.getElementById("town").value = town;
                }
            }).open();
        }
    </script>
    
    <style>
    select,
    input[type="text"][readonly],
    input[readonly] {
        background-color: #f0f0f0 !important;
    }
	</style>
    
</head>
<body>
<div class="container">
    <h2>운동 전문가 찾기</h2>

    <!-- 🔍 필터 -->
    <form action="${pageContext.request.contextPath}/search" method="GET">
        <div class="filter">
           
             <!-- ✅ 지역 표시 input: 검색 후 값 유지되게 수정 -->
            <input type="text" id="regionDisplay" placeholder="지역 선택"
                   readonly onclick="execDaumPostcode()"
                   value="${param.region}" style="cursor:pointer;">

            <!-- ✅ 실제 검색용 지역 값 -->
            <input type="hidden" id="regionHidden" name="region" value="${param.region}">
            <input type="hidden" id="city" name="city" value="${param.city}">
            <input type="hidden" id="district" name="district" value="${param.district}">
            <input type="hidden" id="town" name="town" value="${param.town}">

            <!-- 종목 -->
			<select name="speciality">
			  <option value="">-- 종목선택 --</option>
			  <option value="헬스" ${param.speciality == '헬스' ? 'selected' : ''}>헬스</option>
			  <option value="요가" ${param.speciality == '요가' ? 'selected' : ''}>요가</option>
			  <option value="필라테스" ${param.speciality == '필라테스' ? 'selected' : ''}>필라테스</option>
			  <option value="크로스핏" ${param.speciality == '크로스핏' ? 'selected' : ''}>크로스핏</option>
			</select>

            <!-- 성별 -->
            <select name="gender">
              <option value="">-- 성별선택 --</option>
			  <option value="무관" ${param.gender == '무관' ? 'selected' : ''}>무관</option>
			  <option value="여성" ${param.gender == '여성' ? 'selected' : ''}>여성</option>
			  <option value="남성" ${param.gender == '남성' ? 'selected' : ''}>남성</option>
            </select>

            <!-- 시간대 -->
            <select name="time">
              <option value="">-- 시간대 선택 --</option>
			  <option value="무관" ${param.time == '무관' ? 'selected' : ''}>무관</option>
			  <option value="오전" ${param.time == '오전' ? 'selected' : ''}>오전</option>
			  <option value="오후" ${param.time == '오후' ? 'selected' : ''}>오후</option>
            </select>
			            
            
        </div>

        <button type="submit" class="search-btn">검색하기</button>
    </form>

    <div class="title">나만의 전문가를 찾아볼까요?</div>
    <div class="subtitle">지금 가장 인기있는 전문가의 상세 정보와 후기를 확인해보세요.</div>

    <!-- 결과 -->
    <c:choose>
        <c:when test="${not empty trainers}">
            <div class="experts">
                <c:forEach var="trainer" items="${trainers}" varStatus="status">
                    <c:if test="${status.index < 6}">
                        <div class="expert-card">
                            <c:choose>
							  <c:when test="${not empty trainer.profileImg}">
							    <img src="<c:url value='${trainer.profileImg}'/>" alt="트레이너">
							  </c:when>
							  <c:otherwise>
							    <img src="<c:url value='/images/default-trainer.png'/>" alt="트레이너">
							  </c:otherwise>
							</c:choose>
                            
                            <span class="badge">${trainer.speciality}</span>
                            <div class="expert-title">${trainer.subject}</div>
                            <div class="tags">${trainer.gender} · ${trainer.town} · ${trainer.content}</div>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </c:when>
    
            <c:otherwise>
		    <div class="experts" style="display: grid;">
		        	<div class="expert-card">
                <span class="badge">최우수</span>
                <a href="profile.jsp?trainerId=1">
                    <img src="https://images.pexels.com/photos/8411309/pexels-photo-8411309.jpeg" alt="강사1">
                </a>
                <div class="expert-title">클래식 요가, 아쉬탕가 요가 프로그램</div>
                <div class="tags">#요가 #체형교정 #생활통증 완화</div>
            </div>
            <div class="expert-card">
                <span class="badge">우수</span>
                <a href="profile.jsp?trainerId=2">
                    <img src="https://images.pexels.com/photos/3763879/pexels-photo-3763879.jpeg" alt="강사2">
                </a>
                <div class="expert-title">체력 끌어올리는 근력 강화 웨이트</div>
                <div class="tags">#웨이트 #체력강화 #다이어트</div>
            </div>
            <div class="expert-card">
                <span class="badge">추천</span>
                <a href="profile.jsp?trainerId=3">
                    <img src="https://images.pexels.com/photos/1954524/pexels-photo-1954524.jpeg" alt="강사3">
                </a>
                <div class="expert-title">밸런스를 잡아주는 필라테스</div>
                <div class="tags">#필라테스 #체형교정 #건강유지</div>
            </div>
            <div class="expert-card">
                <span class="badge">추천</span>
                <a href="profile.jsp?trainerId=4">
                    <img src="https://images.pexels.com/photos/8978177/pexels-photo-8978177.jpeg" alt="강사4">
                </a>
                <div class="expert-title">다이어트 맞춤형 PT 프로그램</div>
                <div class="tags">#PT #식단관리 #다이어트</div>
            </div>
            <div class="expert-card">
                <span class="badge">우수</span>
                <a href="profile.jsp?trainerId=5">
                    <img src="https://images.pexels.com/photos/7671947/pexels-photo-7671947.jpeg" alt="강사5">
                </a>
                <div class="expert-title">산후 회복 필라테스</div>
                <div class="tags">#산모운동 #필라테스 #회복</div>
            </div>
            <div class="expert-card">
                <span class="badge">추천</span>
                <a href="profile.jsp?trainerId=6">
                    <img src="https://images.pexels.com/photos/3768914/pexels-photo-3768914.jpeg" alt="강사6">
                </a>
                <div class="expert-title">남성을 위한 코어 강화 프로그램</div>
                <div class="tags">#맨즈PT #코어강화 #체력증진</div>
            </div>
		    </div>
		</c:otherwise>

    </c:choose>
</div>
</body>
</html>

    