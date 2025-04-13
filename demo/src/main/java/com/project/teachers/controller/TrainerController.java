package com.project.teachers.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.teachers.entity.Trainer;
import com.project.teachers.service.TrainerService;

@Controller
public class TrainerController {

    @Autowired
    private TrainerService trainerService;

    //강사 검색 후 전체 list 출력
    @GetMapping("/search")
    public String searchTrainers(
            @RequestParam(required = false) String city,
            @RequestParam(required = false) String district,
            @RequestParam(required = false) String town,
            @RequestParam(required = false) String speciality,
            @RequestParam(required = false) String gender,
            Model model
    ) {
    	
    	//로그 확인
    	 System.out.println("📌 [Controller] /search 요청 도착");
    	 
    	 
    	 System.out.println("✅ city: " + city);
    	 System.out.println("✅ district: " + district);
    	 System.out.println("✅ town: " + town);
    	 System.out.println("✅ speciality: " + speciality);
    	 System.out.println("✅ gender: " + gender);
    	    
        Map<String, Object> filters = new HashMap<>(); // ✅ 수정: Object로 바꿈
        filters.put("city", city);
        filters.put("district", district);
        filters.put("town", town);
        filters.put("speciality", speciality);
        filters.put("gender", gender);
        //filters.put("category", category); 시간대 검색 허용안함

        List<Trainer> trainerList = trainerService.searchTrainers(filters);
        
        // 로그 출력(강사수)
        System.out.println("✅ 검색 결과 trainer 수: " + trainerList.size());
        // 로그 출력(강사 리스트)
        System.out.println("👉 Trainer 리스트 확인:");
        for (Trainer t : trainerList) {
            System.out.println("TrainerNo: " + t.getTrainerNo() + " / Speciality: " + t.getSpeciality());
        }
        
        model.addAttribute("trainers", trainerList);

        return "trainer/searchResult"; //too many~ 오류 방지: 바로 jsp에 보내지 않음

    }
    
    //강사 상세 조회
    @GetMapping("/trainerdetails")
    public String trainerDetail(@RequestParam("trainerNo") int trainerNo, Model model) {
    	
    	//System.out.println("전달받은 trainerNo: " + trainerNo);  
        
    	Trainer trainerdetails = trainerService.getTrainerDetail(trainerNo);
    	
    	//System.out.println("✅ [Controller] 서비스에서 받은 trainerdetails: " + trainerdetails);
        
    	model.addAttribute("trainerdetails", trainerdetails);
    	
    	//jsp에서 배열 얻기 위해 
    	model.addAttribute("timeSlots", trainerdetails.getTimeSlot());
    	model.addAttribute("daysAvailable", trainerdetails.getDaysAvailable());
        
    	return "trainer/trainerdetails";  // trainerdetails.jsp 로 이동
    }
    
    
    
}
