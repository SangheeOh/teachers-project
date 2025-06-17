
✨ Teachers Project  
퍼스널 트레이너와 사용자를 연결하는 예약/결제 플랫폼 
(Spring Boot + MySQL 기반 웹 프로젝트)  

  

📌 프로젝트 개요  
방문 퍼스널 트레이닝 서비스를 사용자가 예약하고 결제할 수 있는 웹사이트입니다. 소셜 로그인, 강사검색, 예약/결제, 관리자페이지 등 실무에서 활용 가능한 기능을 통합한 실전형 플랫폼입니다.   

  

🎯 개발 목표  
- Spring Security 기반 인증/인가 체계 구축
  
- 다양한 API 연동: Google OAuth2, Iamport 결제, Kakao 주소 검색
  
- 강사 검색 → 예약 → 결제 → 마이페이지 연결로 사용자 경험 중심 흐름 구현
  
- 사용자/강사/관리자 간 역할 기반 화면 및 권한 분리 설계

    

🔍 프로젝트 주요 특징 및 핵심 기능  
- 인증/보안	Spring Security + Google OAuth2 로그인, Session 기반 인증유지, CSRF 보호 및 Bcrypt 암호화를 통한 보안 강화  
- 회원 관리	사용자·강사·관리자 간 역할별 접근 제어, Google 로그인 연동 및 자동 회원 등록 DB 로직 구현  
- 강사 검색	Kakao API 기반 지역 검색/종목/성별 필터링을 통한 강사 프로필 상세확인  
- 예약 기능	강사 별 수업 가능 시간 바둑판 형태 UI 제공 및 셀 클릭하여 직관적 예약   
- 결제 기능	Iamport API 연동으로 간편 결제, 서버 검증, DB 저장 완결형 흐름 제공  
- 마이페이지	개인정보 수정, 예약·결제 내역 확인 및 관리  
- 관리자 기능	Admin 전용 페이지 분기, 지표 시각화 대시보드, 예약·결제 현황 테이블 통합 지원 및 Excel 다운로드 기능 제공
  

💼 사용 기술 스택
- Backend: Spring Boot 3.4.2  Maven  Java17  MyBatis
- Frontend: JSP  HTML  CSS  JavaScript
- DB: MySQL 8.0
- API: Google OAuth 2.0 Login API, Iamport 결제 API, Kakao 우편번호 검색 API

📆 ERD 구조
사용자(user), 강사(trainer), 결제(payment), 예약(reservation), 관리자(admin) 등 테이블간 관계 설계

🧱 프로젝트 구조  
```
src/main/java
 └─ com.project.teachers
     ├─ controller         // 클라이언트 요청 수신 및 View/Response 반환
     ├─ entity             // 클래스 정의, DB 테이블 매핑
     ├─ mapper             // MyBatis Mapper
     ├─ service            // 비즈니스 로직
     ├─ securityConfig     // Spring Security 기반 인증/인가 설정 및 필터 체인 구성
     └─ application.java   // 메인 실행 클래스
```

🙌 기대 효과
-	사용자: 강사검색 및 정보확인 → 간편한 예약 → 안전한 결제 흐름 확보
-	관리자: 회원정보 및 예약·결제 현황을 한눈에 확인하고, 데이터기반으로 서비스 운영 가능
-	서비스 측면: 다양한 API 연동으로 사용자 편의성과 신뢰도 제공, MVC 설계로 기능 확장 및 유지보수 용이
-	개발자 측면: Spring Security, 다양한 API 연동 등 실무에서 활용 가능한 기술 스택을 직접 구현하며 웹 개발 역량 강화 
