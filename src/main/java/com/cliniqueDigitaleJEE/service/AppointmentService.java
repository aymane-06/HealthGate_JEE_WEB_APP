package com.cliniqueDigitaleJEE.service;

import com.cliniqueDigitaleJEE.model.Appointment;
import com.cliniqueDigitaleJEE.model.Doctor;
import com.cliniqueDigitaleJEE.model.Patient;
import com.cliniqueDigitaleJEE.repository.Interfaces.AppointmentRepository;

import jakarta.ejb.Stateless;
import jakarta.inject.Inject;

import java.time.LocalDate;
import java.time.LocalTime;

@Stateless
public class AppointmentService {
    
    @Inject
    private AppointmentRepository appointmentRepository;

    public void bookAppointment(Appointment appointment) {
        appointmentRepository.bookAppointment(appointment);
    }

    public Boolean hasPatientBookedAppointmentOnDate(Patient patient, Doctor doctor, LocalDate localDate, LocalTime time) {
        return patient.getAppointments().stream()
                .anyMatch(appointment ->
                        appointment.getDoctor().getId().equals(doctor.getId()) &&
                                appointment.getDate().equals(localDate)
                );
    }
}
