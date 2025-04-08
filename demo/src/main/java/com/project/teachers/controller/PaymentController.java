package com.project.teachers.controller;

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
        // impUid, merchantUid를 Payment 객체에서 직접 꺼냄
        Payment payment = paymentService.verifyAndSavePayment(
            request.getImpUid(),
            request.getMerchantUid()
        );

        if (payment != null && "paid".equals(payment.getStatus())) {
            return ResponseEntity.ok(payment); // 결제 성공 시 결제 정보 반환
        } else {
            return ResponseEntity.badRequest().body("결제 실패 또는 결제 정보 없음");
        }
    }
}
