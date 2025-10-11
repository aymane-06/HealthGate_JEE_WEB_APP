package com.cliniqueDigitaleJEE.repository.Interfaces;

import com.cliniqueDigitaleJEE.model.Specialty;

import java.util.List;
import java.util.UUID;

public interface SpecialtyRepository {
    Specialty findById(UUID id);
    List<Specialty> findAll();
    void save(Specialty specialty);
    void update(Specialty specialty);
    void delete(UUID id);
}

