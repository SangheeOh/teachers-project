package com.project.teachers.controller;


import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.project.teachers.entity.Menu;
import com.project.teachers.service.MenuService;


@Controller
public class MainController {

	/*  내가 작업한건데 카네즈 test를 위해서 원래 이 페이지가 메인임 
	@Autowired
	private MenuService menuService;
	
	@GetMapping("/")
	 public String first() {
		 return "test"; 
	 }
	
	@GetMapping("/insert.me")
	 public String insert() {
		 return "insert"; 
	 }
	
	@PostMapping("/start.me")
	public String insertMenu(@ModelAttribute Menu menu) {
		
		String memID=menu.getMemID();
		String title=menu.getTitle();
		//System.out.println(memID);
		
		menuService.insertMenu(menu);
		
		//return "redirect:/";
		return "success";
	}
	
	@GetMapping("/select.me")
	 public String selectMenu(Model model) {
		
		ArrayList<Menu> list = menuService.selectMenu();
		
		//System.out.println(list);
		
		model.addAttribute("list",list);
		
		 return "select"; 
	 }
	
*/


}
