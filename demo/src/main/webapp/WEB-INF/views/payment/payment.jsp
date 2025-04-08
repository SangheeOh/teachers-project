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
            <option value="basic">기본 프로그램 (50,000원)</option>
            <option value="premium">프리미엄 프로그램 (90,000원)</option>
            <option value="vip">VIP 프로그램 (130,000원)</option>
        </select>
    </div>

    <div class="form-group">
        <label for="people">인원 수</label>
        <input type="number" id="people" value="1" min="1" onchange="updatePrice()">
    </div>

    <div class="price-box">
        총 결제 금액: <span id="totalPrice">50,000원</span>
    </div>

    <button type="button" class="pay-btn" onclick="requestIamportPayment();">결제하기</button>
</div>

<script>
    const IMP = window.IMP;
    IMP.init("imp22848043"); // 🔑 본인 아임포트 식별코드로 교체

    function updatePrice() {
        const program = document.getElementById("program").value;
        const count = parseInt(document.getElementById("people").value);
        let price = 0;

        switch (program) {
            case "basic": price = 50000; break;
            case "premium": price = 90000; break;
            case "vip": price = 130000; break;
        }

        const total = price * count;
        document.getElementById("totalPrice").innerText = total.toLocaleString() + "원";
    }

    function requestIamportPayment() {
        const amount = parseInt(document.getElementById("totalPrice").innerText.replace(/[^\d]/g, ''));
        const program = document.getElementById("program").value;
        const count = document.getElementById("people").value;
        const merchant_uid = "order_" + new Date().getTime(); // 고유 주문번호
        const buyer_name = "홍길동"; // TODO: 세션에서 로그인 사용자 정보로 변경

        IMP.request_pay({
            pg: "html5_inicis.INIpayTest",
            pay_method: "card",
            merchant_uid: merchant_uid,
            name: program + " (" + count + "명)",
            amount: amount,
            buyer_name: buyer_name,
            buyer_tel: "01012345678",
            buyer_email: "hong@example.com",
        }, function (rsp) {
            if (rsp.success) {
                fetch("/payment/verify", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json"
                    },
                    body: JSON.stringify({
                        imp_uid: rsp.imp_uid,
                        merchant_uid: rsp.merchant_uid
                    })
                })
                .then(res => res.json())
                .then(data => {
                    if (data.status === "paid") {
                        window.location.href = "/payment/success.jsp";
                    } else {
                        window.location.href = "/payment/fail.jsp";
                    }
                });
            } else {
                alert("결제에 실패하거나 취소되었습니다: " + rsp.error_msg);
            }
        });
    }

    updatePrice(); // 페이지 로드 시 초기 금액 계산
</script>
</body>
</html>
