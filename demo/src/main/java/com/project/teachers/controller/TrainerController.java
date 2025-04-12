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
        
        System.out.println("✅ 검색 결과 trainer 수: " + trainerList.size());
        
        model.addAttribute("trainers", trainerList);

        return "trainer/searchResult"; //too many~ 오류 방지: 바로 jsp에 보내지 않음

    }
}
