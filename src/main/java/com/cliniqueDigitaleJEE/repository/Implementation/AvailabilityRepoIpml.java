package com.cliniqueDigitaleJEE.repository.Implementation;

import com.cliniqueDigitaleJEE.model.Appointment;
import com.cliniqueDigitaleJEE.model.Availability;
import com.cliniqueDigitaleJEE.repository.Interfaces.AvailabilityRepository;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

import java.util.List;
import java.util.UUID;

@Stateless
public class AvailabilityRepoIpml implements AvailabilityRepository {

    @PersistenceContext
    private EntityManager em;

    @Override
    public Availability findById(UUID id) {
        return em.find(Availability.class, id);
    }

    @Override
    public List<Availability> findAll() {
        return em.createQuery("SELECT a FROM Availability a", Availability.class).getResultList();
    }

    @Override
    public void save(Availability availability) {
         em.persist(availability);
    }

    @Override
    public void update(Availability availability) {
        em.merge(availability);
    }

    @Override
    public void delete(Availability avalability) {
        em.remove(avalability);
    }
}
