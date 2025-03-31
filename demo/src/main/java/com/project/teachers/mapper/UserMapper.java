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
	
}


