package com.project.teachers.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.project.teachers.entity.Role;
import com.project.teachers.entity.User;
import com.project.teachers.service.MenuService;
import com.project.teachers.service.UserService;

import jakarta.servlet.http.HttpServletRequest;


@Controller
public class UserController {
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	//user처음 테스트용
		@GetMapping("/usertest.me")
		 public String selectUser(Model model) {
			
			ArrayList<User> box = userService.selectUser();
			
			//System.out.println(box);
			
			model.addAttribute("box",box);
			
			 return "select"; 
		 }
		
		
		@PostMapping("/register")
		public String register(@ModelAttribute User user, HttpServletRequest request) {
			
			//@ModelAttribute User user에 JSP 폼의 name 값이 자동으로 매핑되기도 하지만, 
			//select box는 잘 안 담기는 경우도 있으므로 request.getParameter("role")로 직접 받는 게 안정적

		    //JSP에서 넘긴 role 파라미터 가져오기
		    String selectedRole = request.getParameter("role"); // "member" 또는 "trainer"

		    //선택된 role을 User 객체에 직접 설정
		    user.setRole(selectedRole);  // enum 안 쓰고 그대로 문자열 저장

		    //패스워드 암호화
		    String userPassword = user.getPwd();
		    String passwordEncoded = passwordEncoder.encode(userPassword);  //암호화
		    user.setPwd(passwordEncoded);//암호화된 패스워드 담김 
		    System.out.println("userPassword: "+userPassword);

		    
		    //성공, 실패 알림창
		    try {
		        userService.insertUser(user);  //유저정보 DB에 저장
		        request.setAttribute("registerSuccess", true); //회원가입 성공, 실패 메시지를 model에 담고 loginPage.jsp로 forward
		    } catch (Exception e) {
		        e.printStackTrace();
		        request.setAttribute("registerSuccess", false);
		    }
		    
		    return "login/index"; // forward
		    
		    //유저정보 DB에 저장
		    //userService.insertUser(user);

		    //회원가입 성공, 실패 메시지를 model에 담고 loginPage.jsp로 forward
		    //request.setAttribute("registerSuccess", true);
		    //return "loginPage"; // forward
		    
		    //로그인 페이지로 리다이렉트
		    //return "redirect:/loginPage";
		}


}
