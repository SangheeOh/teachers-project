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
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.security.web.csrf.CookieCsrfTokenRepository;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import org.springframework.web.cors.CorsConfiguration;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@Configuration
@EnableWebSecurity
public class SecurityConfig {
	// 보안 필터 설정
	@Bean
	public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception{
		//csrf 방지설정
		http.csrf(csrf -> csrf.csrfTokenRepository(CookieCsrfTokenRepository.withHttpOnlyFalse()))
		// CORS 설정(특정 서버에서만 데이터를 주고 받음)
		.cors(cors -> cors.configurationSource(corsCorsfigurationSource()))
		// 세션 필요할 때만 생
		.sessionManagement(session->session.sessionCreationPolicy(SessionCreationPolicy.IF_REQUIRED))
		// 접근 권한 설정
		// /, LoginPage, logout, register = 모든 사용자에게 허용
		.authorizeHttpRequests(authz->authz.requestMatchers("/", "/loginPage","/logout", "/noticeCheckPage", "/registerPage", "/menu/all")
		.permitAll()
		// login은 post요청으로 데이터 전송할 때 사용, 모든 사용자 허용 
		.requestMatchers(HttpMethod.POST,"/login", "/register").permitAll()
		.requestMatchers("/resources/**","/WEB-INF/**").permitAll()
		// noticeAdd, noticeModifyPage는 admin, manager 일 때만 접근 가능
		.requestMatchers("/noticeAdd","noticeModifyPage").hasAnyAuthority("MEMBER","TRAINER")
		//위에 적힌 거 외에는 로그인한 사용자만 접근가능 
		.anyRequest().authenticated()
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
				.usernameParameter("name")
				.passwordParameter("pwd")
				// 로그인 성공 시 실행할 핸들러 
				.successHandler(authenticationSuccessHandler())
				.permitAll()
				)
		// 로그아웃 설정 
		.logout(logout -> logout.logoutRequestMatcher(new AntPathRequestMatcher("/logout"))
			// 로그아웃 성공시 이 url(/)로 리다이렉팅
			.logoutSuccessUrl("/") 
			// 자동 로그아웃 방지 기능 해제(세션 무효화, 쿠키 삭제)
			.invalidateHttpSession(true)
			.deleteCookies("JSESSIONID")
			.permitAll()
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
					
					// 세션 유지(로그인 유지)
					HttpSession session = request.getSession(); 
					
					boolean isManager = authentication.getAuthorities().stream()
							.anyMatch(grantedAuthoirity ->
							grantedAuthoirity.getAuthority().equals("TRAINER") ||
							grantedAuthoirity.getAuthority().equals("MEMBER"));
					
					// 운영진일 때 세션에 매니저 표시 
					if(isManager) {
						session.setAttribute("Member", true);
					}
					
					// 유저이름 저장 
					session.setAttribute("name", authentication.getName());
					session.setAttribute("isAuthenticatied", true);
					
					// 로그인 성공 후 / 로 리다이렉트
					response.sendRedirect(request.getContextPath()+"/");
					
					super.onAuthenticationSuccess(request, response, authentication);
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
		configuration.setAllowedMethods(Arrays.asList("Get", "POST", "PUT", "DELETE"));
		// 허용할 HTTP 헤더
		configuration.setAllowedHeaders(Arrays.asList("Authorization", "Content-Type"));
		
		org.springframework.web.cors.UrlBasedCorsConfigurationSource source = new org.springframework.web.cors.UrlBasedCorsConfigurationSource();
		// 모든 경로에 대해 CORS 설정 
		source.registerCorsConfiguration("/**", configuration);
		
		return source;
	}
}
