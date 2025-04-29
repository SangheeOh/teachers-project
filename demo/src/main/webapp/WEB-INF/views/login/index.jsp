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

<title>로그인 페이지</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/login/style.css">

</head>
<body>

	<div id="login-container-wrapper">
		<div id="login-container">
			<h2>로그인</h2>
			
<% 
    String error = request.getParameter("error");
    if ("true".equals(error)) {
%>
    <p style="color:red;">❌ 아이디 또는 비밀번호가 올바르지 않습니다.</p>
<% 
    } 
%>

<c:if test="${registerSuccess}">
    <script>alert('회원가입 성공했습니다!');</script>
</c:if>
<c:if test="${registerSuccess == false}">
    <script>alert('회원가입 실패했습니다. 다시 해주세요');</script>
</c:if>
				
			<!-- ///// 로그인 안 된 상태면 로그인 버튼들(일반, Google) 보이기 /////-->	
			<sec:authorize access="isAnonymous()">
				
			<!-- localhost:8080/login으로 username, password 넘어감 -->
			<form action="${pageContext.request.contextPath}/login" method="post">
			
			<!-- CSRF 토큰 추가 -->
			<input type="hidden" name="_csrf" value="${_csrf.token}">
			
				<div class="input-group">
					<label for="id">아이디</label>
					<input type="text" id="id" name="id" required/>
				</div> 
				<div class="input-group">
					<label for="pwd">비밀번호</label>
					<input type="password" id="pwd" name="pwd" required/>
				</div>
				<button type="submit" id="login-button">로그인</button>
			</form>
			
			<!-- 구글 로그인 버튼 -->
			<a href="/oauth2/authorization/google">
				<img src="https://developers.google.com/identity/images/btn_google_signin_light_normal_web.png" />
			</a>
			
			</sec:authorize>
			
			<br><br>
			
			<!-- ✅ (일반) 로그인한 경우에만 환영 팝업 띄우기 -->				
			    <c:if test="${not empty sessionScope.name}">
			    <script>
		        const currentUser = '${sessionScope.name}';
		        const shownUser = sessionStorage.getItem('popupShownUser');
		
		        // 이 페이지가 어디서 왔는지 확인
		        const from = document.referrer;
		
		        // 로그인 페이지에서 온 경우에만 팝업 보여주기
		        if (from.includes('/gologin') && shownUser !== currentUser) {
		            alert("😊 환영합니다, " + currentUser + "님!");
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
			
			<div id="register-link">
				<!-- lcalhost:8080/register까지 이동 -->
				<a href="${pageContext.request.contextPath}/registerPage">회원가입</a>	
			</div>
			</sec:authorize>
			
			
		</div>
	</div>

</body>
</html>