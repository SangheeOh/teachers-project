<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>간단 결제</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
    <script src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
    <style>
        :root {
            --primary: #7b4bff;
            --hover: #5e36d7;
            --bg: #f4f2fa;
            --white: #fff;
            --radius: 12px;
            --shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background: var(--bg);
            padding: 60px 20px;
        }
        .container {
            max-width: 500px;
            margin: auto;
            background: var(--white);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            padding: 40px;
        }
        h2 {
            color: var(--primary);
            text-align: center;
            margin-bottom: 30px;
        }
        .price {
            text-align: center;
            font-size: 24px;
            color: var(--primary);
            margin-bottom: 20px;
        }
        .pay-btn {
            width: 100%;
            padding: 16px;
            background: var(--primary);
            color: var(--white);
            font-weight: bold;
            border: none;
            border-radius: var(--radius);
            cursor: pointer;
        }
        .pay-btn:hover {
            background: var(--hover);
        }
    </style>
</head>
<body>
<div class="container">
    <h2>간단 결제</h2>
    <div class="price">결제 금액: <span id="amount">1</span>원</div>
    <button class="pay-btn" onclick="requestPay()">결제하기</button>
</div>

<script>
    const IMP = window.IMP;
    IMP.init("imp22848043"); // 아임포트 식별코드

    function requestPay() {
        const amount = document.getElementById("amount").innerText;
        const merchantUid = "order_" + new Date().getTime();

        IMP.request_pay({
            pg: "html5_inicis.INIpayTest",
            pay_method: "card",
            merchant_uid: merchantUid,
            name: "간단 결제",
            amount: amount,
            buyer_email: "test@example.com",
            buyer_name: "김길동"
        }, async function (rsp) {
            if (rsp.success) {
                // 백엔드에 imp_uid, merchant_uid 보내서 검증
                const response = await fetch("/payment/verify", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/x-www-form-urlencoded"
                    },
                    body: new URLSearchParams({
                        impUid: rsp.imp_uid,
                        merchantUid: rsp.merchant_uid,
                        reservationNo: 3 // ← 여기 추가!
                    })
                });
                const result = await response.text();
                window.location.href = result.includes("success") ? "/payment/success" : "/payment/fail";
            } else {
                alert("결제 실패: " + rsp.error_msg);
                window.location.href = "/payment/fail";
            }
        });
    }
</script>
</body>
</html>
