<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <title>예약 완료</title>
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f2f0f9;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 600px;
            margin: 100px auto;
            background-color: #ffffff;
            padding: 60px 40px;
            border-radius: 20px;
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .emoji {
            font-size: 50px;
            margin-bottom: 20px;
        }

        .title {
            font-size: 26px;
            font-weight: bold;
            color: #6C03FF;
            margin-bottom: 20px;
        }

        .description {
            font-size: 18px;
            color: #444;
            margin-bottom: 40px;
        }

        .pay-button {
            background-color: #6C03FF;
            color: white;
            padding: 16px 36px;
            font-size: 18px;
            font-weight: bold;
            border: none;
            border-radius: 12px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .pay-button:hover {
            background-color: #4a1760;
        }

        @media screen and (max-width: 768px) {
            .container {
                width: 90%;
                padding: 40px 20px;
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
    <div class="description">이제 결제를 진행해 주세요!</div>

    <form action="/payment/reserveno" method="get">
        <input type="hidden" name="reservationNo" value="${reservationNo}" />
        <button type="submit" class="pay-button">💳 결제하기</button>
    </form>
</div>

<script>
    console.log("[JSP] 예약번호(hidden):", document.getElementById("reservationNo").value);
</script>

</body>
</html>
