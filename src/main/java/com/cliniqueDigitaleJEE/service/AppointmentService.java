package com.cliniqueDigitaleJEE.service;

import com.cliniqueDigitaleJEE.model.Appointment;
import com.cliniqueDigitaleJEE.repository.Interfaces.AppointmentRepository;

import jakarta.ejb.Stateless;
import jakarta.inject.Inject;

@Stateless
public class AppointmentService {
    
    @Inject
    private AppointmentRepository appointmentRepository;

    public void bookAppointment(Appointment appointment) {
        appointmentRepository.bookAppointment(appointment);
    }

}
