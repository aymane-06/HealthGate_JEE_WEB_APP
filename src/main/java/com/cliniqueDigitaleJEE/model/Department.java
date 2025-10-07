package com.cliniqueDigitaleJEE.model;

import jakarta.persistence.*;


import java.util.List;
import java.util.UUID;
@Entity
@Table(name = "departments")
public class Department {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private UUID id;
    @Column(unique = true, nullable = false)
    private String code;
    @Column(nullable = false)
    private String name;
    @Column(nullable = true, columnDefinition = "TEXT")
    private String description;
    @OneToMany(mappedBy = "department")
    private List<Specialty> specialties;

    public Department() {}
    public Department(String code, String name, String description) {
        this.code = code;
        this.name = name;
        this.description = description;
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

    public List<Specialty> getSpecialties() {
        return specialties;
    }

    public void setSpecialties(List<Specialty> specialties) {
        this.specialties = specialties;
    }
}
