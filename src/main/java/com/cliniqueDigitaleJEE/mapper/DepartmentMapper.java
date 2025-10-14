package com.cliniqueDigitaleJEE.mapper;

import com.cliniqueDigitaleJEE.dto.DepartmentDTO;
import com.cliniqueDigitaleJEE.model.Department;

public class DepartmentMapper {
    public void DtoToEntity(DepartmentDTO departmentDto) {
      if(departmentDto == null) return;
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
    }
}
