package com.project.teachers.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.teachers.entity.Menu;
import com.project.teachers.mapper.MenuMapper;

@Service
public class MenuService {
	
	@Autowired
	private MenuMapper menuMapper;
	
	public void insertMenu(Menu menu) {
		menuMapper.insertMenu(menu);
	}
	
	public ArrayList<Menu> selectMenu() {
		return menuMapper.selectMenu();
	}

	



}
