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

	    @GetMapping("/adminPage")
	    public String showReservationList(Model model) {
	    	   	
	        List<AdminReport> adminReport = adminService.getAdminReport();
	        
	        //System.out.println("관리자 페이지 adminReport 사이즈: " + adminReport.size());	
	        
	        model.addAttribute("adminReport", adminReport);
	        
	        //대시보드
	        model.addAttribute("totalUserCount", adminService.getTotalUserCount());
	        model.addAttribute("todayUserCount", adminService.getTrainerCount());
	        model.addAttribute("reservationCount", adminService.getTodayReservationCount());
	        
	        return "admin"; 
	    }
	}