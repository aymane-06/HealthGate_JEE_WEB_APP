package com.cliniqueDigitaleJEE.repository.Implementation;

import com.cliniqueDigitaleJEE.model.User;
import com.cliniqueDigitaleJEE.repository.Interfaces.UserRepository;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

import java.util.List;
import java.util.UUID;

public class UserRepoImplementation implements UserRepository {

    @PersistenceContext
    private EntityManager em;

    @Override
    public User findById(UUID id) {
        return em.find(User.class, id);
    }

    @Override
    public User findByEmail(String email) {
        try {
            return em.createQuery("SELECT u FROM User u WHERE u.email = :email", User.class)
                    .setParameter("email", email)
                    .getSingleResult();
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public List<User> findAll() {
        return em.createQuery("SELECT u FROM User u", User.class).getResultList();
    }

    @Override
    public void save(User user) {
        em.persist(user);
    }

    @Override
    public void update(User user) {
        em.merge(user);
    }

    @Override
    public void delete(UUID id) {
        User user = findById(id);
        if (user != null) {
            em.remove(user);
        }
    }
}
