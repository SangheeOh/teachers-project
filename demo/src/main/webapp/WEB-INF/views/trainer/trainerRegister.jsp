<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>트레이너 등록</title>

    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">

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
            max-width: 800px;
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
            margin-bottom: 25px;
        }

        label {
            display: block;
            font-weight: 500;
            margin-bottom: 10px;
            color: var(--text-color);
        }

        input[type="text"],
        input[type="file"],
        select {
            width: 100%;
            padding: 14px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: var(--border-radius);
            transition: border 0.2s ease;
        }

        input[type="text"]:focus,
        select:focus {
            border-color: var(--primary-color);
            outline: none;
        }

        .id-check {
            display: flex;
            gap: 10px;
        }

        .id-check input {
            flex: 1;
        }

        .check-btn {
            padding: 14px 18px;
            font-size: 14px;
            background: var(--primary-color);
            color: white;
            border: none;
            border-radius: var(--border-radius);
            cursor: pointer;
        }

        .check-btn:hover {
            background: var(--primary-hover);
        }

        .submit-btn {
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
            margin-top: 30px;
        }

        .submit-btn:hover {
            background: var(--primary-hover);
        }

        @keyframes fadeIn {
            from {opacity: 0; transform: translateY(20px);}
            to {opacity: 1; transform: translateY(0);}
        }
        
        .radio-group {
            display: flex;
            gap: 20px;
        }

        .radio-group input[type="radio"] {
            margin-right: 10px;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>트레이너 등록</h2>

    <form action="/trainer/register" method="post" enctype="multipart/form-data">
        
        <!-- 1. 아이디 입력 -->
        <div class="form-group">
            <label>아이디</label>
            <div class="id-check">
                <input type="text" name="trainerId" placeholder="아이디를 입력하세요" required>
                <button type="button" id="usernameCheck" class="check-btn">아이디 확인</button>
            </div>
        </div>

        <!-- 2. 운동 분야 -->
        <div class="form-group">
            <label>운동 분야</label>
            <select name="field" required>
                <option value="">선택하세요</option>
                <option value="요가">요가</option>
                <option value="헬스">헬스</option>
                <option value="필라테스">필라테스</option>
                <option value="크로스핏">크로스핏</option>
                <option value="무관">무관</option>
            </select>
        </div>

        <!-- 3. 경력 -->
        <div class="form-group">
            <label>경력 (년)</label>
            <select name="career" required>
                <option value="">선택하세요</option>
                <% for (int i = 1; i <= 10; i++) { %>
                    <option value="<%=i%>"><%=i%>년</option>
                <% } %>
            </select>
        </div>

 		<!-- 성별 -->
        <div class="form-group">
            <label>성별</label>
            <div class="radio-group">
                <label><input type="radio" name="gender" value="남성" required> 남성</label>
                <label><input type="radio" name="gender" value="여성" required> 여성</label>
            </div>
        </div>

        <!-- 5. 가능 지역 -->
        <div class="form-group">
            <label>가능 지역</label>
            <input type="text" name="location" placeholder="시/군, 구, 동을 입력하세요" required>
        </div>

        <!-- 6. 가능 요일 -->
        <div class="form-group">
            <label>가능 요일</label>
            <input type="text" name="availableDays" placeholder="예: 월, 수, 금" required>
        </div>

        <!-- 7. 가능 시간 -->
        <div class="form-group">
            <label>가능 시간</label>
            <input type="text" name="availableTimes" placeholder="예: 오전 10시 ~ 오후 3시" required>
        </div>

        <!-- 8. 강좌 제목 -->
        <div class="form-group">
            <label>강좌 제목</label>
            <input type="text" name="lectureTitle" placeholder="예: 누구나 쉽게 배우는 헬스 클래스" required>
        </div>

        <!-- 9. 강좌 소개 -->
        <div class="form-group">
            <label>강좌 소개</label>
            <input type="text" name="lectureDescription" placeholder="간단한 강좌 설명을 입력하세요" required>
        </div>

        <!-- 10. 강사 사진 업로드 -->
        <div class="form-group">
            <label>강사 사진 업로드</label>
            <input type="file" name="profileImage" accept="image/*" required>
        </div>

        <button type="submit" class="submit-btn">등록하기</button>
    </form>
</div>

<script>
    // 사진 미리보기
    function previewImage(event) {
        const file = event.target.files[0];
        const imagePreview = document.getElementById('imagePreview');
        
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                imagePreview.src = e.target.result;
                imagePreview.style.display = 'block'; // 사진을 보여줌
            }
            reader.readAsDataURL(file);
        } else {
            imagePreview.style.display = 'none'; // 파일이 없을 경우 미리보기 숨김
        }
    }

    // 아이디 확인 클릭 시 동작
    document.getElementById("usernameCheck").addEventListener("click", function() {
        const username = document.getElementById("username").value;
        if (username) {
            alert("아이디가 사용 가능합니다.");
        } else {
            alert("아이디를 입력해주세요.");
        }
    });
</script>
</body>
</html>