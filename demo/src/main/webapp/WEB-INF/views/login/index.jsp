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
			<a href="/">
  	<img src="${pageContext.request.contextPath}/resources/assets/images/teachers/logo3.png" alt="TEACHERS 로고" style="display:block; margin: 30px auto; height: 60px;" />
	</a>
	
		
<!-- 로그인 실패 시 메시지 -->
			
<% 
    String error = request.getParameter("error");
    if ("true".equals(error)) {
%>
    <p style="color:red;">❌ 아이디 또는 비밀번호가 올바르지 않습니다.</p>
<% 
    } 
%>

<!-- spring security 인증되지 않은 사용자가 보호된 페이지 접근 시 메시지 -->
<c:if test="${param.required != null}">
  <p style="color: orange;">🔒 로그인 후 이용해주세요.</p>
</c:if>

<!-- ✅ 중복 로그인 시 메시지 -->
<c:if test="${param.duplicate eq 'true'}">
  <div class="error-msg" style="color:red;">현재 로그인 상태입니다! 로그아웃 후 다시 로그인해주세요.</div>
</c:if>


<!-- ✅ 회원가입 메시지 -->
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
					
					<input type="text" id="id" name="id" placeholder="아이디" required/>
				</div> 
				<div class="input-group">
				
					<input type="password" id="pwd" name="pwd" placeholder="비밀번호" required/>
				</div>
				
				<!-- 로그인 상태 유지 체크박스 -->
				<div style="margin-top: 10px; display: flex; align-items: center;">
				  <input type="checkbox" name="remember-me" id="remember" style="margin-right: 6px;" />
				  <label for="remember" style="margin: 0; font-size: 14px; display: inline;">아이디 저장</label>
				</div>
				<br>
				
				<button type="submit" id="login-button">로그인</button>
			</form>

			<!-- 구글 로그인 버튼 (색깔 변경) -->
			<a href="/oauth2/authorization/google">
			  <img src="https://developers.google.com/identity/images/btn_google_signin_dark_normal_web.png" 
			       alt="Sign in with Google" 
			       style="margin-top: 10px;" />
			</a>
			
			<div style="margin-top: 20px; text-align: center; font-size: 14px; color: #777;">
			  <a href="/findPwd" style="margin: 0 8px;">비밀번호 찾기</a> |
			  <a href="/findId" style="margin: 0 8px;">아이디 찾기</a> |
			  <a href="/registerPage" style="margin: 0 8px;">회원가입</a>
			</div>


			</sec:authorize> 
			
			<br><br>

			<!-- ✅ (일반) 로그인한 경우에만 환영 팝업 띄우기 -->				
			<!-- ✅ 로그인 성공 후에만 환영 팝업 띄우기 (중복 로그인/에러는 제외) -->
			<c:if test="${not empty sessionScope.name 
			              && param.error ne 'true' 
			              && param.duplicate ne 'true'}">
			    <script>
			        const currentUser = '${sessionScope.name}';
			        const shownUser = sessionStorage.getItem('popupShownUser');
			
			        const from = document.referrer;
			
			        // 로그인 페이지에서 온 경우만 팝업
			        if (from.includes('/gologin') && shownUser !== currentUser) {
			            alert("😊 환영합니다, " + currentUser + "님!");
			            sessionStorage.setItem('popupShownUser', currentUser);
			        }
			    </script>
			</c:if>
			
			<!-- 로그인 시, sessionStorage 초기화 (팝업이 뜨지 않도록 초기화) -->
			<script>
    			// 로그인 시, sessionStorage 초기화 (팝업이 뜨지 않도록 초기화)
    		sessionStorage.removeItem('popupShownUser');
			</script>

			
			<!-- 로그인한 상태면 로그아웃 버튼 하나만 보이도록 (일반, Google) -->
	   		<sec:authorize access="isAuthenticated()">
		      <form action="${pageContext.request.contextPath}/logout" method="post">
		        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		        <button type="submit">로그아웃</button>
		      </form>
   			</sec:authorize>
			
			
		</div>
	</div>

</body>
</html>