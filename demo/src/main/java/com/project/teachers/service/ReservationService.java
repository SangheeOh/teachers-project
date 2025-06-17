package com.project.teachers.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.teachers.entity.Reservation;
import com.project.teachers.mapper.ReservationMapper;

@Service
public class ReservationService {

    @Autowired
    private ReservationMapper reservationMapper;

    public void insertReservation(Reservation reservation) {
        reservationMapper.insert(reservation);
    }
}