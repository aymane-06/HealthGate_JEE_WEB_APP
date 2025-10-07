package com.cliniqueDigitaleJEE.model;

import com.cliniqueDigitaleJEE.model.ENUMS.Role;
import jakarta.persistence.*;

import java.util.List;
@Entity
@Table(name = "doctors")
public class Doctor extends User{
    @Column(unique = true, nullable = false)
    private String matricule;
    @Column(nullable = true, columnDefinition = "varchar(255)")
    private String title;
    @ManyToOne
    @JoinColumn(name = "specialty_id", nullable = true)
    private Specialty specialty;
    @OneToMany(mappedBy = "doctor", cascade = CascadeType.ALL,fetch = FetchType.EAGER)
    private List<Availability> availabilities;

    public Doctor() {}

    public Doctor(String name, String email, String password, Role role, String matricule, String title, Specialty specialty) {
        super(name, email, password, role);
        this.matricule = matricule;
        this.title = title;
        this.specialty = specialty;
    }
    public List<Availability> getAvailabilities() {
        return availabilities;
    }
    public void setAvailabilities(List<Availability> availabilities) {
        this.availabilities = availabilities;
    }

    public String getMatricule() {
        return matricule;
    }

    public void setMatricule(String matricule) {
        this.matricule = matricule;
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
}
