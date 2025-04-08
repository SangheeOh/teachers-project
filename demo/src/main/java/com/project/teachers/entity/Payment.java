package com.project.teachers.entity;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Payment {

    private int payment_no;       // 결제 번호 (PK)
    private int reservation_no;   // 예약 번호 (foreign key)
    private BigDecimal amount;    // 결제 금액 (DECIMAL(10, 2)로 매핑)
    private String method;        // 결제 방법 (ENUM)
    private String payment_type;  // 결제 유형 (ENUM)
    private String status;        // 결제 상태 (ENUM)
    private Timestamp createdate; // 결제 생성 일시 (TIMESTAMP)

    private String impUid;        // 아임포트 결제 고유 ID
    private String merchantUid;   // 주문 고유 ID

    // 기본 생성자
    public Payment() {}

    // Getter 및 Setter
    public int getPayment_no() {
        return payment_no;
    }

    public void setPayment_no(int payment_no) {
        this.payment_no = payment_no;
    }

    public int getReservation_no() {
        return reservation_no;
    }

    public void setReservation_no(int reservation_no) {
        this.reservation_no = reservation_no;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public String getMethod() {
        return method;
    }

    public void setMethod(String method) {
        this.method = method;
    }

    public String getPayment_type() {
        return payment_type;
    }

    public void setPayment_type(String payment_type) {
        this.payment_type = payment_type;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getCreatedate() {
        return createdate;
    }

    public void setCreatedate(Timestamp createdate) {
        this.createdate = createdate;
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
