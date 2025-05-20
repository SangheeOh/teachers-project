<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>실패</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Noto Sans KR', sans-serif;
            background: #fdf6f6;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }

        .message-box {
            background: #ffffff;
            border-radius: 24px;
            padding: 60px 80px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.08);
            text-align: center;
        }

        .emoji {
            font-size: 64px;
            margin-bottom: 20px;
        }

        .fail-text {
            font-size: 24px;
            color: #e53935;
            font-weight: bold;
        }

        .home-link {
            display: inline-block;
            margin-top: 30px;
            font-size: 16px;
            text-decoration: none;
            color: #e53935;
            font-weight: 500;
        }

        .home-link:hover {
            text-decoration: underline;
        }
        
        .home-link {
            display: inline-block;
            padding: 12px 28px;
            font-size: 16px;
            text-decoration: none;
            color: white;
            background-color: #e53935;
            border-radius: 32px;
            font-weight: 600;
            box-shadow: 0 4px 12px rgba(229, 57, 53, 0.4);
            transition: background-color 0.3s ease, box-shadow 0.3s ease;
        }

        .home-link:hover {
            background-color: #b71c1c;
            box-shadow: 0 6px 18px rgba(183, 28, 28, 0.6);
        }
    </style>
</head>
<body>
<div class="message-box">
    <div class="emoji">😵‍💫</div>
    <div class="fail-text">요청하신 내용 처리 실패했습니다.</div>
    
    <a href="/trainer" class="home-link">강사검색 화면으로 돌아가기</a>
</div>
</body>
</html>
