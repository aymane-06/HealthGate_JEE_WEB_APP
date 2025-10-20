package com.cliniqueDigitaleJEE.dto;

import java.util.UUID;

public class DoctorDTO {
    private UUID id;
    private String name;
    private String email;
    private String title;
    private SpecialtyDTO specialty;

    public DoctorDTO() {}

    public DoctorDTO(UUID id, String name, String email, String title, SpecialtyDTO specialty) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.title = title;
        this.specialty = specialty;
    }

    public UUID getId() { return id; }
    public void setId(UUID id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public SpecialtyDTO getSpecialty() { return specialty; }
    public void setSpecialty(SpecialtyDTO specialty) { this.specialty = specialty; }
}