package com.cliniqueDigitaleJEE.service;

import com.cliniqueDigitaleJEE.model.Specialty;
import com.cliniqueDigitaleJEE.repository.Interfaces.SpecialtyRepository;
import jakarta.ejb.Stateless;
import jakarta.inject.Inject;

import java.util.List;
import java.util.UUID;

@Stateless
public class SpecialtyService {

    @Inject
    private SpecialtyRepository specialtyRepository;

    public List<Specialty> findAllSpecialties() {
        return specialtyRepository.findAll();
    }

    public Specialty findById(UUID id) {
        return specialtyRepository.findById(id);
    }

    public void save(Specialty specialty) {
        specialtyRepository.save(specialty);
    }

    public void update(Specialty specialty) {
        specialtyRepository.update(specialty);
    }

    public void delete(UUID id) {
        specialtyRepository.delete(id);
    }
}

