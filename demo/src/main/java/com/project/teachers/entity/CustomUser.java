package com.project.teachers.entity;

import org.springframework.security.core.authority.AuthorityUtils;

public class CustomUser extends org.springframework.security.core.userdetails.User {
	
	private User user;
	
	// 받아온 user 정보를 core.User(스프링 프레임워크 기능)에 넣는 작업 
	public CustomUser(User user) {
		super(user.getId(), user.getPwd(), AuthorityUtils.createAuthorityList(user.getRole().toString()));
	}
	
}