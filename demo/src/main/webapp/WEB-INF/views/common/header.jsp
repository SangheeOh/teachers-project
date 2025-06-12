<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!-- ✅ 여기부터 header 영역만 -->
<header style="width: 100%; height: 64px; background-color: #fff; display: flex; justify-content: center; box-shadow: 0px 4px 8px 0px #00000005;">
    <div style="max-width: 1280px; width: 100%; display: flex; align-items: center; justify-content: space-between; padding: 0 24px;">
        <div style="display: flex; align-items: center;">
            <a href="/"><img src="${pageContext.request.contextPath}/resources/assets/images/teachers/logo3.png" style="height: 32px;" alt="로고"></a>
            <a href="/trainer" style="margin-left: 16px;">전문가 찾기</a>
            <a href="/reviewlist" style="margin-left: 16px;">커뮤니티</a>
        </div>
        <div>
            <sec:authorize access="isAuthenticated()">
                <a href="/logout">로그아웃</a>
                <a href="/mypage">마이페이지</a>
                <a href="/apply"><button style="background: #8A58FF; color: #fff; padding: 8px 16px; border-radius: 8px;">선생님 지원</button></a>
            </sec:authorize>
            <sec:authorize access="!isAuthenticated()">
                <a href="/gologin">로그인</a>
                <a href="/registerPage">회원가입</a>
            </sec:authorize>
        </div>
    </div>
</header>
