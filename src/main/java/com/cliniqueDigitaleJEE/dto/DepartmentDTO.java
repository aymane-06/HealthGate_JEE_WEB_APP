package com.cliniqueDigitaleJEE.dto;

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
    public UUID headDoctorId;
}

