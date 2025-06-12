package com.project.teachers.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.teachers.entity.AdminReport;
import com.project.teachers.mapper.AdminMapper;

@Service
public class AdminService {

    @Autowired
    private AdminMapper adminMapper;

    public List<AdminReport> getAdminReport() {
    	
    	//System.out.println("[AdminService] getAdminReport() 호출");
    	 
        return adminMapper.getAdminReport();
    }
    
    //대시보드
    public int getTotalUserCount() {
        return adminMapper.countTotalUsers();
    }
    //대시보드
    public int getTrainerCount() {
        return adminMapper.countTrainers();
    }
    //대시보드
    public int getTodayReservationCount() {
        return adminMapper.countTodayReservations();
    }
    
}