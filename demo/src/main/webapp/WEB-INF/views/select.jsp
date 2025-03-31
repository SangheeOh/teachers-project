<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Document</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
.content {
	background-color: rgb(247, 245, 245);
	width: 80%;
	margin: auto;
}

.innerOuter {
	border: 1px solid lightgray;
	width: 80%;
	margin: auto;
	padding: 5% 10%;
	background-color: white;
}

table * {
	margin: 5px;
}

table {

	width: 100%;
            max-width: 1200px; /* 최대 너비 설정 */
            margin: 0 auto; /* 가운데 정렬 */
            border-collapse: collapse;
}

        /* 테이블 셀 스타일 */
        th, td {
            padding: 10px;
            text-align: center;
            font-size: 18px;  /* 글씨 크기 크게 */
        }

h2 {
            text-align: center;           /* 가운데 정렬 */
            font-size: 36px;              /* 글씨 크기 크게 */
            color: blue;                  /* 글씨 색 파란색 */
            font-weight: bold;            /* 글씨 굵게 */
            text-decoration: underline;   /* 밑줄 */
        }	
</style>
</head>
<body>

<br><br>

	        <h2>회원 조회</h2>
            <br>
            <c:if test="${not empty list }">
            <h1>성공했습니다!</h1>
            </c:if>
            <br>
            <table id="selectlist" class="table table-hover" align="center">
                <thead>
                    <tr>
                        <th>No.</th>
                        <th>ID</th>
                        <th>PWD</th>
                        <th>NAME</th>
                        <th>EMAIL</th>
                        <th>PHONE</th>
                        <th>CREATE_DATE</th>
                        <th>STATUS</th>
                        <th>ROLE</th>
                    </tr>
                </thead>
                <tbody>
                   <c:forEach var="b" items="${box}">
                    <tr>
                        <td>${b.user_no }</td>
                        <td>${b.id }</td>
                        <td>${b.pwd }</td>
                        <td>${b.name }</td>
                        <td>${b.email }</td>
                        <td>${b.phone }</td>
                        <td>${b.createdate }</td>
                        <td>${b.status }</td>
                        <td>${b.role }</td>
                    </tr>
                   </c:forEach>
                   
                </tbody>
            </table>
				
</body>
</html>
