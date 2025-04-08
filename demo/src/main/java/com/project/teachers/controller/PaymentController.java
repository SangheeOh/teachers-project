package com.project.teachers.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.project.teachers.entity.Payment;
import com.project.teachers.service.PaymentService;

@RestController
@RequestMapping("/payment")
public class PaymentController {
	
    @Autowired
    private PaymentService paymentService;

    @PostMapping("/verify")
    public ResponseEntity<?> verifyPayment(@RequestBody Payment request) {
        
    	//콘솔 확인하기
    	System.out.println("🔵 [PaymentController] 요청 도착");
        System.out.println("impUid: " + request.getImpUid());
        System.out.println("merchantUid: " + request.getMerchantUid());
        System.out.println("reservation_no: " + request.getReservation_no());
    	
    	
    	// impUid, merchantUid를 Payment 객체에서 직접 꺼냄
        Payment payment = paymentService.verifyAndSavePayment(
            request.getImpUid(),
            request.getMerchantUid(),
            request.getReservation_no() //예약정보도 넘겨야함
        );

        if (payment != null && "paid".equals(payment.getStatus())) {
        	return ResponseEntity.ok(Map.of("status", "paid")); 
        } else {
        	 return ResponseEntity.ok(Map.of("status", "fail"));
        }
    }
}
