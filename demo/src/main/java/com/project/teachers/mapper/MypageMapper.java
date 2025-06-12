package com.project.teachers.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.project.teachers.entity.MypageReport;

@Mapper
public interface MypageMapper {

    @Select("""
        SELECT 
            tu.name AS trainerName,
            t.speciality,
            CONCAT(t.city, ' ', t.district, ' ', t.town) AS region,
            r.day,
            r.time,
            p.amount,
            p.method,
            p.status AS paymentStatus,
            p.createdate AS paymentDate,
            r.status AS reservationStatus
        FROM RESERVATION r
        JOIN TRAINER t ON r.trainer_no = t.trainer_no
        JOIN USER tu ON t.user_no = tu.user_no
        JOIN PAYMENT p ON p.reservation_no = r.reservation_no
        WHERE r.user_no = #{userNo}
        ORDER BY p.createdate DESC
    """)
    List<MypageReport> getMyReservationReport(@Param("userNo") int userNo);
}