<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h1> DB까지 연결시켰습니다! 입력하면 저장됩니다!</h1>

	<form action="${pageContext.request.contextPath}/start.me" method="post">
	<input type="text" id="memID" name="memID"> 
	<input type="text" id="title" name="title">
	
	<button type="submit">확인</button>
	
	</form>
</body>
</html>
