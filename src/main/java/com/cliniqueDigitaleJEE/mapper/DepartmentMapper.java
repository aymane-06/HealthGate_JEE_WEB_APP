package com.cliniqueDigitaleJEE.mapper;

import com.cliniqueDigitaleJEE.dto.DepartmentDTO;
import com.cliniqueDigitaleJEE.model.Department;

public class DepartmentMapper {
    public Department DtoToEntity(DepartmentDTO departmentDto) {
      if(departmentDto == null) return null;
      Department department = new Department();
      department.setId(departmentDto.id);
      department.setCode(departmentDto.code);
      department.setName(departmentDto.name);
      department.setDescription(departmentDto.description);
      department.setActive(departmentDto.isActive);
      department.setLocation(departmentDto.location);
      department.setContactInfo(departmentDto.contactInfo);
      department.setColor(departmentDto.color);
      if(departmentDto.specialties != null) {
          departmentDto.specialties.size();
      }
      if(departmentDto.headDoctorId != null) {
          department.getResponsibleDoctor().setId(departmentDto.headDoctorId);
      }
        return department;
    }

    public DepartmentDTO EntityToDto(Department department) {
      if(department == null) return null;
      DepartmentDTO departmentDto = new DepartmentDTO();
      departmentDto.id = department.getId();
      departmentDto.code = department.getCode();
      departmentDto.name = department.getName();
      departmentDto.description = department.getDescription();
      departmentDto.isActive = department.isActive();
      departmentDto.location = department.getLocation();
      departmentDto.contactInfo = department.getContactInfo();
      departmentDto.color = department.getColor();
      if(department.getSpecialties() != null) {
          departmentDto.specialties = department.getSpecialties().stream().map(s -> s.getId()).toList();
          departmentDto.doctorCount= department.getSpecialties().stream().mapToInt(s -> s.getDoctors().size()).sum();
      }
      if(department.getResponsibleDoctor() != null) {
          departmentDto.headDoctorId = department.getResponsibleDoctor().getId();
      }
      return departmentDto;
    }
}
