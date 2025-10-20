package com.cliniqueDigitaleJEE.repository.Implementation;

import com.cliniqueDigitaleJEE.model.Doctor;
import com.cliniqueDigitaleJEE.repository.Interfaces.DoctorRepository;
import jakarta.ejb.Singleton;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

import java.util.List;
import java.util.UUID;

@Singleton
public class DoctorRepositoryImpl implements DoctorRepository {

    @PersistenceContext
    private EntityManager em;

    @Override
    public Doctor findById(UUID id) {
        return em.find(Doctor.class, id);
    }

    @Override
    public List<Doctor> findAll() {
        return em.createQuery("SELECT d FROM Doctor d LEFT JOIN FETCH d.specialty", Doctor.class)
                .getResultList();
    }

    @Override
    public List<Doctor> findBySpecialty(UUID specialtyId) {
        return em.createQuery("SELECT d FROM Doctor d WHERE d.specialty.id = :specialtyId", Doctor.class)
                .setParameter("specialtyId", specialtyId)
                .getResultList();
    }

    @Override
    public void save(Doctor doctor) {
        em.persist(doctor);
    }

    @Override
    public void update(Doctor doctor) {
        em.merge(doctor);
    }

    @Override
    public void delete(UUID id) {
        Doctor doctor = findById(id);
        if (doctor != null) {
            em.remove(doctor);
        }
    }

    public Doctor findByIdWithAppointments(UUID id) {
        return em.createQuery(
                        "SELECT d FROM Doctor d LEFT JOIN FETCH d.appointments WHERE d.id = :id", Doctor.class)
                .setParameter("id", id)
                .getSingleResult();
    }
}
