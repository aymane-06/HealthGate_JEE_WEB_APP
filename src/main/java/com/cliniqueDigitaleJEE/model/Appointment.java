package com.cliniqueDigitaleJEE.model;

import com.cliniqueDigitaleJEE.model.ENUMS.AppointmentStatus;
import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.UUID;
@Entity
@Table(name = "appointments")
public class Appointment {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private UUID id;
    @Column(nullable = false, columnDefinition = "date")
    private LocalDate date;
    @Column(nullable = false, columnDefinition = "time")
    private LocalTime startTime;
    @Column(nullable = true, columnDefinition = "time")
    private LocalTime endTime;
    @Column(nullable = false)
    @Enumerated(EnumType.STRING)
    private AppointmentStatus status;
    @ManyToOne
    @JoinColumn(name = "doctor_id")
    @JsonBackReference("doctor-appointments")
    private Doctor doctor;
    @ManyToOne
    @JoinColumn(name = "patient_id")
    private Patient patient;
    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "medical_note_id")
    private MedicalNote medicalNote;
    public Appointment() {}
    public Appointment(LocalDate date, LocalTime startTime, LocalTime endTime, AppointmentStatus status, Doctor doctor, Patient patient, MedicalNote medicalNote) {
        this.date = date;
        this.startTime = startTime;
        this.endTime = endTime;
        this.status = status;
        this.doctor = doctor;
        this.patient = patient;
        this.medicalNote = medicalNote;
    }
    public UUID getId() {
        return id;
    }
    public void setId(UUID id) {
        this.id = id;
    }
    public LocalDate getDate() {
        return date;
    }
    public void setDate(LocalDate date) {
        this.date = date;
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
    public AppointmentStatus getStatus() {
        return status;
    }
    public void setStatus(AppointmentStatus status) {
        this.status = status;
    }
    public Doctor getDoctor() {
        return doctor;
    }
    public void setDoctor(Doctor doctor) {
        this.doctor = doctor;
    }
    public Patient getPatient() {
        return patient;
    }
    public void setPatient(Patient patient) {
        this.patient = patient;
    }
    public MedicalNote getMedicalNote() {
        return medicalNote;
    }
    public void setMedicalNote(MedicalNote medicalNote) {
        this.medicalNote = medicalNote;
    }


}
