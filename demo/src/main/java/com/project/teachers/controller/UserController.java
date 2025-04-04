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
		
		
		
		//카네즈
		@PostMapping("/register")
		// register 로 이동할 때 user 정보를 파라미터로 가진 채 이동 
		public String register(@ModelAttribute User user) {
			
			String userPassword = user.getPwd();
			System.out.println("!!!!!!!!!!userPassword: "+userPassword);
			
			user.setRole(Role.MEMBER.toString()); //멤버로 지정 
			
			String passwordEncoded = passwordEncoder.encode(userPassword); // 암호화
			
			user.setPwd(passwordEncoded); // 암호화된 패스워드 담김 
			
			userService.insertUser(user); // 유저 정보를 데이터베이스에 저장 
			
			// 다시 로그인 화면으로 리다이렉팅
			return "redirect:/loginPage";
		}

}
