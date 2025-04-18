<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="-csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">

<title>test page</title>
</head>
<body>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<br><br><br><br><br>

<!-- 연습용, 추후 수정 예정 -->
<a href="usertest.me">로그인 구현_조회하기(USER TABLE)</a>
<br><br><br><br>


<a href="insert.me">DB INSERT(Menu테이블_test용)</a>
<br><br><br><br>


<a href="select.me">SELECT 조회하기(Menu테이블_test용)</a>
<br><br><br><br>

	
<%@ include file="/WEB-INF/views/common/footer.jsp" %>


</body>
</html>
