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


<!--헤더의 내용이 다 들어감-->
<%@ include file="/WEB-INF/views/common/header.jsp" %>

	<div id="container">
		<div id="menuAdmin">
			<h2 id="menuAdminH2">로그인/로그아웃/회원가입</h2>
			<br><br><br><br>
			
			<!-- ///// 로그인 안 된 상태면 로그인 버튼들(일반, Google) 보이기 /////-->
				<sec:authorize access="isAnonymous()">
				    <!-- 구글 로그인 버튼 -->
				    <a href="/oauth2/authorization/google">
				        <img src="https://developers.google.com/identity/images/btn_google_signin_light_normal_web.png" />
				    </a>
				    
				    <br><br>
				
				    <!-- 일반 로그인 버튼 -->
				    <a href="${pageContext.request.contextPath}/loginPage">로그인하러 가기</a>
				</sec:authorize>
		
			
		<!-- ✅ (일반) 로그인한 경우에만 환영 팝업 띄우기 -->				
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


	    <!-- 로그인한 상태면 로그아웃 버튼 하나만 보이도록 (일반, Google) -->
	    <sec:authorize access="isAuthenticated()">
	      <form action="${pageContext.request.contextPath}/logout" method="post">
	        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	        <button type="submit">로그아웃</button>
	      </form>
   		 </sec:authorize>
	    
		
		<!-- ✅ 회원가입 (일반, Google 모두 로그인 안했을때만 보임)  -->
		<sec:authorize access="isAnonymous()">
		    <br><br><br>    
		    <a href="registerPage">회원가입 하세요</a>
		</sec:authorize>
	
			
			

			<div id="menuList">
			</div>
		</div>
	</div>
	

<!--푸터의 내용이 다 들어감-->	
<%@ include file="/WEB-INF/views/common/footer.jsp" %>


</body>
</html>
