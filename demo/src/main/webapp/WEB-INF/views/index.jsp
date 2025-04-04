<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String name = (String) session.getAttribute("name");

    // name이 null이 아닌 경우에만 trim() 체크 -> NullPointerException 방지
    if (name != null && !name.trim().isEmpty() 
        && session.getAttribute("SPRING_SECURITY_CONTEXT") == null) {
        
        session.invalidate(); // 복원된 세션 무효화
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="-csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">

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
			<h2 id="menuAdminH2">login/logout</h2>
			<br><br><br>
			
			
			
			<!-- ✅ 로그인한 경우에만 환영 팝업 띄우기 -->				
   <c:if test="${not empty sessionScope.name}">
    <script>
        const currentUser = '${sessionScope.name}';
        const shownUser = sessionStorage.getItem('popupShownUser');

        // 이 페이지가 어디서 왔는지 확인
        const from = document.referrer;

        // 로그인 페이지에서 온 경우에만 팝업 보여주기
        if (from.includes('/loginPage') && shownUser !== currentUser) {
            alert("😊 환영합니다, " + currentUser + " 님!");
            sessionStorage.setItem('popupShownUser', currentUser);
        }
    </script>
</c:if>

    <!-- ✅ 로그인 상태이면 로그아웃 버튼 표시 -->
    <c:if test="${not empty sessionScope.name}">
        <form action="${pageContext.request.contextPath}/logout" method="post">
            <!-- CSRF 토큰 hidden으로 전송 -->
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <button type="submit">로그아웃</button>
        </form>
    </c:if>

    <!-- ✅ 로그인 안 된 경우 -->
    <c:if test="${empty sessionScope.name}">
        <a href="${pageContext.request.contextPath}/loginPage">로그인하러 가기</a>
    </c:if>
			
	<!-- ✅ 회원가입 -->
			
		<br><br><br>	
		<a href="registerPage">회원가입 하세요</a>	
			
			

			<div id="menuList">
			</div>
		</div>
	</div>
	

<!--푸터의 내용이 다 들어감-->	
<%@ include file="/WEB-INF/views/common/footer.jsp" %>


</body>
</html>
