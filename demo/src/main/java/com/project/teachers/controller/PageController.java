package com.project.teachers.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.http.HttpServletRequest;

import ch.qos.logback.core.model.Model;
import org.springframework.security.web.csrf.CsrfToken;
import org.springframework.web.bind.annotation.ModelAttribute;
import com.project.teachers.entity.User;


@Controller
public class PageController {
	
	// 페이지를 조회,이동할 때 getMapping 사용
		@GetMapping("/")
		public String home() {
			return "index";
		}
		

		// 로그인 페이지
		@GetMapping("/loginPage")
		public String loginPage(HttpServletRequest request,org.springframework.ui.Model model) {
			
			// csrf 처리를 해줘야 정보가 넘어감
			CsrfToken csrfToken = (CsrfToken)request.getAttribute(CsrfToken.class.getName());
			
			model.addAttribute("_csrf", csrfToken);
			return "login/index";
		}
		 
		// 회원가입 화면
		// Controller -> View 단으로 request 보냄
		@GetMapping("/registerPage")
		public String registerPage(HttpServletRequest request,org.springframework.ui.Model model) {
			
			// csrf 처리를 해줘야 정보가 넘어감
			CsrfToken csrfToken = (CsrfToken)request.getAttribute(CsrfToken.class.getName());
			
			model.addAttribute("_csrf", csrfToken);
			return "register/index";
		}	

}
