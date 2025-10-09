package com.cliniqueDigitaleJEE.mapper;



import com.cliniqueDigitaleJEE.dto.UserDTO;
import com.cliniqueDigitaleJEE.model.User;
import com.cliniqueDigitaleJEE.model.Admin;
import com.cliniqueDigitaleJEE.model.Doctor;
import com.cliniqueDigitaleJEE.model.Patient;
import com.cliniqueDigitaleJEE.model.STAFF;


public class UserMapper {
    public UserDTO toDTO(User user) {
        if (user==null) {
            return null;
            
        }
        return new UserDTO(user);
    }

    public User toEntity(UserDTO userDTO) {
       
        switch (userDTO.getRole().name()) {
            case "ADMIN"-> {
                Admin admin = new Admin();
                admin.setId(userDTO.getId());
                admin.setName(userDTO.getName());
                admin.setEmail(userDTO.getEmail());
                admin.setRole(userDTO.getRole());
                return admin;}
            case "DOCTOR"-> {
                Doctor doctor = new Doctor();
                doctor.setId(userDTO.getId());
                doctor.setName(userDTO.getName());
                doctor.setEmail(userDTO.getEmail());
                doctor.setRole(userDTO.getRole());
                doctor.setSpecialty(userDTO.getSpecialty());
                doctor.setTitle(userDTO.getTitle());
                doctor.setMatricule(userDTO.getMatricule());
                return doctor;}
            case "STAFF"-> {
                STAFF staff= new STAFF();
                staff.setId(userDTO.getId());
                staff.setName(userDTO.getName());
                staff.setEmail(userDTO.getEmail());
                staff.setRole(userDTO.getRole());
                staff.setPosition(userDTO.getPosition());
                staff.setEmployeeId(userDTO.getEmployeeId());
                return staff;}
            case "PATIENT"-> {
                Patient patient = new Patient();
                patient.setId(userDTO.getId());
                patient.setName(userDTO.getName());
                patient.setEmail(userDTO.getEmail());
                patient.setRole(userDTO.getRole());
                patient.setAddress(userDTO.getAddress());
                patient.setPhone(userDTO.getPhone());
                patient.setGender(userDTO.getGender());
                patient.setBloodType(userDTO.getBloodType());
                patient.setBirthDate(userDTO.getBirthDate());
                patient.setCIN(userDTO.getCin());
                return patient;}

        
            default -> {
                return null;
            }
        }

    }
}
