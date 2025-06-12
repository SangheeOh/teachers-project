package com.project.teachers.mapper;

import java.util.Map;

public class TrainerSqlProvider {

    public String buildSearchQuery(Map<String, Object> filters) {
        System.out.println("[Provider] buildSearchQuery 실행");
        System.out.println("받은 filters (원본): " + filters);

        // 1. 성별 필터 가공 처리
        if (filters.get("gender") != null) {
            String gender = filters.get("gender").toString().trim();
            if (gender.equals("여성")) {
                filters.put("gender", "F");
            } else if (gender.equals("남성")) {
                filters.put("gender", "M");
            }
        }

        System.out.println("필터 후 (성별 변환 적용): " + filters);

        // 2. SQL 쿼리 빌드
        StringBuilder sql = new StringBuilder();  //문자열을 효율적으로 붙이기 위해 StringBuilder 사용

        // snake_case 컬럼들에 AS 작업을 해야 Trainer.java 필드와 정확히 매핑 (아니면 PROPERTIES 설정하면됨)
        sql.append("SELECT ");
        sql.append("trainer_no AS trainerNo, ");
        sql.append("user_no As userNo, ");
        sql.append("speciality, ");
        sql.append("experience, ");
        sql.append("gender, ");
        sql.append("city, ");
        sql.append("district, ");
        sql.append("town, ");
        sql.append("days_available As daysAvailable, ");
        sql.append("time_slot As timeSlot, ");
        sql.append("afternoon, ");
        sql.append("subject, ");
        sql.append("content, ");
        sql.append("profile_img AS profileImg, "); // 이부분중요
        sql.append("createdate ");
        sql.append("FROM trainer WHERE 1=1"); //이후 조건들을 AND로만 붙일 수 있게 WHERE

        if (filters.get("city") != null && !filters.get("city").toString().trim().isEmpty()) {
            sql.append(" AND city = #{city}"); //조건이 있을 때만 AND 필드명 = #{값} 을 붙이고
        }
        if (filters.get("district") != null && !filters.get("district").toString().trim().isEmpty()) {
            sql.append(" AND district = #{district}");
        }
        if (filters.get("town") != null && !filters.get("town").toString().trim().isEmpty()) {
            sql.append(" AND town = #{town}");
        }
        if (filters.get("speciality") != null && !filters.get("speciality").toString().trim().isEmpty()) {
            sql.append(" AND speciality = #{speciality}");
        }
        if (filters.get("gender") != null && !filters.get("gender").toString().trim().isEmpty()) {
            sql.append(" AND gender = #{gender}");
        }

        System.out.println("최종 SQL: " + sql.toString());

        return sql.toString();
    }
}
