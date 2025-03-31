package com.project.teachers.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.project.teachers.entity.User;
import com.project.teachers.service.MenuService;
import com.project.teachers.service.UserService;


@Controller
public class UserController {
	
	@Autowired
	private UserService userService;
	
	//user처음 테스트용
		@GetMapping("/usertest.me")
		 public String selectUser(Model model) {
			
			ArrayList<User> box = userService.selectUser();
			
			//System.out.println(box);
			
			model.addAttribute("box",box);
			
			 return "select"; 
		 }

}
