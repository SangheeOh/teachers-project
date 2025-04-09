package com.project.teachers.entity;

import java.math.BigDecimal;
import java.sql.Timestamp;

import com.fasterxml.jackson.annotation.JsonProperty;

public class Payment {

    private int paymentNo;             // 결제 번호 (PK)
    private int reservationNo;         // 예약 번호 (foreign key)
    private int amount;				   // DECIMAL(10,2) → INT (현재는 국내만 진행하므로)
    private String method;             // 결제 방법 (ENUM)
    private String paymentType;        // 결제 유형 (ENUM)
    private String status;             // 결제 상태 (ENUM)
    private Timestamp createDate;      // 결제 생성 일시 (TIMESTAMP)

    @JsonProperty("imp_uid")
    private String impUid;             // 아임포트 결제 고유 ID

    @JsonProperty("merchant_uid")
    private String merchantUid;        // 주문 고유 ID

    public Payment() {}

    // Getters & Setters

    public int getPaymentNo() {
        return paymentNo;
    }

    public void setPaymentNo(int paymentNo) {
        this.paymentNo = paymentNo;
    }

    public int getReservationNo() {
        return reservationNo;
    }

    public void setReservationNo(int reservationNo) {
        this.reservationNo = reservationNo;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public String getMethod() {
        return method;
    }

    public void setMethod(String method) {
        this.method = method;
    }

    public String getPaymentType() {
        return paymentType;
    }

    public void setPaymentType(String paymentType) {
        this.paymentType = paymentType;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Timestamp createDate) {
        this.createDate = createDate;
    }

    public String getImpUid() {
        return impUid;
    }

    public void setImpUid(String impUid) {
        this.impUid = impUid;
    }

    public String getMerchantUid() {
        return merchantUid;
    }

    public void setMerchantUid(String merchantUid) {
        this.merchantUid = merchantUid;
    }
}
