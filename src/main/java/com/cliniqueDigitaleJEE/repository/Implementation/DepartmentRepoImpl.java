package com.cliniqueDigitaleJEE.repository.Implementation;

import com.cliniqueDigitaleJEE.model.Department;
import com.cliniqueDigitaleJEE.repository.Interfaces.DepartmentRepository;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

import java.util.List;
import java.util.UUID;

public class DepartmentRepoImpl implements DepartmentRepository {

    @PersistenceContext
    private EntityManager em;

    @Override
    public Department findById(UUID id) {
        return em.find(Department.class, id);

    }
    @Override
    public List<Department> findAll() {
        return em.createQuery("SELECT d FROM Department d", Department.class).getResultList();
    }
    @Override
    public void save(Department department) {
        em.persist(department);
    }
    @Override
    public void update(Department department) {
        em.merge(department);
    }
    @Override
    public void delete(UUID id) {
        Department department = em.find(Department.class, id);
        if (department != null) {
            em.remove(department);
        }
    }

}
