package com.project.teachers.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.annotations.Delete;

import com.project.teachers.entity.Payment;

public interface PaymentMapper {

    // 결제 정보 조회 (paymentNo로 결제 정보 조회)
    @Select("SELECT * FROM PAYMENT WHERE payment_no = #{paymentNo}")
    Payment selectPaymentById(int paymentNo);

    // 결제 정보 삽입
    @Insert("INSERT INTO PAYMENT (reservation_no, amount, method, payment_type, status, imp_uid, merchant_uid) " +
            "VALUES (#{reservationNo}, #{amount}, #{method}, #{paymentType}, #{status}, #{impUid}, #{merchantUid})")
    void insertPayment(Payment payment);

    // 결제 정보 업데이트
    @Update("UPDATE PAYMENT " +
            "SET amount = #{amount}, method = #{method}, payment_type = #{paymentType}, status = #{status} " +
            "WHERE payment_no = #{paymentNo}")
    void updatePayment(Payment payment);

    // 결제 정보 삭제
    @Delete("DELETE FROM PAYMENT WHERE payment_no = #{paymentNo}")
    void deletePayment(int paymentNo);
}
