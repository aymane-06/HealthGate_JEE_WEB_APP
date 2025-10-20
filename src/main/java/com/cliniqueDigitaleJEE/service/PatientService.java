package com.cliniqueDigitaleJEE.service;

import com.cliniqueDigitaleJEE.model.Patient;
import com.cliniqueDigitaleJEE.repository.Interfaces.PatientRepository;

import jakarta.ejb.Stateless;
import jakarta.inject.Inject;
import java.util.List;
import java.util.UUID;

@Stateless
public class PatientService {
    public java.util.List<com.cliniqueDigitaleJEE.model.Appointment> getAppointmentsForPatient(java.util.UUID patientId) {
        return patientRepository.findAppointmentsByPatientId(patientId);
    }
    @Inject
    private PatientRepository patientRepository;

    public Patient findById(UUID id) {
        return patientRepository.findById(id);
    }

    public List<Patient> findAll() {
        return patientRepository.findAll();
    }

    public void save(Patient patient) {
        patientRepository.save(patient);
    }

    public void update(Patient patient) {
        patientRepository.update(patient);
    }

    public void delete(UUID id) {
        patientRepository.delete(id);
    }
}
