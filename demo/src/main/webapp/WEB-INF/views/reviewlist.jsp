<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>강사 리뷰 게시판</title>
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f9f6ff;
            margin: 20px;
        }

        .container {
            max-width: 900px;
            margin: 0 auto;
        }

        h2 {
            text-align: center;
            color: #6c4bb4;
            margin-bottom: 30px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(108, 75, 180, 0.2);
            border-radius: 12px;
            overflow: hidden;
        }

        th, td {
            padding: 14px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }

        th {
            background-color: #e9ddff;
            color: #4c3272;
        }

        tr:hover {
            background-color: #f3e8ff;
        }

        .write-btn {
            display: inline-block;
            margin-top: 20px;
            background-color: #6c4bb4;
            color: white;
            padding: 10px 18px;
            text-decoration: none;
            border-radius: 8px;
        }

        .write-btn:hover {
            background-color: #5637a6;
        }

    </style>
</head>
<body>
<div class="container">
    <h2>강사 리뷰 게시판</h2>

    <table>
        <thead>
        <tr>
            <th>번호</th>
            <th>제목</th>
            <th>작성자</th>
            <th>작성일</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="review" items="${reviewList}">
            <tr onclick="location.href='/review/detail?no=${review.no}'" style="cursor:pointer;">
                <td>${review.no}</td>
                <td>${review.title}</td>
                <td>${review.writer}</td>
                <td>${review.createdate}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <a href="/review/write" class="write-btn">글 작성하기</a>
</div>
</body>
</html>
