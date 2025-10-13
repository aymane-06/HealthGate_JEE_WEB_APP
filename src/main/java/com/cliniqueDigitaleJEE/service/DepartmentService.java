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
        return departmentRepository.findAll();
    }

    public Department findById(UUID id) {
        return departmentRepository.findById(id);
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
