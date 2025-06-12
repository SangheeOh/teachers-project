package com.project.teachers.controller;

import com.project.teachers.entity.Payment;
import com.project.teachers.service.PaymentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/payment")
public class PaymentController {

    @Autowired
    private PaymentService paymentService;

    @PostMapping("/verify")
    public String verifyPayment(@ModelAttribute Payment request) {

        System.out.println("[PaymentController] 요청 도착");
        System.out.println("impUid: " + request.getImpUid());
        System.out.println("merchantUid: " + request.getMerchantUid());
        System.out.println("reservation_no: " + request.getReservationNo());

        Payment result = paymentService.verifyAndSavePayment(
                request.getImpUid(),
                request.getMerchantUid(),
                request.getReservationNo()
        );

        if (result != null && "paid".equals(result.getStatus())) {
            System.out.println("결제 성공! DB 저장 완료");
           return "payment/success";

        } else {
            System.out.println("결제 실패 또는 검증 실패");
            return "payment/fail";
        }
    }
}
