package com.project.teachers.entity;

import java.time.LocalDateTime;

public class AdminReport {

	    private int reservationNo;
	    private String userName;       // 사용자 이름
	    private String trainerName;    // 강사 이름
	    private String speciality;     // 강사 소개 제목
	    private String region;         // 시/군/구 통합
	    private String day;            // 예약 요일
	    private String time;           // 예약 시간
	    private int amount;            // 결제 금액
	    private String method;         // 결제 수단
	    private String paymentType;    // 결제 유형
	    private String paymentStatus;  // 결제 상태
	    private LocalDateTime paymentDate; // 결제 일시
	    private String reservationStatus;  // 예약 상태

	    // Getter Setter
	    public int getReservationNo() {
	        return reservationNo;
	    }

	    public void setReservationNo(int reservationNo) {
	        this.reservationNo = reservationNo;
	    }

	    public String getUserName() {
	        return userName;
	    }

	    public void setUserName(String userName) {
	        this.userName = userName;
	    }

	    public String getTrainerName() {
	        return trainerName;
	    }

	    public void setTrainerName(String trainerName) {
	        this.trainerName = trainerName;
	    }

	    public String getSpeciality() {
	        return speciality;
	    }

	    public void setSpeciality(String speciality) {
	        this.speciality = speciality;
	    }

	    public String getRegion() {
	        return region;
	    }

	    public void setRegion(String region) {
	        this.region = region;
	    }

	    public String getDay() {
	        return day;
	    }

	    public void setDay(String day) {
	        this.day = day;
	    }

	    public String getTime() {
	        return time;
	    }

	    public void setTime(String time) {
	        this.time = time;
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

	    public String getPaymentStatus() {
	        return paymentStatus;
	    }

	    public void setPaymentStatus(String paymentStatus) {
	        this.paymentStatus = paymentStatus;
	    }

	    public LocalDateTime getPaymentDate() {
	        return paymentDate;
	    }

	    public void setPaymentDate(LocalDateTime paymentDate) {
	        this.paymentDate = paymentDate;
	    }

	    public String getReservationStatus() {
	        return reservationStatus;
	    }

	    public void setReservationStatus(String reservationStatus) {
	        this.reservationStatus = reservationStatus;
	    }
	}