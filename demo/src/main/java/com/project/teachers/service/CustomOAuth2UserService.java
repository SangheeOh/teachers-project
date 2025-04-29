package com.project.teachers.service;

import org.springframework.stereotype.Service;

import com.project.teachers.entity.User;
import com.project.teachers.mapper.UserMapper;

import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.DefaultOAuth2User;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;

import java.util.Collections;
import java.util.UUID;

@Service
public class CustomOAuth2UserService extends DefaultOAuth2UserService {

	@Autowired
    private UserMapper userMapper;
	
    @Override
    public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {
        
    	// 구글 사용자 정보 불러오기
        OAuth2User oAuth2User = super.loadUser(userRequest);
        
        // 구글에서 제공하는 이메일과 이름 가져오기
        String email = oAuth2User.getAttribute("email");
        String name = oAuth2User.getAttribute("name");
        
        // 사용자 이메일을 기준으로 찾기
        User user = userMapper.findByEmail(email);
        
        if (user == null) {
            // 신규 회원 등록
            user = new User();
            String baseId = email.split("@")[0];
            String generatedId = baseId;

            // 중복 id 회피를 위한 임시 로직
            while (userMapper.findByUsername(generatedId) != null) {
                generatedId = baseId + UUID.randomUUID().toString().substring(0, 5);
            }

            user.setId(generatedId); // 필수
            user.setName(name);
            user.setEmail(email);
            user.setRole("ROLE_member");
            user.setLogin_type("GOOGLE");

            userMapper.insertUser(user);
        }
        
        if ("LOCAL".equalsIgnoreCase(user.getLogin_type())) {
                throw new OAuth2AuthenticationException("일반 로그인으로 가입된 계정입니다. 다시 로그인해주세요");
        }
        

        return new DefaultOAuth2User(
            Collections.singleton(new SimpleGrantedAuthority("ROLE_member")),
            oAuth2User.getAttributes(),
            "email"
        );
    }
}