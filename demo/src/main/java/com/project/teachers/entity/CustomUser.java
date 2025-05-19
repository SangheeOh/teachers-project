package com.project.teachers.entity;

import org.springframework.security.core.authority.AuthorityUtils;

public class CustomUser extends org.springframework.security.core.userdetails.User {
	
	private User user;
	
	// 받아온 user 정보를 core.User(스프링 프레임워크 기능)에 넣는 작업 
	public CustomUser(User user) {
		super(user.getId(), user.getPwd(), AuthorityUtils.createAuthorityList(user.getRole().toString()));
		
		this.user = user; // 아래 getter 사용을 위해
	}
	
		// id 말고 메인화면에서 name으로 팝업 띄우기 위해 getter 추가
		public User getUser() {
			return user;
		}
		
		 public String getRole() {
		        return user.getRole(); // 내부 user에서 role 가져오기
		 }
	
}