<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
  <title>마이페이지</title>
  <style>
    * { box-sizing: border-box; }
    html, body {
      margin: 0;
      padding: 0;
      font-family: 'Noto Sans KR', sans-serif;
      background-color: #f9f9fb;
      height: 100vh;
    }
    .wrapper { display: flex; height: 100vh; }

    .sidebar {
      width: 240px;
      background-color: #4a3d8f;
      padding: 40px 20px;
      color: white;
      text-align: center;
    }

    .sidebar .welcome {
      font-size: 17px;
      font-weight: bold;
      padding: 15px 10px;
      border-bottom: 1px solid #b9aaf0;
      margin-bottom: 30px;
      background-color: rgba(255, 255, 255, 0.1);
      border-radius: 8px;
    }

    .sidebar .profile-icon {
      width: 100px;
      height: 100px;
      border-radius: 50%;
      background-color: #a9a9b8;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 48px;
      margin: 0 auto 10px;
    }

    .sidebar .role-label {
      font-size: 14px;
      color: #e0d5ff;
      margin-bottom: 20px;
    }

    .sidebar ul {
      list-style: none;
      padding: 0;
      margin: 0;
    }

    .sidebar li { margin: 10px 0; }

    .sidebar a {
      color: white;
      text-decoration: none;
      padding: 10px 15px;
      display: inline-block;
      border-radius: 6px;
      transition: background 0.2s;
    }

    .sidebar a:hover { background-color: #6b5ec5; }

    .main {
      flex-grow: 1;
      padding: 40px 50px;
      overflow-y: auto;
    }

    .main h1 {
      font-size: 28px;
      color: #4a3d8f;
      margin-bottom: 30px;
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
    <div class="profile-icon">👤</div>
    <div class="role-label">일반회원</div>
    <div class="welcome">${sessionScope.name}님, 환영합니다! 😊</div>

    <ul>
      <li><a href="/mypage/edit">회원정보수정</a></li>
      <li><a href="/mypage/reservations">예약/결제 내역</a></li>
      <li><a href="/mypage/favorites">찜한 강사</a></li>
      <li><a href="/mypage/reviews">리뷰</a></li>
    </ul>
  </div>

  <!-- Main Content -->
  <div class="main">
    <h1>최근 예약/결제 내역</h1>

    <table>
      <thead>
        <tr>
          <th>강사</th>
          <th>분야</th>
          <th>지역</th>
          <th>요일</th>
          <th>시간</th>
          <th>결제금액</th>
          <th>결제수단</th>
          <th>결제일시</th>
          <th>상태</th>
          <th>취소요청</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="item" items="${mypageReport}">
          <tr>
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
	         	<form action="/mypage/cancelRequest" method="post">
	            <input type="hidden" name="reservationNo" value="${item.reservationNo}" />
	            <button type="submit" class="btn-cancel">취소요청</button>
	          	</form>
        	</td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </div>
</div>

</body>
</html>
