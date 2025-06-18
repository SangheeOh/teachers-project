package com.project.teachers.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.teachers.entity.Reservation;
import com.project.teachers.service.ReservationService;

import jakarta.servlet.http.HttpSession;

@Controller
public class ReservationController {

    @Autowired
    private ReservationService reservationService;

    @GetMapping("/reserve")
    public String reserve(@RequestParam("trainer_no") int trainerNo,
                          @RequestParam("day") String day,
                          @RequestParam("time") String time,
                          HttpSession session, Model model) {
    	
    	//System.out.println("예약 도착! trainerNo = " + trainerNo + ", day = " + day + ", time = " + time);

        Integer userNo = (Integer) session.getAttribute("user_no");
        if (userNo == null) {
            return "fa";
        }

        Reservation reservation = new Reservation();
        reservation.setUserNo(userNo);
        reservation.setTrainerNo(trainerNo);
        reservation.setDay(day);
        reservation.setTime(time);

        reservationService.insertReservation(reservation); //reservationNo 채워짐
        
        //System.out.println("reservationNo 저장완료: " + reservation.getReservationNo());
        
        model.addAttribute("reservationNo", reservation.getReservationNo());

        
        return "payment/reservation";
        //return "redirect:/payment/reserveno?reservationNo=" + reservation.getReservationNo();
       
    }
}
