package com.cliniqueDigitaleJEE.service;

import com.cliniqueDigitaleJEE.model.Department;
import com.cliniqueDigitaleJEE.model.Specialty;
import com.cliniqueDigitaleJEE.repository.Interfaces.DepartmentRepository;
import jakarta.ejb.Stateless;
import jakarta.inject.Inject;

import java.util.List;
import java.util.UUID;

@Stateless
public class DepartmentService {

    @Inject
    private DepartmentRepository departmentRepository;

    @Inject
    private SpecialtyService specialtyService;

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

    /**
     * Save or update a department and its specialties, ensuring the relationship is persisted.
     *
     * @param department  The department to save or update
     * @param specialties The list of specialties to assign to this department
     * @param isUpdate    true if updating, false if creating
     */
    public void saveDepartmentWithSpecialties(Department department, List<Specialty> specialties, boolean isUpdate) {
        // If updating, clear existing specialties' department reference
        if (isUpdate && department.getSpecialties() != null){
            for (Specialty specialty : department.getSpecialties() ){
                specialty.setDepartment(null);
                specialtyService.update(specialty);
            }
        }
        // Set the department on each specialty and save/update the specialty
        for (Specialty specialty : specialties) {
            specialty.setDepartment(department);
            if (isUpdate) {
                specialtyService.update(specialty);
            } else {
                specialtyService.save(specialty);
            }
        }
        department.setSpecialties(specialties);
        if (isUpdate) {
            departmentRepository.update(department);
        } else {
            departmentRepository.save(department);
        }
    }
}
