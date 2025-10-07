package com.cliniqueDigitaleJEE.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * LoginServlet - Handles login page display and authentication
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        
        // If already logged in, redirect to appropriate dashboard
        if (session != null && session.getAttribute("user") != null) {
            String role = (String) session.getAttribute("userRole");
            resp.sendRedirect(req.getContextPath() + "/" + role.toLowerCase() + "/dashboard");
            return;
        }
        
        // Show login page
        req.getRequestDispatcher("/WEB-INF/auth/login.jsp").forward(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String remember = req.getParameter("remember");
        
        // TODO: Implement actual authentication logic with your service layer
        // For now, this is a mock implementation
        
        try {
            // Mock authentication - replace with actual service call
            boolean isAuthenticated = authenticateUser(email, password);
            
            if (isAuthenticated) {
                HttpSession session = req.getSession(true);
                
                // Mock user data - replace with actual user from database
                session.setAttribute("user", createMockUser(email));
                session.setAttribute("userEmail", email);
                session.setAttribute("userRole", determineMockRole(email));
                
                // Set session timeout (30 minutes)
                session.setMaxInactiveInterval(30 * 60);
                
                // Redirect based on role
                String role = (String) session.getAttribute("userRole");
                resp.sendRedirect(req.getContextPath() + "/" + role.toLowerCase() + "/dashboard");
            } else {
                req.setAttribute("error", "Email ou mot de passe incorrect");
                req.getRequestDispatcher("/WEB-INF/auth/login.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            req.setAttribute("error", "Une erreur est survenue. Veuillez réessayer.");
            req.getRequestDispatcher("/WEB-INF/auth/login.jsp").forward(req, resp);
        }
    }
    
    // Mock methods - replace with actual service layer calls
    private boolean authenticateUser(String email, String password) {
        // TODO: Call your authentication service
        return email != null && !email.isEmpty() && password != null && !password.isEmpty();
    }
    
    private Object createMockUser(String email) {
        // TODO: Return actual user object from database
        return new Object(); // Placeholder
    }
    
    private String determineMockRole(String email) {
        // Mock role determination based on email
        if (email.contains("admin")) return "ADMIN";
        if (email.contains("doctor")) return "DOCTOR";
        if (email.contains("staff")) return "STAFF";
        return "PATIENT";
    }
}
