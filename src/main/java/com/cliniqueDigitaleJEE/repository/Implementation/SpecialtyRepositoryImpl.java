package com.cliniqueDigitaleJEE.repository.Implementation;

import com.cliniqueDigitaleJEE.model.Specialty;
import com.cliniqueDigitaleJEE.repository.Interfaces.SpecialtyRepository;
import jakarta.ejb.Singleton;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

import java.util.List;
import java.util.UUID;

@Singleton
public class SpecialtyRepositoryImpl implements SpecialtyRepository {

    @PersistenceContext
    private EntityManager em;

    @Override
    public Specialty findById(UUID id) {
        return em.find(Specialty.class, id);
    }

    @Override
    public List<Specialty> findAll() {
        return em.createQuery("SELECT s FROM Specialty s ORDER BY s.name", Specialty.class)
                .getResultList();
    }

    @Override
    public void save(Specialty specialty) {
        em.persist(specialty);
    }

    @Override
    public void update(Specialty specialty) {
        em.merge(specialty);
    }

    @Override
    public void delete(UUID id) {
        Specialty specialty = findById(id);
        if (specialty != null) {
            em.remove(specialty);
        }
    }
}

