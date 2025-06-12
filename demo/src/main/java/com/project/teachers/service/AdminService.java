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
        return adminMapper.getAdminReport();
    }
}