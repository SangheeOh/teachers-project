package com.project.teachers.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.project.teachers.entity.AdminReport;

@Mapper
public interface AdminMapper {

	 // 예약/결제 현황 전체 조회
	@Select("""
		    SELECT 
		        r.reservation_no,
		        u.name AS userName,
		        tu.name AS trainerName,  -- trainer의 이름은 user 테이블에서 가져와야 함
		        t.subject,
		        CONCAT(t.city, ' ', t.district, ' ', t.town) AS region,
		        r.day,
		        r.time,
		        p.amount,
		        p.method,
		        p.payment_type,
		        p.status AS paymentStatus,
		        p.createdate AS paymentDate,
		        r.status AS reservationStatus
		    FROM RESERVATION r
		    JOIN USER u ON r.user_no = u.user_no
		    JOIN TRAINER t ON r.trainer_no = t.trainer_no
		    JOIN USER tu ON t.user_no = tu.user_no   -- 트레이너 유저 이름 조인
		    JOIN PAYMENT p ON p.reservation_no = r.reservation_no
		    ORDER BY p.createdate DESC
		""")
		List<AdminReport> getAdminReport();
}