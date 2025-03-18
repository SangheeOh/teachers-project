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
}
</style>
</head>
<body>

	        <h2>SELECT 결과</h2>
            <br>
            <c:if test="${not empty list }">
            <h1>성공했습니다!</h1>
            </c:if>
            <br>
            <table id="selectlist" class="table table-hover" align="center">
                <thead>
                    <tr>
                        <th>아이디</th>
                        <th>타이틀</th>
                    </tr>
                </thead>
                <tbody>
                   <c:forEach var="b" items="${list}">
                    <tr>
                        <td>${b.memID }</td>
                        <td>${b.title }</td>
                    </tr>
                   </c:forEach>
                   
                </tbody>
            </table>
				
</body>
</html>
