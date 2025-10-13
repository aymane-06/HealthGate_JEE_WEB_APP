package com.cliniqueDigitaleJEE.controller.admin;

import com.cliniqueDigitaleJEE.model.Doctor;
import com.cliniqueDigitaleJEE.model.ENUMS.Gender;
import com.cliniqueDigitaleJEE.model.Patient;
import com.cliniqueDigitaleJEE.model.STAFF;
import com.cliniqueDigitaleJEE.model.User;
import com.cliniqueDigitaleJEE.service.UserService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;


/**
 * AdminUsersServlet - Manage users
 */
@WebServlet("/admin/users")
@MultipartConfig
public class AdminUsersServlet extends HttpServlet {

    @Inject
     private UserService userService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        

        req.getRequestDispatcher("/WEB-INF/admin/users.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");

        // Check if this is an update (userId present) or create (no userId)
        String userId = req.getParameter("userId");
        boolean isUpdate = userId != null && !userId.trim().isEmpty();

        // Extract specific form fields for debugging
        String role = req.getParameter("role");
        String firstName = req.getParameter("firstName");
        String lastName = req.getParameter("lastName");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String password = req.getParameter("password");
        String active = req.getParameter("active");

        System.out.println("Operation: " + (isUpdate ? "UPDATE" : "CREATE"));
        System.out.println("User ID: " + userId);
        System.out.println("Extracted values:");
        System.out.println("  Role: " + role);
        System.out.println("  First Name: " + firstName);
        System.out.println("  Last Name: " + lastName);
        System.out.println("  Email: " + email);
        System.out.println("  Phone: " + phone);
        System.out.println("  Password: " + (password != null && !password.isEmpty() ? "[HIDDEN]" : "null"));
        System.out.println("  Active: " + active);

        String name = firstName + " " + lastName;

        // If updating, get existing user first
        User existingUser = null;
        if (isUpdate) {
            existingUser = userService.getUserById(userId);
            if (existingUser == null) {
                String jsonResponse = "{\"status\":\"error\",\"message\":\"User not found\"}";
                resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
                resp.getWriter().write(jsonResponse);
                return;
            }
        }

        // Role-specific fields based on role
        if ("PATIENT".equals(role)) {
            String cin = req.getParameter("cin");
            String bloodType = req.getParameter("bloodType");
            String birthDateStr = req.getParameter("birthDate");
            LocalDate birthDate = (birthDateStr != null && !birthDateStr.isEmpty()) ? LocalDate.parse(birthDateStr) : null;
            String genderStr = req.getParameter("gender");
            Gender gender = (genderStr != null && !genderStr.isEmpty()) ? Gender.valueOf(genderStr) : null;
            String address = req.getParameter("address");

            try {
                Patient patient;
                if (isUpdate && existingUser instanceof Patient) {
                    // Update existing patient
                    patient = (Patient) existingUser;
                    patient.setName(name);
                    patient.setEmail(email);
                    patient.setPhone(phone);
                    patient.setCIN(cin);
                    patient.setAddress(address);
                    patient.setBirthDate(birthDate);
                    patient.setGender(gender);
                    patient.setBloodType(bloodType);
                    patient.setActive("true".equals(active));
                    
                    // Only update password if provided
                    if (password != null && !password.isEmpty()) {
                        patient.setPassword(password);
                    }
                    
                    userService.updateUser(patient);
                    
                    String jsonResponse = String.format(
                            "{\"status\":\"success\",\"message\":\"Patient updated successfully\",\"data\":{\"role\":\"%s\",\"firstName\":\"%s\",\"lastName\":\"%s\",\"email\":\"%s\"}}",
                            role, firstName, lastName, email
                    );
                    resp.setStatus(HttpServletResponse.SC_OK);
                    resp.getWriter().write(jsonResponse);
                } else {
                    // Create new patient
                    patient = new Patient(name, email, password, phone, cin, address, birthDate, gender, bloodType);
                    userService.registerUser(patient);
                    
                    String jsonResponse = String.format(
                            "{\"status\":\"success\",\"message\":\"Patient registered successfully\",\"data\":{\"role\":\"%s\",\"firstName\":\"%s\",\"lastName\":\"%s\",\"email\":\"%s\"}}",
                            role, firstName, lastName, email
                    );
                    resp.setStatus(HttpServletResponse.SC_OK);
                    resp.getWriter().write(jsonResponse);
                }
                return;

            } catch (Exception e) {
                String jsonResponse = String.format(
                        "{\"status\":\"error\",\"message\":\"%s\"}",
                        e.getMessage()
                );
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                resp.getWriter().write(jsonResponse);
                return;
            }

        } else if ("DOCTOR".equals(role)) {
            String matricule = req.getParameter("matricule");
            String title = req.getParameter("title");
            String specialtyId = req.getParameter("specialtyId");

            try {
                Doctor doctor;
                if (isUpdate && existingUser instanceof Doctor) {
                    // Update existing doctor
                    doctor = (Doctor) existingUser;
                    doctor.setName(name);
                    doctor.setEmail(email);
                    doctor.setMatricule(matricule);
                    doctor.setTitle(title);
                    doctor.setActive("true".equals(active));
                    
                    // Only update password if provided
                    if (password != null && !password.isEmpty()) {
                        doctor.setPassword(password);
                    }
                    
                    userService.updateUser(doctor);
                    
                    String jsonResponse = String.format(
                            "{\"status\":\"success\",\"message\":\"Doctor updated successfully\",\"data\":{\"role\":\"%s\",\"firstName\":\"%s\",\"lastName\":\"%s\",\"email\":\"%s\"}}",
                            role, firstName, lastName, email
                    );
                    resp.setStatus(HttpServletResponse.SC_OK);
                    resp.getWriter().write(jsonResponse);
                } else {
                    // Create new doctor
                    doctor = new Doctor(name, email, password, matricule, title);
                    userService.registerUser(doctor);
                    
                    String jsonResponse = String.format(
                            "{\"status\":\"success\",\"message\":\"Doctor registered successfully\",\"data\":{\"role\":\"%s\",\"firstName\":\"%s\",\"lastName\":\"%s\",\"email\":\"%s\"}}",
                            role, firstName, lastName, email
                    );
                    resp.setStatus(HttpServletResponse.SC_OK);
                    resp.getWriter().write(jsonResponse);
                }
                return;
                
            } catch (Exception e) {
                String jsonResponse = String.format(
                        "{\"status\":\"error\",\"message\":\"%s\"}",
                        e.getMessage()
                );
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                resp.getWriter().write(jsonResponse);
                return;
            }

        } else if ("STAFF".equals(role)) {
            String position = req.getParameter("position");
            String employeeId = req.getParameter("employeeId");

            try {
                STAFF staff;
                if (isUpdate && existingUser instanceof STAFF) {
                    // Update existing staff
                    staff = (STAFF) existingUser;
                    staff.setName(name);
                    staff.setEmail(email);
                    staff.setPosition(position);
                    staff.setEmployeeId(employeeId);
                    staff.setActive("true".equals(active));
                    
                    // Only update password if provided
                    if (password != null && !password.isEmpty()) {
                        staff.setPassword(password);
                    }
                    
                    userService.updateUser(staff);
                    
                    String jsonResponse = String.format(
                            "{\"status\":\"success\",\"message\":\"Staff updated successfully\",\"data\":{\"role\":\"%s\",\"firstName\":\"%s\",\"lastName\":\"%s\",\"email\":\"%s\"}}",
                            role, firstName, lastName, email
                    );
                    resp.setStatus(HttpServletResponse.SC_OK);
                    resp.getWriter().write(jsonResponse);
                } else {
                    // Create new staff
                    staff = new STAFF(name, email, password, position, employeeId);
                    userService.registerUser(staff);
                    
                    String jsonResponse = String.format(
                            "{\"status\":\"success\",\"message\":\"Staff registered successfully\",\"data\":{\"role\":\"%s\",\"firstName\":\"%s\",\"lastName\":\"%s\",\"email\":\"%s\"}}",
                            role, firstName, lastName, email
                    );
                    resp.setStatus(HttpServletResponse.SC_OK);
                    resp.getWriter().write(jsonResponse);
                }
                return;
                
            } catch (Exception e) {
                String jsonResponse = String.format(
                        "{\"status\":\"error\",\"message\":\"%s\"}",
                        e.getMessage()
                );
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                resp.getWriter().write(jsonResponse);
                return;
            }
        }
    }
    

    
    private Object getMockUsers() {
        return new Object[0];
    }
}
