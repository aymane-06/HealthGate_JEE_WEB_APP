package com.cliniqueDigitaleJEE.controller.staff;

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
 * StaffDashboardServlet - Staff dashboard for managing appointments
 */
@WebServlet("/staff/dashboard")
public class StaffDashboardServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!checkStaffAccess(req, resp)) return;
        
        // TODO: Fetch real data from service layer
        Map<String, Object> stats = getMockStaffStats();
        
        req.setAttribute("stats", stats);
        req.setAttribute("todayAppointments", getMockTodayAppointments());
        req.setAttribute("waitingList", getMockWaitingList());
        
        req.getRequestDispatcher("/WEB-INF/staff/dashboard.jsp").forward(req, resp);
    }
    
    private boolean checkStaffAccess(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession(true);
        
        // TEMPORARILY DISABLED FOR UI TESTING - RE-ENABLE IN PRODUCTION!
        /*
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return false;
        }
        
        String userRole = (String) session.getAttribute("userRole");
        if (!"STAFF".equals(userRole)) {
            resp.sendRedirect(req.getContextPath() + "/403");
            return false;
        }
        */
        
        // Create mock staff user for UI testing
        if (session.getAttribute("user") == null) {
            Map<String, Object> mockUser = new HashMap<>();
            mockUser.put("id", 4L);
            mockUser.put("firstName", "Fatima Zahra");
            mockUser.put("lastName", "El Amrani");
            mockUser.put("email", "fz.elamrani@clinique.ma");
            mockUser.put("role", "STAFF");
            mockUser.put("active", true);
            mockUser.put("phone", "+212 6 98 76 54 32");
            mockUser.put("createdAt", "10/05/2024 08:00");
            mockUser.put("lastLogin", "07/10/2025 19:55");
            session.setAttribute("user", mockUser);
            session.setAttribute("userRole", "STAFF");
            session.setAttribute("userEmail", "fz.elamrani@clinique.ma");
        }
        
        return true;
    }
    
    private Map<String, Object> getMockStaffStats() {
        Map<String, Object> stats = new HashMap<>();
        stats.put("todayAppointments", 45);
        stats.put("pendingAppointments", 12);
        stats.put("waitingPatients", 8);
        stats.put("completedToday", 28);
        return stats;
    }
    
    private Object getMockTodayAppointments() {
        return new Object[0];
    }
    
    private Object getMockWaitingList() {
        return new Object[0];
    }
}
