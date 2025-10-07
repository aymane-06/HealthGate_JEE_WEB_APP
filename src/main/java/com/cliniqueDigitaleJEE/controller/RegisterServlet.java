package com.cliniqueDigitaleJEE.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * RegisterServlet - Handles user registration
 */
@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    
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
        String role = req.getParameter("role");
        
        // Validation
        if (!password.equals(confirmPassword)) {
            req.setAttribute("error", "Les mots de passe ne correspondent pas");
            req.getRequestDispatcher("/WEB-INF/auth/register.jsp").forward(req, resp);
            return;
        }
        
        try {
            // TODO: Implement actual registration logic with your service layer
            boolean isRegistered = registerUser(firstName, lastName, email, password, role);
            
            if (isRegistered) {
                req.setAttribute("success", "Inscription réussie ! Vous pouvez maintenant vous connecter.");
                resp.sendRedirect(req.getContextPath() + "/login");
            } else {
                req.setAttribute("error", "Cette adresse email est déjà utilisée");
                req.getRequestDispatcher("/WEB-INF/auth/register.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            req.setAttribute("error", "Une erreur est survenue lors de l'inscription");
            req.getRequestDispatcher("/WEB-INF/auth/register.jsp").forward(req, resp);
        }
    }
    
    // Mock method - replace with actual service layer call
    private boolean registerUser(String firstName, String lastName, String email, String password, String role) {
        // TODO: Call your user service to register the user
        return true; // Mock success
    }
}
