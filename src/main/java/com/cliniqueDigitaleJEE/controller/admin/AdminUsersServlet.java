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
        
        // TODO: Fetch users from service layer
        try {
            List<User> users= userService.getAllUsers();
            users.stream().forEach(System.out::println);

            req.setAttribute("users",users);
        } catch (Exception e) {
            req.setAttribute("error", "Erreur lors du chargement des utilisateurs: " + e.getMessage());
        }

        req.getRequestDispatcher("/WEB-INF/admin/users.jsp").forward(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");

        // Extract specific form fields for debugging
        String role = req.getParameter("role");
        String firstName = req.getParameter("firstName");
        String lastName = req.getParameter("lastName");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String password = req.getParameter("password");
        String active = req.getParameter("active");

        System.out.println("Extracted values:");
        System.out.println("  Role: " + role);
        System.out.println("  First Name: " + firstName);
        System.out.println("  Last Name: " + lastName);
        System.out.println("  Email: " + email);
        System.out.println("  Phone: " + phone);
        System.out.println("  Password: " + (password != null ? "[HIDDEN]" : "null"));
        System.out.println("  Active: " + active);

            String name = firstName + " " + lastName;

        // Role-specific fields based on role
        if ("PATIENT".equals(role)) {
            String cin = req.getParameter("cin");
            String bloodType = req.getParameter("bloodType");
            LocalDate birthDate = LocalDate.parse(req.getParameter("birthDate"));
            Gender gender = Gender.valueOf(req.getParameter("gender"));
            String address = req.getParameter("address");


            try{
                Patient patient = new Patient(name, email, password, phone, cin, address, birthDate,gender, bloodType);
                userService.registerUser(patient);
                String jsonResponse = String.format(
                        "{\"status\":\"success\",\"message\":\"Patient registered successfully\",\"data\":{\"role\":\"%s\",\"firstName\":\"%s\",\"lastName\":\"%s\",\"email\":\"%s\"}}",
                        role,
                        firstName,
                        lastName,
                        email
                );
                resp.setStatus(HttpServletResponse.SC_OK);
                resp.getWriter().write(jsonResponse);
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

            try{
                Doctor doctor= new Doctor(name, email, password,matricule, title);
                userService.registerUser(doctor);
                String jsonResponse = String.format(
                        "{\"status\":\"success\",\"message\":\"Doctor registered successfully\",\"data\":{\"role\":\"%s\",\"firstName\":\"%s\",\"lastName\":\"%s\",\"email\":\"%s\"}}",
                        role,
                        firstName,
                        lastName,
                        email
                );
                resp.setStatus(HttpServletResponse.SC_OK);
                resp.getWriter().write(jsonResponse);
                return;
            }catch (Exception e){
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

            try{
                STAFF staff = new STAFF(name, email, password, position, employeeId);
                userService.registerUser(staff);
                String jsonResponse = String.format(
                        "{\"status\":\"success\",\"message\":\"Staff registered successfully\",\"data\":{\"role\":\"%s\",\"firstName\":\"%s\",\"lastName\":\"%s\",\"email\":\"%s\"}}",
                        role,
                        firstName,
                        lastName,
                        email
                );
                resp.setStatus(HttpServletResponse.SC_OK);
                resp.getWriter().write(jsonResponse);
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
