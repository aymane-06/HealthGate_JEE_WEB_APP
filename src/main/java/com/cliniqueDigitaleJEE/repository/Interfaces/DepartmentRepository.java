package com.cliniqueDigitaleJEE.repository.Interfaces;

import com.cliniqueDigitaleJEE.model.Department;
import java.util.List;
import java.util.UUID;

public interface DepartmentRepository {
    Department findById(UUID id);
    List<Department> findAll();
    void save(Department department);
    void update(Department department);
    void delete(UUID id);
}
