package com.project.teachers.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.teachers.entity.Menu;
import com.project.teachers.entity.User;
import com.project.teachers.mapper.MenuMapper;
import com.project.teachers.mapper.UserMapper;

@Service
public class UserService {
	
	@Autowired
	private UserMapper userMapper;
	
	public ArrayList<User> selectUser() {
		return userMapper.selectUser();
	}

	



}