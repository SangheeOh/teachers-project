package com.project.teachers.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import ch.qos.logback.core.model.Model;
import org.springframework.security.web.csrf.CsrfToken;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.project.teachers.entity.User;


@Controller
public class PageController {
	
	
		//메인페이지조회
		@GetMapping("/")
		public String home() {
			return "main";
		}
		
		// 페이지 조회
		@GetMapping("/gologin")
		public String login() {
			return "login/index";
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
		
		/*
		// mypage 이동
		@GetMapping("/mypage")
		public String mypage() {
			return "mypage";
		}
		*/
	
		
		// reviewlist 이동
		@GetMapping("/reviewlist")
		public String reviewlist() {
			return "reviewlist";
		}
		
		
		//결제요청 페이지
		@GetMapping("/payment")
		 public String paymentPage() {
			 return "payment/payment"; 
		 }
		
		
		//강사 검색
		@GetMapping("/trainer")
		public String selectallPage() {
			return "trainer/selectall"; 
		}
		
		//성공페이지
		@GetMapping("/su")
		public String successPage() {
			   return "payment/success";
		}
			
		//실패페이지
		@GetMapping("/fa")
		public String failPage() {
			   return "payment/fail";
		}
	}
