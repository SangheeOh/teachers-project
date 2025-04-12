package com.project.teachers.securityConfig;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addViewControllers(ViewControllerRegistry registry) {
        // "/su.jsp" 요청이 오면 "su" 뷰 이름을 찾아감 → /WEB-INF/views/su.jsp
        registry.addViewController("/su").setViewName("su");
    }
}