package com.project.teachers.mapper;


import java.util.ArrayList;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.project.teachers.entity.User;


@Mapper
public interface UserMapper {
	
	@Select("SELECT * FROM teachers_db.user")
	 ArrayList<User> selectUser();
	
	//회원가입
	@Insert("INSERT INTO teachers_db.user(id, pwd, name, email, phone, role)"
	        + " VALUES(#{id}, #{pwd}, #{name}, #{email}, #{phone}, #{role})")
			void insertUser(User user); // 사용 함수
	
	// read
	@Select("SELECT * FROM teachers_db.user WHERE id=#{id}")
	User findByUsername(String id); // username 가지고 옴 
	 
	@Select("SELECT name FROM teachers_db.user WHERE id=#{id}")
	String findWriter(String id); // writer 가져옴
	
//	@Update()
//	@Delete()
	
}


