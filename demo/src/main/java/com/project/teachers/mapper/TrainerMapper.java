package com.project.teachers.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectProvider;

import com.project.teachers.entity.Trainer;

@Mapper
public interface TrainerMapper {

	//1. 강사 목록 전체 조회용 (해당 강사 전체 list 출력, TrainerSqlProvider 불러서 조건에 따라 SQL을 동적으로 조합)
    @SelectProvider(type = TrainerSqlProvider.class, method = "buildSearchQuery")
    List<Trainer> searchTrainers(Map<String, Object> filters);

    //2. 특정 강사 한 명의 상세정보 조회용 (as로 매핑, """ 줄바꿈기능)
    @Select("""
    	    SELECT 
    	        t.trainer_no AS trainerNo,
    	        t.user_no AS userNo,
    	        u.name,
    	        speciality,
    	        experience,
    	        gender,
    	        city,
    	        district,
    	        town,
    	        days_available AS daysAvailable,
    	        time_slot AS timeSlot,
    	        afternoon,
    	        subject,
    	        content,
    	        profile_img AS profileImg,
    	        t.createdate
    	    FROM trainer t
    	    JOIN user u ON t.user_no = u.user_no
    	    WHERE t.trainer_no = #{trainerNo}
    	    
    	""")
    	Trainer findByTrainerNo(int trainerNo);

    
}
