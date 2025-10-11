package com.cliniqueDigitaleJEE.repository.Interfaces;

import com.cliniqueDigitaleJEE.model.Doctor;

import java.util.List;
import java.util.UUID;

public interface DoctorRepository {
    Doctor findById(UUID id);
    List<Doctor> findAll();
    List<Doctor> findBySpecialty(UUID specialtyId);
    void save(Doctor doctor);
    void update(Doctor doctor);
    void delete(UUID id);
}

