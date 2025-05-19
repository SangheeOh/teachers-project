<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>회원가입</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap');

        body {
            margin: 0;
            padding: 0;
            font-family: 'Noto Sans KR', sans-serif;
            background: #f3f0fa;
        }

        .signup-container {
            max-width: 500px;
            margin: 80px auto;
            background: white;
            border-radius: 20px;
            box-shadow: 0 8px 24px rgba(94, 53, 177, 0.15);
            padding: 50px 40px;
        }

        h2 {
            margin-bottom: 35px;
            text-align: center;
            font-size: 28px;
            color: #5e35b1;
            font-weight: 700;
        }

        .form-group {
            margin-bottom: 22px;
        }

        label {
            font-weight: 600;
            font-size: 15px;
            color: #4a148c;
            display: block;
            margin-bottom: 8px;
        }

        input[type="text"],
        input[type="password"],
        input[type="email"],
        input[type="tel"],
        select {
            width: 100%;
            padding: 14px;
            border: 1px solid #d1c4e9;
            border-radius: 12px;
            font-size: 15px;
            transition: border-color 0.3s;
        }

        input:focus,
        select:focus {
            border-color: #7e57c2;
            outline: none;
        }

        .signup-btn {
            width: 100%;
            padding: 16px;
            background: #7e57c2;
            color: white;
            font-size: 17px;
            font-weight: bold;
            border: none;
            border-radius: 12px;
            cursor: pointer;
            transition: background 0.3s;
            margin-top: 10px;
        }

        .signup-btn:hover {
            background: #6a4cb0;
        }

        .back-link {
            text-align: center;
            margin-top: 24px;
            font-size: 14px;
            color: #666;
        }

        .back-link a {
            text-decoration: none;
            color: #5e35b1;
            font-weight: 500;
        }

        .back-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="signup-container">
    <h2>회원가입</h2>
    <form action="${pageContext.request.contextPath}/register" method="post">
    
    	<!-- CSRF 토큰 추가 -->
		<input type="hidden" name="_csrf" value="${_csrf.token}">
    
        <div class="form-group">
            <label for="id">아이디</label>
            <input type="text" name="id" id="id" required>
        </div>
        <div class="form-group">
            <label for="pwd">비밀번호</label>
            <input type="password" name="pwd" id="pwd" required>
        </div>
        <div class="form-group">
            <label for="name">이름</label>
            <input type="text" name="name" id="name" required>
        </div>
        <div class="form-group">
            <label for="email">이메일</label>
            <input type="email" name="email" id="email" required>
        </div>
        <div class="form-group">
            <label for="phone">전화번호</label>
            <input type="tel" name="phone" id="phone" placeholder="010-1234-5678">
        </div>
        <div class="form-group">
            <label for="role">회원 유형</label>
            <select name="role" id="role" required>
                <option value="">선택하세요</option>
                <option value="member">일반 회원</option>
                <option value="trainer">운동 전문가</option>
                <option value="admin">관리자</option>
            </select>
        </div>
        <button type="submit" class="signup-btn">회원가입</button>
    </form>

    <div class="back-link">
        <a href="${pageContext.request.contextPath}/loginPage">이미 계정이 있으신가요? 로그인</a>
    </div>
</div>
</body>
</html>
