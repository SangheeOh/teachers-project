package com.project.teachers.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.project.teachers.entity.AdminReport;
import com.project.teachers.service.AdminService;

import jakarta.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Cell;

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
	    
	    @GetMapping("/admin/downloadExcel")
	    public void downloadExcel(HttpServletResponse response) throws IOException {
	        List<AdminReport> dataList = adminService.getAdminReport(); // 기존 목록

	        Workbook workbook = new XSSFWorkbook();
	        Sheet sheet = workbook.createSheet("reservation");

	        // 헤더 생성
	        Row header = sheet.createRow(0);
	        String[] columns = {"회원", "강사", "분야", "지역", "요일", "시간", "결제금액", "결제수단", "결제일시", "상태"};
	        for (int i = 0; i < columns.length; i++) {
	            header.createCell(i).setCellValue(columns[i]);
	        }

	        // 데이터 채우기
	        for (int i = 0; i < dataList.size(); i++) {
	        	AdminReport item = dataList.get(i);
	            Row row = sheet.createRow(i + 1);
	            row.createCell(0).setCellValue(item.getUserName());
	            row.createCell(1).setCellValue(item.getTrainerName());
	            row.createCell(2).setCellValue(item.getSpeciality());
	            row.createCell(3).setCellValue(item.getRegion());
	            row.createCell(4).setCellValue(item.getDay());
	            row.createCell(5).setCellValue(item.getTime() + "시");
	            row.createCell(6).setCellValue(item.getAmount());
	            row.createCell(7).setCellValue(item.getMethod());
	            row.createCell(8).setCellValue(item.getPaymentDate().toString());
	            row.createCell(9).setCellValue(item.getPaymentStatus());
	        }

	        // 응답 설정
	        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
	        response.setHeader("Content-Disposition", "attachment; filename=\"reservation.xlsx\"");

	        workbook.write(response.getOutputStream());
	        workbook.close();
	    }
	}