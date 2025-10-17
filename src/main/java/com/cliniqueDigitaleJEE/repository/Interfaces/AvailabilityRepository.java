package com.cliniqueDigitaleJEE.repository.Interfaces;

import com.cliniqueDigitaleJEE.model.Appointment;
import com.cliniqueDigitaleJEE.model.Availability;

import java.util.List;
import java.util.UUID;

public interface AvailabilityRepository {
    Availability findById(UUID id);
    List<Availability> findAll();
    void save(Availability availability);
    void update(Availability availability);
    void delete(Availability availability);
}
