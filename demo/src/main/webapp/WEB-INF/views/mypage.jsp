<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="/resources/css/common/general.css">

<div class="container">
  <h2>마이페이지</h2>

  <div class="section">
    <h3>내 정보 수정</h3>
    <form action="/updateProfile" method="post">
      <!-- 예시 폼 -->
      <label for="name">이름:</label>
      <input type="text" id="name" name="name" value="${sessionScope.name}" />
      <button class="btn-purple" type="submit">수정하기</button>
    </form>
  </div>

  <div class="section">
    <h3>예약 확인 및 취소</h3>
    <table>
      <thead>
        <tr><th>날짜</th><th>시간</th><th>강사</th><th>상태</th><th>조치</th></tr>
      </thead>
      <tbody>
        <!-- 예약 리스트 반복 출력 예시 -->
        <c:forEach var="res" items="${reservationList}">
          <tr>
            <td>${res.date}</td>
            <td>${res.time}</td>
            <td>${res.trainerName}</td>
            <td>${res.status}</td>
            <td>
              <form action="/cancelReservation" method="post">
                <input type="hidden" name="resId" value="${res.id}" />
                <button class="btn-purple" type="submit">취소</button>
              </form>
            </td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </div>

  <div class="section">
    <h3>결제 확인 및 취소</h3>
    <!-- 결제 관련 정보 출력 -->
  </div>
</div>
