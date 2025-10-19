package com.cliniqueDigitaleJEE.model;

import com.cliniqueDigitaleJEE.model.ENUMS.AvailabilityStatus;
import com.cliniqueDigitaleJEE.model.ENUMS.Role;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;

import java.lang.ref.Reference;
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
    @JsonManagedReference
    private Specialty specialty;
    @OneToMany(mappedBy = "doctor", cascade = CascadeType.ALL,fetch = FetchType.EAGER)
    private List<Availability> availabilities = new java.util.ArrayList<>();

    @OneToOne(mappedBy = "responsibleDoctor", fetch = FetchType.EAGER)
    private Department responsibleDepartment;

    public Doctor() {
        super();
    }


    public Doctor(String name, String email, String password, String matricule, String title) {
        super(name, email, password, Role.DOCTOR);
        this.matricule = matricule;
        this.title = title;
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
    public Department getResponsibleDepartment() {
        return responsibleDepartment;
    }

    public void setResponsibleDepartment(Department responsibleDepartment) {
        this.responsibleDepartment = responsibleDepartment;
    }

    @PrePersist
    private void assignDoctorToDepartment() {
        String[] Days={"Lundi","Mardi","Mercredi","Jeudi","Vendredi"};
        for(String day:Days){
            Availability availability=new Availability();
            availability.setDay(day);
            availability.setDoctor(this);
            availability.setStatus(AvailabilityStatus.UNAVAILABLE);
            availability.setStartTime(java.time.LocalTime.of(9,0));
            availability.setEndTime(java.time.LocalTime.of(17,0));
            this.availabilities.add(availability);
        }
    }


}
