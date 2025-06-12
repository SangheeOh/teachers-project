<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
  <title>관리자 대시보드</title>
  <style>
    * {
      box-sizing: border-box;
    }

    html, body {
      margin: 0;
      padding: 0;
      font-family: 'Noto Sans KR', sans-serif;
      background-color: #f9f9fb;
      height: 100vh;
    }

    .wrapper {
      display: flex;
      height: 100vh;
    }

    /* Sidebar */
    .sidebar {
      width: 240px;
      background-color: #4a3d8f;
      padding: 40px 20px 20px 20px;
      color: white;
      box-sizing: border-box;
      text-align: center;
    }

    .sidebar .welcome {
      font-size: 14px;
      font-weight: bold;
      padding: 15px 10px;
      border-bottom: 1px solid #b9aaf0;
      margin-bottom: 30px;
      background-color: rgba(255, 255, 255, 0.1);
      border-radius: 8px;
    }

    .sidebar h2 {
      font-size: 20px;
      margin-bottom: 20px;
    }

    .sidebar ul {
      list-style: none;
      padding: 0;
      margin: 0;
    }

    .sidebar li {
      margin: 10px 0;
    }

    .sidebar a {
      color: white;
      text-decoration: none;
      padding: 10px 15px;
      display: inline-block;
      border-radius: 6px;
      transition: background 0.2s;
    }

    .sidebar a:hover {
      background-color: #6b5ec5;
    }

    /* Main content */
    .main {
      flex-grow: 1;
      padding: 40px 50px 50px 50px;
      overflow-y: auto;
    }

    .main h1 {
      font-size: 28px;
      margin-top: 0;
      margin-bottom: 30px;
      color: #4a3d8f;
    }

    .dashboard-cards {
      display: flex;
      gap: 20px;
      margin-bottom: 30px;
      flex-wrap: wrap;
    }

    .card {
      flex: 1;
      padding: 25px;
      background-color: white;
      border-radius: 12px;
      box-shadow: 0 0 8px rgba(0, 0, 0, 0.05);
      min-width: 220px;
      display: flex;
      align-items: center;
      gap: 15px;
      border: 6px solid #d8f2ea; /* ✅ 좀 더 보이는 하늘색 */
    }

    .card .icon-box {
      width: 50px;
      height: 50px;
      background-color: #e0e0e0;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 28px;
      color: #555;
    }

    .card .info {
      text-align: left;
    }

    .card .info h3 {
      font-size: 18px;
      color: #999;
      margin: 0 0 5px 0;
    }

    .card .info p {
      font-size: 26px;
      color: #4a3d8f;
      font-weight: bold;
      margin: 0;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 20px;
    }

    table th, table td {
      border: 1px solid #ddd;
      padding: 10px;
      text-align: center;
    }

    table th {
      background-color: #e4dcf6;
      color: #333;
    }

    .btn-purple {
      background-color: #7d5bbe;
      color: #fff;
      padding: 10px 16px;
      border: none;
      border-radius: 6px;
      cursor: pointer;
    }

    .btn-purple:hover {
      background-color: #6c4aba;
    }

    .btn-cancel {
      background-color: #f06262;
      color: white;
      padding: 6px 12px;
      border: none;
      border-radius: 20px;
      cursor: pointer;
      font-size: 13px;
    }

    .btn-cancel:hover {
      background-color: #dc4c4c;
    }

  </style>
</head>
<body>

<div class="wrapper">
  <!-- Sidebar -->
  <div class="sidebar">
    <div class="welcome">${sessionScope.name}님, 환영합니다! 😊</div>
    <h2>관리자 메뉴</h2>
    <ul>
      <li><a href="/admin/users">회원 관리</a></li>
      <li><a href="/admin/reservations">예약/결제 현황</a></li>
      <li><a href="/admin/trainers">강사 승인/거절처리</a></li>
      <li><a href="/admin/profile">관리자 정보수정</a></li>
    </ul>
  </div>

  <!-- Main content -->
  <div class="main">
    <h1>TODAY</h1>

    <!-- Dashboard cards -->
    <div class="dashboard-cards">
      <div class="card">
        <div class="icon-box">👥</div>
        <div class="info">
          <h3>총 회원 수</h3>
          <p>${totalUserCount}명</p>
        </div>
      </div>
      <div class="card">
        <div class="icon-box">🎓</div>
        <div class="info">
          <h3>강사 인원</h3>
          <p>${todayUserCount}명</p>
        </div>
      </div>
      <div class="card">
        <div class="icon-box">📅</div>
        <div class="info">
          <h3>금일 예약 건수</h3>
          <p>3건</p>
        </div>
      </div>
      <div class="card">
        <div class="icon-box">💳</div>
        <div class="info">
          <h3>취소요청</h3>
          <p>1건</p>
        </div>
      </div>
    </div>

    <!-- 예약/결제 테이블 -->
  <h3 style="margin-top:40px;">예약·결제 현황</h3>
<table>
  <thead>
    <tr>
      <th>회원</th>
      <th>강사</th>
      <th>분야</th>
      <th>지역</th>
      <th>요일</th>
      <th>시간</th>
      <th>결제금액</th>
      <th>결제수단</th>
      <th>결제일시</th>
      <th>상태</th>
      <th>취소</th>
    </tr>
  </thead>
  <tbody>
    <c:forEach var="item" items="${adminReport}">
      <tr>
        <td>${item.userName}</td>
        <td>${item.trainerName}</td>
        <td>${item.speciality}</td>
        <td>${item.region}</td>
        <td>${item.day}</td>
        <td>${item.time}시</td>
        <td>${item.amount}</td>
        <td>${item.method}</td>
        <td>${item.paymentDate}</td>
        <td>${item.reservationStatus}</td>
        <td>
          <form action="/admin/cancelReservation" method="post">
            <input type="hidden" name="reservationNo" value="${item.reservationNo}" />
            <button type="submit" class="btn-cancel">취소</button>
          </form>
        </td>
      </tr>
    </c:forEach>
  </tbody>
</table>

    <!-- 엑셀 다운로드 -->
    <form action="/admin/downloadExcel" method="get" style="margin-top:20px;">
      <button class="btn-purple" type="submit">엑셀 다운로드</button>
    </form>
  </div>
</div>

</body>
</html>
