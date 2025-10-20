
package com.cliniqueDigitaleJEE.repository.Implementation;

import com.cliniqueDigitaleJEE.model.Appointment;
import com.cliniqueDigitaleJEE.model.Patient;
import com.cliniqueDigitaleJEE.repository.Interfaces.PatientRepository;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import java.util.List;
import java.util.UUID;

@Stateless
public class PatientRepositoryImpl implements PatientRepository {
    @PersistenceContext
    private EntityManager em;

    @Override
    public Patient findById(UUID id) {
        return em.find(Patient.class, id);
    }

    @Override
    public List<Patient> findAll() {
        return em.createQuery("SELECT p FROM Patient p", Patient.class).getResultList();
    }

    @Override
    public void save(Patient patient) {
        em.persist(patient);
    }

    @Override
    public void update(Patient patient) {
        em.merge(patient);
    }

    @Override
    public void delete(UUID id) {
        Patient patient = findById(id);
        if (patient != null) {
            em.remove(patient);
        }
    }
    @Override
    public List<Appointment> findAppointmentsByPatientId(UUID patientId) {
        return em.createQuery(
                        "SELECT a FROM Appointment a WHERE a.patient.id = :patientId ORDER BY a.date DESC", Appointment.class)
                .setParameter("patientId", patientId)
                .getResultList();
    }
}
