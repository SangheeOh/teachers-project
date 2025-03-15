package com.project.teachers.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.project.teachers.entity.Menu;

@Mapper
public interface MenuMapper {
	
	@Select("SELECT memID,title FROM backend_spring_project.menu")
	public Menu findbyMenu();
	
	@Insert("INSERT INTO backend_spring_project.menu(memID,title) VALUES (#{memID},#{title})")
	void insertMenu(Menu menu);
}


