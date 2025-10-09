package com.cliniqueDigitaleJEE.dto;

import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

import com.cliniqueDigitaleJEE.model.Availability;
import com.cliniqueDigitaleJEE.model.Specialty;
import com.cliniqueDigitaleJEE.model.ENUMS.Gender;
import com.cliniqueDigitaleJEE.model.ENUMS.Role;
import com.cliniqueDigitaleJEE.model.User;
import com.cliniqueDigitaleJEE.model.Doctor;
import com.cliniqueDigitaleJEE.model.Patient;
import com.cliniqueDigitaleJEE.model.STAFF;

public class UserDTO {
    private UUID id;
    private String name;
    private String email;
    private Role role;
    private String title;
    
    //Doctor
    private Specialty specialty;
    private String matricule;
    private List<Availability> availabilities;
    
    //Patient
    private String cin;
    private String address;
    private String phone;
    private LocalDate birthDate;
    private Gender gender;
    private String bloodType;
    
    //Staff
    private String position;
    private String employeeId;

    public UserDTO() {}

    public UserDTO(User user) {
        this.id = user.getId();
        this.name = user.getName();
        this.email = user.getEmail();
        this.role = user.getRole();
        
        if (user instanceof Doctor) {
            Doctor doctor = (Doctor) user;
            this.specialty = doctor.getSpecialty();
            this.matricule = doctor.getMatricule();
            this.title = doctor.getTitle();
            this.availabilities = doctor.getAvailabilities();
        } else if (user instanceof Patient) {
            Patient patient = (Patient) user;
            this.cin = patient.getCIN();
            this.address = patient.getAddress();
            this.phone = patient.getPhone();
            this.birthDate = patient.getBirthDate();
            this.gender = patient.getGender();
            this.bloodType = patient.getBloodType();
        } else if (user instanceof STAFF) {
            STAFF staff = (STAFF) user;
            this.position = staff.getPosition();
            this.employeeId = staff.getEmployeeId();
        }
    }

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Specialty getSpecialty() {
        return specialty;
    }

    public void setSpecialty(Specialty specialty) {
        this.specialty = specialty;
    }

    public String getMatricule() {
        return matricule;
    }

    public void setMatricule(String matricule) {
        this.matricule = matricule;
    }

    public List<Availability> getAvailabilities() {
        return availabilities;
    }

    public void setAvailabilities(List<Availability> availabilities) {
        this.availabilities = availabilities;
    }

    public String getCin() {
        return cin;
    }

    public void setCin(String cin) {
        this.cin = cin;
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

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public String getEmployeeId() {
        return employeeId;
    }

    public void setEmployeeId(String employeeId) {
        this.employeeId = employeeId;
    }
}
