package com.project.teachers.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.teachers.entity.MypageReport;
import com.project.teachers.mapper.MypageMapper;

@Service
public class MypageService {

    @Autowired
    private MypageMapper mypageMapper;
    
    public List<MypageReport> getMyReservationReport(int userNo) {
    	
    	 System.out.println("[MypageService] getMyReservationReport() 호출 - userNo: " + userNo);
    	
    	 List<MypageReport> list = mypageMapper.getMyReservationReport(userNo);
    	 
    	 System.out.println("[MypageService] Mapper 조회 결과 건수: " + list.size());
    	
    	 return list;
    }
}
