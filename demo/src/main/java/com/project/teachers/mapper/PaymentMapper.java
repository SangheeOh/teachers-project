package com.project.teachers.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.annotations.Delete;

import com.project.teachers.entity.Payment;

@Mapper
public interface PaymentMapper {

    // 1. 결제 정보 조회 (PK로 단건 조회)
    @Select("SELECT * FROM PAYMENT WHERE payment_id = #{paymentId}")
    Payment selectPaymentById(int paymentId);

    // 2. 결제 정보 삽입 (created_at은 DB에서 자동 생성)
    @Insert("INSERT INTO PAYMENT (reservation_no, amount, method, payment_type, status, imp_uid, merchant_uid) " +
            "VALUES (#{reservationNo}, #{amount}, #{method}, #{paymentType}, #{status}, #{impUid}, #{merchantUid})")
    void insertPayment(Payment payment);

    // 3. 결제 정보 업데이트 (필요 시 사용)
    @Update("UPDATE PAYMENT " +
            "SET amount = #{amount}, method = #{method}, payment_type = #{paymentType}, status = #{status} " +
            "WHERE payment_id = #{paymentId}")
    void updatePayment(Payment payment);

    // 4. 결제 정보 삭제 (관리용)
    @Delete("DELETE FROM PAYMENT WHERE payment_id = #{paymentId}")
    void deletePayment(int paymentId);
}
