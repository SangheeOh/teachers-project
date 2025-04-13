package com.project.teachers.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.teachers.entity.Trainer;
import com.project.teachers.mapper.TrainerMapper;

@Service
public class TrainerServiceImpl implements TrainerService {

    @Autowired
    private TrainerMapper trainerMapper;

    //강사검색 후 전체조회
    @Override
    public List<Trainer> searchTrainers(Map<String, Object> filters) { // ✅ 수정
    	
    	System.out.println("📌 [Service] searchTrainers 호출됨");
    	
        return trainerMapper.searchTrainers(filters);
    }
    
    //강사 상세조회
    @Override
    public Trainer getTrainerDetail(int trainerNo) {
    	
    	System.out.println("✅ [Service] 전달받은 trainerNo: " + trainerNo);
    	
    	Trainer trainer = trainerMapper.findByTrainerNo(trainerNo);
    	
    	System.out.println("✅ [Service] 매퍼에서 받은 trainer: " + trainer);
        
    	return trainerMapper.findByTrainerNo(trainerNo);
    }
}