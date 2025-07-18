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

	

	//테스트
	public void insertUser(User user) {
		userMapper.insertUser(user);
	}
	//테스트
	public String findWriter(String id) {
		return userMapper.findWriter(id);
	}


}