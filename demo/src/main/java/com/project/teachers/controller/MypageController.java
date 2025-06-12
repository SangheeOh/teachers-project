package com.project.teachers.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.project.teachers.entity.MypageReport;
import com.project.teachers.service.MypageService;

import jakarta.servlet.http.HttpSession;

@Controller
public class MypageController {

    @Autowired
    private MypageService mypageService;

    @GetMapping("/mypage")
    public String mypageView(HttpSession session, Model model) {
    	
    	//System.out.println("[MypageController] /mypage 요청확인");
    	
        Integer userNo = (Integer) session.getAttribute("user_no"); // 세션에서 로그인 정보 가져옴
        String name = (String) session.getAttribute("name");

        if (userNo == null) {
        	System.out.println("세션에 user_no 없음 → 로그인 필요");
        	return "redirect:/loginPage"; 
        }

        List<MypageReport> mypageReport = mypageService.getMyReservationReport(userNo);
        
        System.out.println("예약/결제 조회 결과 건수: " + mypageReport.size());


        model.addAttribute("mypageReport", mypageReport);
        model.addAttribute("name", name);

        return "mypage";
    }
}
