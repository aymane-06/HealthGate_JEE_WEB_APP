package com.cliniqueDigitaleJEE.repository.Implementation;

import java.util.List;

import com.cliniqueDigitaleJEE.model.Appointment;
import com.cliniqueDigitaleJEE.repository.Interfaces.AppointmentRepository;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

@Stateless
public class AppointmentRepoIml implements AppointmentRepository {
    
    @PersistenceContext
    private EntityManager em;

    @Override
    public void bookAppointment(Appointment appointment) {
        em.persist(appointment);
    }

    @Override
    public Appointment getAppointmentById(String appointmentId) {
        return em.find(Appointment.class, appointmentId);
    }

    @Override
    public List<Appointment> getAllAppointments() {
        return em.createQuery("SELECT a FROM Appointment a", Appointment.class).getResultList();
    }

    @Override
    public void updateAppointment(Appointment appointment) {
        em.merge(appointment);
    }

    @Override
    public void deleteAppointment(String appointmentId) {
        Appointment appointment = getAppointmentById(appointmentId);
        if (appointment != null) {
            em.remove(appointment);
        }
    }
}
