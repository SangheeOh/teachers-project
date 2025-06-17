package com.project.teachers.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;

import com.project.teachers.entity.Reservation;

@Mapper
public interface ReservationMapper {

	@Insert("INSERT INTO RESERVATION (user_no, trainer_no, day, time) VALUES (#{userNo}, #{trainerNo}, #{day}, #{time})")
	@Options(useGeneratedKeys = true, keyProperty = "reservationNo")
	void insert(Reservation reservation);

}
