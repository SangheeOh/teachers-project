<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>예약 및 결제</title>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">

    <!-- ✅ Iamport 결제 SDK -->
    <script src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>

    <style>
        :root {
            --primary-color: #7b4bff;
            --primary-hover: #5e36d7;
            --background: #f4f2fa;
            --white: #ffffff;
            --text-color: #333;
            --border-radius: 12px;
            --box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Noto Sans KR', sans-serif;
            background: var(--background);
            padding: 60px 20px;
        }

        .container {
            max-width: 700px;
            margin: auto;
            background: var(--white);
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            padding: 40px;
            animation: fadeIn 0.6s ease;
        }

        h2 {
            color: var(--primary-color);
            font-size: 28px;
            text-align: center;
            margin-bottom: 40px;
        }

        .form-group {
            margin-bottom: 30px;
        }

        label {
            display: block;
            font-weight: 500;
            margin-bottom: 10px;
            color: var(--text-color);
        }

        select, input[type="number"] {
            width: 100%;
            padding: 14px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: var(--border-radius);
            transition: border 0.2s ease;
        }

        select:focus, input[type="number"]:focus {
            border-color: var(--primary-color);
            outline: none;
        }

        .price-box {
            text-align: center;
            background: #f8f5ff;
            border: 2px dashed var(--primary-color);
            color: var(--primary-color);
            font-weight: bold;
            font-size: 26px;
            border-radius: var(--border-radius);
            padding: 20px;
            margin: 40px 0;
        }

        .pay-btn {
            display: block;
            width: 100%;
            padding: 18px;
            font-size: 18px;
            background: var(--primary-color);
            color: var(--white);
            font-weight: bold;
            border: none;
            border-radius: var(--border-radius);
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .pay-btn:hover {
            background: var(--primary-hover);
        }

        @keyframes fadeIn {
            from {opacity: 0; transform: translateY(20px);}
            to {opacity: 1; transform: translateY(0);}
        }
    </style>
</head>
<body>
<div class="container">
    <h2>예약 및 결제</h2>

    <div class="form-group">
        <label for="program">프로그램 선택</label>
        <select id="program" onchange="updatePrice()">
            <option value="basic">기본 프로그램 (1원)</option>
            <option value="premium">프리미엄 프로그램 (2원)</option>
            <option value="vip">VIP 프로그램 (3원)</option>
        </select>
    </div>

    <div class="form-group">
        <label for="people">인원 수</label>
        <input type="number" id="people" value="1" min="1" onchange="updatePrice()">
    </div>

    <div class="price-box">
        총 결제 금액: <span id="totalPrice">1원</span>
    </div>

    <button type="button" class="pay-btn" onclick="requestPay();">결제하기</button>
</div>

<script>
    const IMP = window.IMP;
    IMP.init("imp22848043"); // 🔑 본인 아임포트 식별코드로 교체

    function updatePrice() {
        const program = document.getElementById("program").value;
        const count = parseInt(document.getElementById("people").value);
        let price = 0;

        switch (program) {
            case "basic": price = 1; break;
            case "premium": price = 2; break;
            case "vip": price = 3; break;
        }

        const total = price * count;
        document.getElementById("totalPrice").innerText = total.toLocaleString() + "원";
    }

    async function requestPay() {
        const priceText = document.getElementById("totalPrice").innerText;
        const amount = parseInt(priceText.replace(/[^\d]/g, ''));
        const program = document.getElementById("program").value;
        const count = document.getElementById("people").value;
        const merchantUid = "order_" + new Date().getTime();

        IMP.request_pay({
            pg: "html5_inicis.INIpayTest",
            pay_method: "card",
            merchant_uid: merchantUid,
            name: program + " (" + count + "명)",
            amount: amount,
            buyer_name: "김길동", // 필요 시 세션에서 사용자 정보 받아오기
            buyer_email: "test@example.com"
        }, async function (rsp) {
            if (rsp.success) {
                const response = await fetch("/payment/verify", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/x-www-form-urlencoded"
                    },
                    body: new URLSearchParams({
                        impUid: rsp.imp_uid,
                        merchantUid: rsp.merchant_uid,
                        reservationNo: 3 // 💡 실제 예약 번호로 교체!
                    })
                });

            const result = await response.text();
                //window.location.href = result.includes("success") ? "/su" : "/fa";
                window.location.href = "/su";
            } else {
                alert("결제 실패: " + rsp.error_msg);
                window.location.href = "/fa";
            }
        });
    }
</script>
</body>
</html>
