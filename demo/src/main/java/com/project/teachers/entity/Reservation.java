package com.project.teachers.entity;

public class Reservation {
    private int reservationNo;
    private int userNo;
    private int trainerNo;
    private String day;
    private String time;

    // Getters Setters
    public int getReservationNo() {
        return reservationNo;
    }

    public void setReservationNo(int reservationNo) {
        this.reservationNo = reservationNo;
    }

    public int getUserNo() {
        return userNo;
    }

    public void setUserNo(int userNo) {
        this.userNo = userNo;
    }

    public int getTrainerNo() {
        return trainerNo;
    }

    public void setTrainerNo(int trainerNo) {
        this.trainerNo = trainerNo;
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
}
