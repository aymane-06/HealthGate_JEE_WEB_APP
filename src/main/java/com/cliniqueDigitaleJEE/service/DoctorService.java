package com.cliniqueDigitaleJEE.service;

import com.cliniqueDigitaleJEE.model.Doctor;
import com.cliniqueDigitaleJEE.repository.Interfaces.DoctorRepository;
import jakarta.ejb.Stateless;
import jakarta.inject.Inject;

import java.util.List;
import java.util.UUID;

@Stateless
public class DoctorService {

    @Inject
    private DoctorRepository doctorRepository;

    public List<Doctor> findAllDoctors() {
        return doctorRepository.findAll();
    }

    public Doctor findById(UUID id) {
        return doctorRepository.findById(id);
    }

    public List<Doctor> findBySpecialty(UUID specialtyId) {
        return doctorRepository.findBySpecialty(specialtyId);
    }

    public void save(Doctor doctor) {
        doctorRepository.save(doctor);
    }

    public void update(Doctor doctor) {
        doctorRepository.update(doctor);
    }

    public void delete(UUID id) {
        doctorRepository.delete(id);
    }
}

