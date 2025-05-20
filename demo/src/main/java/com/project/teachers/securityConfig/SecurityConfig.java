package com.project.teachers.securityConfig;


import java.io.IOException;
import java.util.Arrays;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.security.core.session.SessionRegistryImpl;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.security.web.authentication.logout.HeaderWriterLogoutHandler;
import org.springframework.security.web.csrf.CookieCsrfTokenRepository;
import org.springframework.security.web.header.writers.ClearSiteDataHeaderWriter;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import org.springframework.web.cors.CorsConfiguration;

import com.project.teachers.entity.CustomUser;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.springframework.security.web.header.writers.ClearSiteDataHeaderWriter.Directive;

@Configuration
@EnableWebSecurity
public class SecurityConfig {
	// 보안 필터 설정
	@Bean
	public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception{
		//csrf 방지설정
		http.csrf(csrf -> csrf.csrfTokenRepository(CookieCsrfTokenRepository.withHttpOnlyFalse()).ignoringRequestMatchers(new AntPathRequestMatcher("/payment/verify", "POST")))
		// CORS 설정(특정 서버에서만 데이터를 주고 받음)
		.cors(cors -> cors.configurationSource(corsCorsfigurationSource()))
		// 세션 필요할 때만 생
		.sessionManagement(session->session.sessionCreationPolicy(SessionCreationPolicy.IF_REQUIRED)
		// 동일 계정으로 중복 로그인 불가 설정
		.maximumSessions(1)
		.maxSessionsPreventsLogin(true)
		.sessionRegistry(sessionRegistry()))  // ✅ 이 부분 꼭 필요
		// /, LoginPage, logout, register = 모든 사용자에게 허용
		.authorizeHttpRequests(authz->authz.requestMatchers("/", "/loginPage","/logout", "/noticeCheckPage", "/registerPage", "/menu/all", "/oauth2/**","/payment/verify","/su","/fa","/selectall","/search","/trainer","/images/**", "/css/**", "/js/**", "/static/**","/trainerdetails","/gologin")
		.permitAll()
		// login은 post요청으로 데이터 전송할 때 사용, 모든 사용자 허용 
		.requestMatchers(HttpMethod.POST,"/login", "/register","/payment/verify","/search").permitAll()
		.requestMatchers("/resources/**","/WEB-INF/**").permitAll()
		// noticeAdd, noticeModifyPage는 admin, manager 일 때만 접근 가능
		.requestMatchers("/noticeAdd","/noticeModifyPage").hasAnyAuthority("MEMBER","TRAINER")
		//위에 적힌 거 외에는 로그인한 사용자만 접근가능 
		.anyRequest().authenticated()
		)
		
		//구글 로그인
		.oauth2Login(oauth2 -> oauth2
	            .loginPage("/login") // 사용자 지정 로그인 페이지 (index.jsp로 연결해도 됨)
	            //.defaultSuccessUrl("/") // 로그인 성공 후 리디렉션 경로
	            .defaultSuccessUrl("/su", true) // 성공 후 su.jsp로 리디렉션
	            .successHandler(authenticationSuccessHandler())  // 기존에 정의된 핸들러로 통일
	            )
		
		
		// 로그인 설정
		.formLogin(
				// 로그인 페이지로 이동할 때
				login->login.loginPage("/loginPage")
				// login 요청 처리
				.loginProcessingUrl("/login")
				// 로그인 실패했을 때
				.failureUrl("/loginPage?error=true")
				// 사용자 이름, 비밀번호 파라미터 
				.usernameParameter("id")
				.passwordParameter("pwd")
				// 로그인 성공 시 실행할 핸들러 
				.successHandler(authenticationSuccessHandler())
				//.defaultSuccessUrl("/su", true)
				.permitAll()
				)
		
        // ✅ 로그인 안 한 사용자가 인증 필요한 페이지 접근 시 메시지 있는 로그인 페이지로 이동
        .exceptionHandling(exception -> exception
            .authenticationEntryPoint((request, response, authException) -> {
                response.sendRedirect("/loginPage?required=true");
            })
        )
		
		
		// 로그아웃 설정 
		.logout(logout -> logout.logoutRequestMatcher(new AntPathRequestMatcher("/logout"))
			// 로그아웃 성공시 이 url(/)로 리다이렉팅
			.logoutSuccessUrl("/") 
			// 자동 로그아웃 방지 기능 해제(세션 무효화, 쿠키 삭제)
			.invalidateHttpSession(true)
			.deleteCookies("JSESSIONID")
			.addLogoutHandler((request, response, authentication) -> {
		        if (authentication != null) {
		            sessionRegistry().removeSessionInformation(request.getSession().getId()); // ✅ 세션 완전 제거
		        }
		    })
		    .addLogoutHandler(new HeaderWriterLogoutHandler(
		        new ClearSiteDataHeaderWriter(Directive.COOKIES, Directive.STORAGE, Directive.CACHE)))
			.permitAll()
			.clearAuthentication(true) // 인증 정보도 초기화
			);
		
		return http.build();
	}
	
	// 로그인 성공 시 수행하는 핸들러
	@Bean
	public AuthenticationSuccessHandler authenticationSuccessHandler() {
	    return new SimpleUrlAuthenticationSuccessHandler() {
	        @Override
	        public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
	                                            Authentication authentication) throws IOException, ServletException {

	            HttpSession session = request.getSession(false);

	            // ✅ 이미 로그인된 경우 로그인 방식 비교
	            if (session != null && session.getAttribute("loginType") != null) {
	                String currentLoginType = session.getAttribute("loginType").toString();
	                String newLoginType = (authentication.getPrincipal() instanceof OAuth2User) ? "GOOGLE" : "LOCAL";

	                if (!currentLoginType.equals(newLoginType)) {
	                    // 로그인 방식 다르면 중복 로그인 시도로 간주
	                    response.sendRedirect(request.getContextPath() + "/loginPage?duplicate=true");
	                    return;
	                }
	            }

	            // 새로운 세션 확보
	            session = request.getSession(true);

	            // ✅ 로그인 방식 저장
	            String loginType = (authentication.getPrincipal() instanceof OAuth2User) ? "GOOGLE" : "LOCAL";
	            session.setAttribute("isAuthenticated", true);
	            session.setAttribute("loginType", loginType);
	            session.setAttribute("id", authentication.getName());
	            
	            session.setAttribute("justLoggedIn", true); //main.jsp에서 팝업

	            Object principal = authentication.getPrincipal();
	            if (principal instanceof CustomUser customUser) {
	                session.setAttribute("name", customUser.getUser().getName());
	                session.setAttribute("role", customUser.getRole()); 
	            } else if (principal instanceof OAuth2User oauth2User) {
	                session.setAttribute("id", oauth2User.getAttribute("email"));
	                session.setAttribute("name", oauth2User.getAttribute("name"));
	                session.setAttribute("role", "member"); // OAuth2User는 기본적으로 'member' 권한이라고 가정
	            }

	            boolean isManager = authentication.getAuthorities().stream()
	                    .anyMatch(auth -> auth.getAuthority().equals("TRAINER") || auth.getAuthority().equals("MEMBER"));
	            if (isManager) {
	                session.setAttribute("member", true);
	            }

	            //response.sendRedirect(request.getContextPath() + "/gologin");
	            response.sendRedirect(request.getContextPath() + "/");
	        }
	    };
	}
	
	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder(); // 비밀번 암호화
	}
	
	// CORS 설정 
	@Bean
	public org.springframework.web.cors.CorsConfigurationSource corsCorsfigurationSource() {
		
		CorsConfiguration configuration = new CorsConfiguration();
		
		// 허용할 URL
		configuration.setAllowedOrigins(Arrays.asList("http://localhost:8080", "http://localhost:8080"));
		// 허용할 HTTP 메서드 
		configuration.setAllowedMethods(Arrays.asList("GET", "POST", "PUT", "DELETE"));
		// 허용할 HTTP 헤더
		configuration.setAllowedHeaders(Arrays.asList("Authorization", "Content-Type"));
		
		configuration.setAllowCredentials(true); //추가함
		
		org.springframework.web.cors.UrlBasedCorsConfigurationSource source = new org.springframework.web.cors.UrlBasedCorsConfigurationSource();
		// 모든 경로에 대해 CORS 설정 
		source.registerCorsConfiguration("/**", configuration);
		
		return source;
	}
	
	// (중복 로그인 인식 위해)
	@Bean
	public SessionRegistry sessionRegistry() {
	    return new SessionRegistryImpl();
	}
}
