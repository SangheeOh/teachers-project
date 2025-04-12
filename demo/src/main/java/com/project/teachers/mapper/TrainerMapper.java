package com.project.teachers.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.SelectProvider;

import com.project.teachers.entity.Trainer;

@Mapper
public interface TrainerMapper {

    @SelectProvider(type = TrainerSqlProvider.class, method = "buildSearchQuery")
    List<Trainer> searchTrainers(Map<String, Object> filters);
}
