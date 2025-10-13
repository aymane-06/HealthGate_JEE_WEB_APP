package com.cliniqueDigitaleJEE.repository.Implementation;

import com.cliniqueDigitaleJEE.model.Specialty;
import com.cliniqueDigitaleJEE.repository.Interfaces.SpecialtyRepository;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

import java.util.List;
import java.util.UUID;

@Stateless
public class SpecialtyRepositoryImpl implements SpecialtyRepository {

    @PersistenceContext
    private EntityManager em;

    @Override
    public Specialty findById(UUID id) {
        return em.find(Specialty.class, id);
    }

    @Override
    public List<Specialty> findAll() {
        // Eagerly fetch doctors to avoid LazyInitializationException
        return em.createQuery("SELECT DISTINCT s FROM Specialty s LEFT JOIN FETCH s.doctors ORDER BY s.name", Specialty.class)
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

