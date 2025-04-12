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

    @Override
    public List<Trainer> searchTrainers(Map<String, Object> filters) { // ✅ 수정
    	
    	System.out.println("📌 [Service] searchTrainers 호출됨");
    	
        return trainerMapper.searchTrainers(filters);
    }
}