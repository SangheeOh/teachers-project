package com.project.teachers.service;

import java.util.List;
import java.util.Map;

import com.project.teachers.entity.Trainer;

public interface TrainerService {
    List<Trainer> searchTrainers(Map<String, Object> filters); // ✅ 수정
}