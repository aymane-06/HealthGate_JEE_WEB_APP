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
    public String getTime() {
        return startTime != null ? startTime.toString() : "";
    }
    public String getLocation() {
        // You can customize this to return a real location if needed
        return doctor != null && doctor.getLocation() != null ? doctor.getLocation() : "";
    }
    
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
    @JsonBackReference("patient-appointments")
    private Patient patient;
    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "medical_note_id")
    private MedicalNote medicalNote;
    @Column(nullable = true, columnDefinition = "TEXT")
    private String remarks;
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
    public String getType() {
        // You can customize this to return a real type if needed
        return "Consultation";
    }
    public String getDoctorName() {
        return doctor != null ? doctor.getName() : "";
    }
    // For JSP rendering: get day and month as string
    public String getDay() {
        return date != null ? String.valueOf(date.getDayOfMonth()) : "";
    }
    public String getMonth() {
        return date != null ? date.getMonth().name().substring(0, 3) : "";
    }
    public String getRemarks() {
        return remarks;
    }
    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }


}
