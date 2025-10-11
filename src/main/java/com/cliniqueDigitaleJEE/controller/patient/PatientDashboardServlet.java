package com.cliniqueDigitaleJEE.controller.patient;

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
 * PatientDashboardServlet - Patient dashboard with appointments and health info
 */
@WebServlet("/patient/dashboard")
public class PatientDashboardServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!checkPatientAccess(req, resp)) return;
        
        // TODO: Fetch real data from service layer
        Map<String, Object> stats = getMockPatientStats();
        
        req.setAttribute("stats", stats);
        req.setAttribute("upcomingAppointments", getMockUpcomingAppointments());
        req.setAttribute("recentConsultations", getMockRecentConsultations());
        
        req.getRequestDispatcher("/WEB-INF/patient/dashboard.jsp").forward(req, resp);
    }
    
    private boolean checkPatientAccess(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession(true);
        
        // TEMPORARILY DISABLED FOR UI TESTING - RE-ENABLE IN PRODUCTION!

        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return false;
        }

        String userRole = String.valueOf(session.getAttribute("userRole"));
        if (!"PATIENT".equals(userRole)) {
            resp.sendRedirect(req.getContextPath() + "/403");
            return false;
        }


        
        return true;
    }
    
    private Map<String, Object> getMockPatientStats() {
        Map<String, Object> stats = new HashMap<>();
        stats.put("upcomingAppointments", 2);
        stats.put("totalConsultations", 15);
        stats.put("activePrescriptions", 3);
        stats.put("lastVisit", "2025-09-15");
        return stats;
    }
    
    private Object getMockUpcomingAppointments() {
        return new Object[0];
    }
    
    private Object getMockRecentConsultations() {
        return new Object[0];
    }
}
