<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="/resources/css/common/general.css">

<div class="container">
  <h2>관리자 대시보드</h2>

  <div class="section">
    <h3>예약·결제 현황</h3>
    <table>
      <thead>
        <tr><th>회원</th><th>강사</th><th>날짜</th><th>결제금액</th><th>상태</th></tr>
      </thead>
      <tbody>
        <c:forEach var="item" items="${adminReservationList}">
          <tr>
            <td>${item.userName}</td>
            <td>${item.trainerName}</td>
            <td>${item.date}</td>
            <td>${item.amount}</td>
            <td>${item.status}</td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </div>

  <div class="section">
    <h3>회원가입자수 현황</h3>
    <p>총 회원 수: ${totalUserCount}</p>
    <p>오늘 가입자 수: ${todayUserCount}</p>
  </div>

  <div class="section">
    <h3>엑셀 다운로드</h3>
    <form action="/admin/downloadExcel" method="get">
      <button class="btn-purple" type="submit">엑셀 다운로드</button>
    </form>
  </div>
</div>
