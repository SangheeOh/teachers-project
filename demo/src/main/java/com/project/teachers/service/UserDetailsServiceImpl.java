package com.project.teachers.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.project.teachers.entity.CustomUser;
import com.project.teachers.entity.User;
import com.project.teachers.mapper.UserMapper;


	@Service
	public class UserDetailsServiceImpl implements UserDetailsService{
		
		@Autowired
		UserMapper userMapper;
		
		@Override
		public UserDetails loadUserByUsername(String id) throws UsernameNotFoundException {
			
			User user = userMapper.findByUsername(id);
			
			//데이터 없을 시 예외 처리 
			if(user == null) {

				throw new UsernameNotFoundException(id + "존재하지 않습니다.");
			} 
			
			// Google 계정이면 로그인 막기
		    if ("GOOGLE".equalsIgnoreCase(user.getLogin_type())) {
		        throw new UsernameNotFoundException("이 계정은 Google 로그인으로만 로그인할 수 있습니다.");
		    }
			
			// 유저정보가 DB에 존재할 시 
			return new CustomUser(user);
		}
	

}
