package com.project.teachers.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.project.teachers.entity.Menu;

@Mapper
public interface MenuMapper {
	
	@Insert("INSERT INTO backend_spring_project.menu(memID,title) VALUES (#{memID},#{title})")
	void insertMenu(Menu menu);
	
	@Select("SELECT memID,title FROM backend_spring_project.menu")
	 ArrayList<Menu> selectMenu();
	
}


