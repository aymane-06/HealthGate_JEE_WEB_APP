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
 * AdminDashboardServlet - Admin dashboard with statistics
 */
@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(true); // Changed to true to always create session
        
        // TEMPORARILY DISABLED FOR UI TESTING - RE-ENABLE IN PRODUCTION!
        /*
        // Check if user is logged in and has ADMIN role
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        
        String userRole = (String) session.getAttribute("userRole");
        if (!"ADMIN".equals(userRole)) {
            resp.sendRedirect(req.getContextPath() + "/403");
            return;
        }
        */
        
        // Create mock user for UI testing
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
        
        // TODO: Fetch real statistics from your service layer
        Map<String, Object> stats = getMockStatistics();
        
        req.setAttribute("stats", stats);
        req.setAttribute("recentUsers", getMockRecentUsers());
        req.setAttribute("upcomingAppointments", getMockUpcomingAppointments());
        
        req.getRequestDispatcher("/WEB-INF/admin/dashboard.jsp").forward(req, resp);
    }
    
    private Map<String, Object> getMockStatistics() {
        Map<String, Object> stats = new HashMap<>();
        stats.put("totalUsers", 1247);
        stats.put("totalDoctors", 48);
        stats.put("totalPatients", 1150);
        stats.put("todayAppointments", 23);
        stats.put("inactiveDoctors", 2);
        stats.put("pendingAppointments", 15);
        return stats;
    }
    
    private Object getMockRecentUsers() {
        // TODO: Return actual list of recent users
        return new Object[0];
    }
    
    private Object getMockUpcomingAppointments() {
        // TODO: Return actual list of upcoming appointments
        return new Object[0];
    }
}
