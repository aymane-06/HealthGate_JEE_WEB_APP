package com.cliniqueDigitaleJEE.repository.Interfaces;

import com.cliniqueDigitaleJEE.model.Patient;
import java.util.List;
import java.util.UUID;

public interface PatientRepository {
    java.util.List<com.cliniqueDigitaleJEE.model.Appointment> findAppointmentsByPatientId(java.util.UUID patientId);
    Patient findById(UUID id);
    List<Patient> findAll();
    void save(Patient patient);
    void update(Patient patient);
    void delete(UUID id);
}
