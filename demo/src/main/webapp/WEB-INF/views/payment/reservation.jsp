<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>예약 완료</title>
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f4f0fb;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 800px;
            margin: 80px auto;
            background-color: #fff;
            border: 2px solid #c9b3ef;
            border-radius: 18px;
            padding: 50px 40px;
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.07);
            text-align: center;
        }

        .emoji {
            font-size: 48px;
            margin-bottom: 20px;
        }

        .title {
            font-size: 2.2rem;
            font-weight: 700;
            color: #6a0dad;
            margin-bottom: 40px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
            margin-bottom: 40px;
        }

        th, td {
            border: 1px solid #decdfb;
            padding: 16px;
            font-size: 1rem;
        }

        th {
            background-color: #ebdcff;
            color: #4b0082;
        }

        td {
            background-color: #faf7ff;
            color: #333;
        }

        .trainer-photo {
            width: 120px;
            height: 120px;
            object-fit: cover;
            border-radius: 10px;
            border: 2px solid #c7b0f5;
        }

        .pay-button {
            background-color: #ff6f91;
            color: white;
            padding: 14px 36px;
            font-size: 1.1rem;
            font-weight: bold;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .pay-button:hover {
            background-color: #e05276;
        }

        @media screen and (max-width: 768px) {
            .container {
                width: 90%;
                padding: 30px;
            }

            table, th, td {
                font-size: 0.9rem;
            }

            .pay-button {
                width: 100%;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="emoji">🎉</div>
    <div class="title">예약이 완료되었습니다</div>

    <table>
        <tr>
            <th>전문가 이름</th>
            <th>운동 분야</th>
            <th>성별</th>
            <th>원하는 지역</th>
            <th>원하는 시간대</th>
            <th>강사 사진</th>
        </tr>
        <tr>
            <td>${trainer.name}</td>
            <td>${trainer.field}</td>
            <td>${trainer.gender}</td>
            <td>${trainer.region}</td>
            <td>${reservation.timeSlot}</td>
            <td>
                <img src="${trainer.imageUrl}" alt="강사 사진" class="trainer-photo" />
            </td>
        </tr>
    </table>

    <form action="/payment/start" method="post">
        <input type="hidden" name="reservationId" value="${reservation.id}" />
        <button type="submit" class="pay-button">💳 결제하기</button>
    </form>
</div>
</body>
</html>
