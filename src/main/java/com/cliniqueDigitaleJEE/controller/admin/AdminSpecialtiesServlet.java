package com.cliniqueDigitaleJEE.controller.admin;

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
 * AdminSpecialtiesServlet - Manage medical specialties
 */
@WebServlet("/admin/specialties")
public class AdminSpecialtiesServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!checkAdminAccess(req, resp)) return;
        
        // TODO: Fetch specialties from service layer
        req.setAttribute("specialties", getMockSpecialties());
        
        req.getRequestDispatcher("/WEB-INF/admin/specialties.jsp").forward(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!checkAdminAccess(req, resp)) return;
        
        String action = req.getParameter("action");
        
        switch (action) {
            case "create":
                // TODO: Create specialty
                break;
            case "update":
                // TODO: Update specialty
                break;
            case "delete":
                // TODO: Delete specialty
                break;
        }
        
        resp.sendRedirect(req.getContextPath() + "/admin/specialties");
    }
    
    private boolean checkAdminAccess(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession(true);
        
        // TEMPORARILY DISABLED FOR UI TESTING - RE-ENABLE IN PRODUCTION!
        /*
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return false;
        }
        
        String userRole = (String) session.getAttribute("userRole");
        if (!"ADMIN".equals(userRole)) {
            resp.sendRedirect(req.getContextPath() + "/403");
            return false;
        }
        */
        
        // Create mock admin user for UI testing
        if (session.getAttribute("user") == null) {
            Map<String, Object> mockUser = new HashMap<>();
            mockUser.put("id", 1L);
            mockUser.put("firstName", "Mohammed");
            mockUser.put("lastName", "Alami");
            mockUser.put("email", "admin@clinique.ma");
            mockUser.put("role", "ADMIN");
            mockUser.put("active", true);
            mockUser.put("createdAt", "01/04/2025 10:00");
            mockUser.put("lastLogin", "07/10/2025 19:30");
            session.setAttribute("user", mockUser);
            session.setAttribute("userRole", "ADMIN");
            session.setAttribute("userEmail", "admin@clinique.ma");
        }
        
        return true;
    }
    
    private Object getMockSpecialties() {
        return new Object[0];
    }
}
