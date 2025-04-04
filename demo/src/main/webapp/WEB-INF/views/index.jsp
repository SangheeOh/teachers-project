<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<br><br><br><br><br>


<a href="usertest.me">로그인 구현_조회하기(USER TABLE)</a>
<br><br><br><br><br>


<a href="insert.me">DB INSERT(Menu테이블_test용)</a>
<br><br><br><br><br>


<a href="select.me">SELECT 조회하기(Menu테이블_test용)</a>
<br><br><br><br><br>




<!-- 카네즈 사항 -->

<!--헤더의 내용이 다 들어감-->
<%@ include file="/WEB-INF/views/common/header.jsp" %>

	<div id="container">
		<div id="menuAdmin">
			<h2 id="menuAdminH2">index</h2>
			
			<div id="menuList">
			</div>
		</div>
	</div>
	

<!--푸터의 내용이 다 들어감-->	
<%@ include file="/WEB-INF/views/common/footer.jsp" %>


</body>
</html>
