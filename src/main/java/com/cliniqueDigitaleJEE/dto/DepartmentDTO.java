package com.cliniqueDigitaleJEE.dto;

import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

public class DepartmentDTO {
    public UUID id;
    public String code;
    public String name;
    public String description;
    public boolean isActive;
    public String location;
    public String contactInfo;
    public String color;
    public List<UUID> specialties;
    public LocalDate createdAt;


    public LocalDate getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDate createdAt) {
        this.createdAt = createdAt;
    }


    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getContactInfo() {
        return contactInfo;
    }

    public void setContactInfo(String contactInfo) {
        this.contactInfo = contactInfo;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public List<UUID> getSpecialties() {
        return specialties;
    }

    public void setSpecialties(List<UUID> specialties) {
        this.specialties = specialties;
    }

    public UUID getHeadDoctorId() {
        return headDoctorId;
    }

    public void setHeadDoctorId(UUID headDoctorId) {
        this.headDoctorId = headDoctorId;
    }

    public Integer getDoctorCount() {
        return doctorCount;
    }

    public void setDoctorCount(Integer doctorCount) {
        this.doctorCount = doctorCount;
    }

    public UUID headDoctorId;
    public Integer doctorCount = 0;
}

