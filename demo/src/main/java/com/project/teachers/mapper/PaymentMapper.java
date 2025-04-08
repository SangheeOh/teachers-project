	package com.project.teachers.mapper;
	
	
	import org.apache.ibatis.annotations.Insert;
	import org.apache.ibatis.annotations.Select;
	import org.apache.ibatis.annotations.Update;
	
	import com.project.teachers.entity.Payment;
	
	import org.apache.ibatis.annotations.Delete;
	
	public interface PaymentMapper {
		
	    // 결제 정보 조회 (payment_no로 결제 정보 조회)
	    @Select("SELECT * FROM PAYMENT WHERE payment_no = #{payment_no}")
	    Payment selectPaymentById(int payment_no);
	    
	    // 결제 정보 삽입
	    @Insert("INSERT INTO PAYMENT (reservation_no, amount, method, payment_type, status, createdate, imp_uid, merchant_uid) " +
	            "VALUES (#{reservation_no}, #{amount}, #{method}, #{payment_type}, #{status}, #{createdate}, #{impUid}, #{merchantUid})")
	    void insertPayment(Payment payment);
	
	    // 결제 정보 업데이트
	    @Update("UPDATE PAYMENT " +
	            "SET amount = #{amount}, method = #{method}, payment_type = #{payment_type}, status = #{status} " +
	            "WHERE payment_no = #{payment_no}")
	    void updatePayment(Payment payment);
	
	    // 결제 정보 삭제
	    @Delete("DELETE FROM PAYMENT WHERE payment_no = #{payment_no}")
	    void deletePayment(int payment_no);
	
	}
	
	
