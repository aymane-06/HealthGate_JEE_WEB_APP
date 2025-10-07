package com.cliniqueDigitaleJEE.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * ProfileServlet - User profile management
 */
@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(true);
        
        // TEMPORARILY DISABLED FOR UI TESTING - RE-ENABLE IN PRODUCTION!
        /*
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        */
        
        // Create mock user if no session exists (for UI testing)
        if (session.getAttribute("user") == null) {
            Map<String, Object> mockUser = new HashMap<>();
            mockUser.put("id", 3L);
            mockUser.put("firstName", "Youssef");
            mockUser.put("lastName", "Idrissi");
            mockUser.put("email", "youssef.idrissi@email.ma");
            mockUser.put("role", "PATIENT");
            mockUser.put("active", true);
            mockUser.put("cin", "AB123456");
            mockUser.put("dateOfBirth", "15/05/1985");
            mockUser.put("gender", "M");
            mockUser.put("bloodType", "A+");
            mockUser.put("phone", "+212 6 12 34 56 78");
            mockUser.put("address", "Casablanca, Maroc");
            mockUser.put("createdAt", "20/04/2024 10:30");
            mockUser.put("lastLogin", "07/10/2025 19:50");
            session.setAttribute("user", mockUser);
            session.setAttribute("userRole", "PATIENT");
            session.setAttribute("userEmail", "youssef.idrissi@email.ma");
        }
        
        // TODO: Fetch full user profile from service layer
        req.setAttribute("userProfile", getMockUserProfile());
        
        req.getRequestDispatcher("/WEB-INF/profile.jsp").forward(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(true);
        
        // TEMPORARILY DISABLED FOR UI TESTING - RE-ENABLE IN PRODUCTION!
        /*
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        */
        
        String action = req.getParameter("action");
        
        if ("update".equals(action)) {
            // TODO: Update user profile
            String firstName = req.getParameter("firstName");
            String lastName = req.getParameter("lastName");
            String phone = req.getParameter("phone");
            
            boolean success = updateProfile(firstName, lastName, phone);
            
            if (success) {
                req.setAttribute("success", "Profil mis à jour avec succès");
            } else {
                req.setAttribute("error", "Erreur lors de la mise à jour");
            }
        } else if ("changePassword".equals(action)) {
            // TODO: Change password
            String oldPassword = req.getParameter("oldPassword");
            String newPassword = req.getParameter("newPassword");
            
            boolean success = changePassword(oldPassword, newPassword);
            
            if (success) {
                req.setAttribute("success", "Mot de passe modifié avec succès");
            } else {
                req.setAttribute("error", "Mot de passe actuel incorrect");
            }
        }
        
        doGet(req, resp);
    }
    
    private Object getMockUserProfile() {
        return new Object();
    }
    
    private boolean updateProfile(String firstName, String lastName, String phone) {
        // TODO: Implement update logic
        return true;
    }
    
    private boolean changePassword(String oldPassword, String newPassword) {
        // TODO: Implement password change logic
        return true;
    }
}
