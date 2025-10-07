package com.cliniqueDigitaleJEE.model;

import jakarta.persistence.*;
import com.cliniqueDigitaleJEE.model.ENUMS.AvailabilityStatus;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.UUID;

@Entity
@Table(name = "availabilities")
public class Availability {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private UUID id;
    @Column(nullable = false)
    @Enumerated(EnumType.STRING)
    private AvailabilityStatus status;
    @ManyToOne
    @JoinColumn(name = "doctor_id", nullable = false)
    private Doctor doctor;
    @Column(nullable = false, columnDefinition = "date")
    private LocalDate day;
    @Column(nullable = false, columnDefinition = "time")
    private LocalTime startTime;
    @Column(nullable = false, columnDefinition = "time")
    private LocalTime endTime;

    public Availability() {}

    public Availability(AvailabilityStatus status, Doctor doctor, LocalDate day, LocalTime startTime, LocalTime endTime) {
        this.status = status;
        this.doctor = doctor;
        this.day = day;
        this.startTime = startTime;
        this.endTime = endTime;
    }

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public AvailabilityStatus getStatus() {
        return status;
    }

    public void setStatus(AvailabilityStatus status) {
        this.status = status;
    }

    public Doctor getDoctor() {
        return doctor;
    }

    public void setDoctor(Doctor doctor) {
        this.doctor = doctor;
    }

    public LocalDate getDay() {
        return day;
    }

    public void setDay(LocalDate day) {
        this.day = day;
    }

    public LocalTime getStartTime() {
        return startTime;
    }

    public void setStartTime(LocalTime startTime) {
        this.startTime = startTime;
    }

    public LocalTime getEndTime() {
        return endTime;
    }

    public void setEndTime(LocalTime endTime) {
        this.endTime = endTime;
    }
}
