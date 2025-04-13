package com.project.teachers.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectProvider;

import com.project.teachers.entity.Trainer;

@Mapper
public interface TrainerMapper {

	//강사 검색 후 전체 list 출력
    @SelectProvider(type = TrainerSqlProvider.class, method = "buildSearchQuery")
    List<Trainer> searchTrainers(Map<String, Object> filters);
    
    //강사 상세조회
    //@Select("SELECT * FROM trainer WHERE trainer_no = #{trainerNo}")
    //Trainer findByTrainerNo(int trainerNo);
    
    //강사 상세조회(as로 매핑)
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
