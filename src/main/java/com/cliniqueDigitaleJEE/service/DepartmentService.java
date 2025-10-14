package com.cliniqueDigitaleJEE.service;

import com.cliniqueDigitaleJEE.model.Department;
import com.cliniqueDigitaleJEE.repository.Interfaces.DepartmentRepository;
import jakarta.ejb.Stateless;
import jakarta.inject.Inject;

import java.util.List;
import java.util.UUID;

@Stateless
public class DepartmentService {

    @Inject
    private DepartmentRepository departmentRepository;

    public List<Department> findAllDepartments() {
        List<Department> departments = departmentRepository.findAll();
        // Force initialization of specialties to avoid LazyInitializationException
        for (Department d : departments) {
            if (d.getSpecialties() != null) d.getSpecialties().size();
        }
        return departments;
    }

    public Department findById(UUID id) {
        Department d = departmentRepository.findById(id);
        if (d != null && d.getSpecialties() != null) d.getSpecialties().size();
        return d;
    }

    public void save(Department department) {
        departmentRepository.save(department);
    }

    public void update(Department department) {
        departmentRepository.update(department);
    }

    public void delete(UUID id) {
        departmentRepository.delete(id);
    }
}
