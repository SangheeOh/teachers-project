package com.project.teachers.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import com.project.teachers.entity.Payment;
import com.project.teachers.service.PaymentService;

@Controller
@RequestMapping("/payment")
public class PaymentController {
    
    @Autowired
    private PaymentService paymentService;

    @PostMapping("/verify")
    public String verifyPayment(@ModelAttribute Payment request) {
    	
    	//토큰 확인
        System.out.println("🔵 [PaymentController] 요청 도착");
        System.out.println("impUid: " + request.getImpUid());
        System.out.println("merchantUid: " + request.getMerchantUid());
        System.out.println("reservation_no: " + request.getReservationNo());

        Payment payment = paymentService.verifyAndSavePayment(
            request.getImpUid(),
            request.getMerchantUid(),
            request.getReservationNo()
        );

        if (payment != null && "paid".equals(payment.getStatus())) {
            
        	System.out.println("결제성공! 이제 돌아가기만 하면 돼?");
        	return "/payment/success";
        } else {
        	System.out.println("결제 실패! 이제 돌아가기만 하면 돼?");
            return "/payment/fail";
        }
    }
}