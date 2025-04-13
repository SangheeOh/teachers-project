package com.project.teachers.service;

import java.util.List;
import java.util.Map;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.teachers.entity.Trainer;

	//강사검색 후 전체조회
	public interface TrainerService {
		
		//강사검색 후 전체조회
	    List<Trainer> searchTrainers(Map<String, Object> filters); 
	    
		// 강사 상세 조회
	    Trainer getTrainerDetail(int trainerNo);
	}
	
	