package com.cliniqueDigitaleJEE.controller.doctor;

import com.cliniqueDigitaleJEE.dto.UserDTO;
import com.cliniqueDigitaleJEE.model.Doctor;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.hibernate.Session;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * DoctorAvailabilityServlet - Manage doctor's availability schedule
 */
@WebServlet("/doctor/availability")
public class DoctorAvailabilityServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!checkDoctorAccess(req, resp)) return;
        HttpSession session = req.getSession(true);
        UserDTO doctor= (UserDTO) session.getAttribute("user");
        req.setAttribute("doctor", doctor);

        
        req.getRequestDispatcher("/WEB-INF/doctor/availability.jsp").forward(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!checkDoctorAccess(req, resp)) return;
        
        String action = req.getParameter("action");
        
        switch (action) {
            case "add":
                // TODO: Add availability
                break;
            case "update":
                // TODO: Update availability
                break;
            case "delete":
                // TODO: Delete availability
                break;
        }
        
        resp.sendRedirect(req.getContextPath() + "/doctor/availability");
    }
    
    private boolean checkDoctorAccess(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession(true);
        
        // TEMPORARILY DISABLED FOR UI TESTING - RE-ENABLE IN PRODUCTION!
        /*
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return false;
        }
        
        String userRole = (String) session.getAttribute("userRole");
        if (!"DOCTOR".equals(userRole)) {
            resp.sendRedirect(req.getContextPath() + "/403");
            return false;
        }
        */
        
        // Create mock doctor user for UI testing
        if (session.getAttribute("user") == null) {
            Map<String, Object> mockUser = new HashMap<>();
            mockUser.put("id", 2L);
            mockUser.put("firstName", "Sara");
            mockUser.put("lastName", "Bennani");
            mockUser.put("email", "sara.bennani@clinique.ma");
            mockUser.put("role", "DOCTOR");
            mockUser.put("active", true);
            mockUser.put("matricule", "DOC-2024-001");
            mockUser.put("title", "Cardiologue");
            mockUser.put("specialtyName", "Cardiologie");
            mockUser.put("createdAt", "15/03/2024 09:00");
            mockUser.put("lastLogin", "07/10/2025 19:45");
            session.setAttribute("user", mockUser);
            session.setAttribute("userRole", "DOCTOR");
            session.setAttribute("userEmail", "sara.bennani@clinique.ma");
        }
        
        return true;
    }
    
    private Object getMockAvailabilities() {
        return new Object[0];
    }
}
