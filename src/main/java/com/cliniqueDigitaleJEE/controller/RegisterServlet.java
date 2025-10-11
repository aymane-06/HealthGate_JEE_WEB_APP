package com.cliniqueDigitaleJEE.controller;

import com.cliniqueDigitaleJEE.model.ENUMS.Gender;
import com.cliniqueDigitaleJEE.model.Patient;
import com.cliniqueDigitaleJEE.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.inject.Inject;


import java.io.IOException;
import java.time.LocalDate;

/**
 * RegisterServlet - Handles user registration
 */
@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    @Inject
     private UserService userService;

    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/auth/register.jsp").forward(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String firstName = req.getParameter("firstName");
        String lastName = req.getParameter("lastName");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");
        String cin = req.getParameter("cin");
        String phone = req.getParameter("phone");
        String address = req.getParameter("address");
        String birthDateStr = req.getParameter("birthDate");
        String genderStr = req.getParameter("gender");
        String bloodType = req.getParameter("bloodType");

        String fullName = firstName + " " + lastName;

        
        // Validation
        if (!password.equals(confirmPassword)) {
            req.setAttribute("error", "Les mots de passe ne correspondent pas");
            req.getRequestDispatcher("/WEB-INF/auth/register.jsp").forward(req, resp);
            return;
        }
        
        try {
            // Parse birthDate safely
            LocalDate birthDate = null;
            if (birthDateStr != null && !birthDateStr.isEmpty()) {
                birthDate = LocalDate.parse(birthDateStr);
            }

            // Parse gender safely
            Gender gender = null;
            if (genderStr != null && !genderStr.isEmpty()) {
                gender = Gender.valueOf(genderStr);
            }

            Patient patient = new Patient(fullName, email, password, cin, address, phone, birthDate, gender, bloodType);

            boolean isRegistered = userService.registerUser(patient);
            
            if (isRegistered) {
                req.setAttribute("success", "Inscription réussie ! Vous pouvez maintenant vous connecter.");
                resp.sendRedirect(req.getContextPath() + "/login");
            } else {
                req.setAttribute("error", "Cette adresse email est déjà utilisée");
                req.getRequestDispatcher("/WEB-INF/auth/register.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            req.setAttribute("error", "Une erreur est survenue lors de l'inscription: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/auth/register.jsp").forward(req, resp);
        }
    }

}
