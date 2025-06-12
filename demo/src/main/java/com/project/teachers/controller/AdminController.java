package com.project.teachers.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.project.teachers.entity.AdminReport;
import com.project.teachers.service.AdminService;

@Controller
public class AdminController {

	  @Autowired
	    private AdminService adminService;

	    @GetMapping("/admin")
	    public String showReservationList(Model model) {
	        List<AdminReport> adminReport = adminService.getAdminReport();
	        model.addAttribute("adminReport", adminReport);
	        return "admin"; 
	    }
	}