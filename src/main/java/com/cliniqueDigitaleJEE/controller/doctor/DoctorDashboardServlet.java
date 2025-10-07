package com.cliniqueDigitaleJEE.controller.doctor;

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
 * DoctorDashboardServlet - Doctor dashboard with appointments and patients
 */
@WebServlet("/doctor/dashboard")
public class DoctorDashboardServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!checkDoctorAccess(req, resp)) return;
        
        // TODO: Fetch real data from service layer
        Map<String, Object> stats = getMockDoctorStats();
        
        req.setAttribute("stats", stats);
        req.setAttribute("todayAppointments", getMockTodayAppointments());
        req.setAttribute("upcomingAppointments", getMockUpcomingAppointments());
        
        req.getRequestDispatcher("/WEB-INF/doctor/dashboard.jsp").forward(req, resp);
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
    
    private Map<String, Object> getMockDoctorStats() {
        Map<String, Object> stats = new HashMap<>();
        stats.put("todayAppointments", 8);
        stats.put("totalPatients", 156);
        stats.put("pendingAppointments", 5);
        stats.put("completedToday", 3);
        return stats;
    }
    
    private Object getMockTodayAppointments() {
        return new Object[0];
    }
    
    private Object getMockUpcomingAppointments() {
        return new Object[0];
    }
}
