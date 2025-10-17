package com.cliniqueDigitaleJEE.service;

import com.cliniqueDigitaleJEE.model.Appointment;
import com.cliniqueDigitaleJEE.model.Availability;
import com.cliniqueDigitaleJEE.repository.Interfaces.AvailabilityRepository;
import jakarta.ejb.Stateless;
import jakarta.inject.Inject;

import java.util.UUID;

@Stateless
public class AvailabilityService {
    @Inject
    private AvailabilityRepository availabilityRepository;

    public void UpdateAvailability(Availability availability) {
        availabilityRepository.update(availability);
    }

    public Availability findById(UUID id) {
        return availabilityRepository.findById(id);
    }
}
