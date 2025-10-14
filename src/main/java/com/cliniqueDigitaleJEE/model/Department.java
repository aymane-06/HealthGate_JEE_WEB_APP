package com.cliniqueDigitaleJEE.model;

import jakarta.persistence.*;

import java.time.LocalDate;
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
    @Column(columnDefinition = "BOOLEAN DEFAULT TRUE")
    private boolean isActive;
    @OneToMany(mappedBy = "department", fetch = FetchType.EAGER)
    private List<Specialty> specialties;
    @OneToOne(
        optional = true
    )
    @JoinColumn(name = "responsibleDoctor_id", referencedColumnName = "id")
    private Doctor responsibleDoctor;

    @Column(nullable = true)
    private String location;
    @Column(nullable = true)
    private String contactInfo;
    @Column(nullable = true)
    private String color;
    @Column(nullable = false, updatable = false, columnDefinition = "DATE DEFAULT CURRENT_DATE")
    private LocalDate createdAt;

    public Department() {}

    public Department(String code, String name, String description, Doctor responsibleDoctor) {
        this.code = code;
        this.name = name;
        this.description = description;
        this.responsibleDoctor = responsibleDoctor;
    }

    public UUID getId() { return id; }
    public void setId(UUID id) { this.id = id; }
    public String getCode() { return code; }
    public void setCode(String code) { this.code = code; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { this.isActive = active; }
    public List<Specialty> getSpecialties() { return specialties; }
    public void setSpecialties(List<Specialty> specialties) { this.specialties = specialties; }
    public Doctor getResponsibleDoctor() { return responsibleDoctor; }
    public void setResponsibleDoctor(Doctor responsibleDoctor) { this.responsibleDoctor = responsibleDoctor; }
    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }
    public String getContactInfo() { return contactInfo; }
    public void setContactInfo(String contactInfo) { this.contactInfo = contactInfo; }
    public String getColor() { return color; }
    public void setColor(String color) { this.color = color; }
    public LocalDate getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDate createdAt) { this.createdAt = createdAt; }

    @PrePersist
    protected void onCreate() {
        if (createdAt == null) {
            createdAt = LocalDate.now();
        }
    }
}
