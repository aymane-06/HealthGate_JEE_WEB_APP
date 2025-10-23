package com.cliniqueDigitaleJEE.model;

import com.cliniqueDigitaleJEE.model.ENUMS.Gender;
import com.cliniqueDigitaleJEE.model.ENUMS.Role;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;

import java.time.LocalDate;
import java.util.List;

@Entity
@Table(name = "patients")
public class Patient extends User{
    @Column(unique = true, nullable = false)
    private String CIN;
    @Column(nullable = true, columnDefinition = "TEXT")
    private String address;
    @Column(nullable = true)
    private String phone;
    @Column(nullable = true, columnDefinition = "date")
    private LocalDate birthDate;
    @Enumerated(EnumType.STRING)
    @Column(nullable = true)
    private Gender gender;
    @Column(nullable = true)
    private String bloodType;
    @OneToMany(mappedBy = "patient", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @JsonManagedReference
    private List<Appointment> appointments;






    public Patient() {}

    public Patient(String name, String email, String password, String CIN, String address, String phone, LocalDate birthDate, Gender gender, String bloodType) {
        super(name, email, password, Role.PATIENT);
        this.CIN = CIN;
        this.address = address;
        this.phone = phone;
        this.birthDate = birthDate;
        this.gender = gender;
        this.bloodType = bloodType;
    }

    public String getCIN() {
        return CIN;
    }

    public void setCIN(String CIN) {
        this.CIN = CIN;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public LocalDate getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(LocalDate birthDate) {
        this.birthDate = birthDate;
    }

    public Gender getGender() {
        return gender;
    }

    public void setGender(Gender gender) {
        this.gender = gender;
    }

    public String getBloodType() {
        return bloodType;
    }

    public void setBloodType(String bloodType) {
        this.bloodType = bloodType;
    }

    public List<Appointment> getAppointments() {
        return appointments;
    }

    public void setAppointments(List<Appointment> appointments) {
        this.appointments = appointments;
    }
}
