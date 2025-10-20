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
 * PatientBookAppointmentServlet - Book new appointments
 */
@WebServlet("/patient/book-appointment")
public class PatientBookAppointmentServlet extends HttpServlet {
    @jakarta.inject.Inject
    private com.cliniqueDigitaleJEE.service.PatientService patientService;
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {


        
        req.getRequestDispatcher("/WEB-INF/patient/book-appointment.jsp").forward(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!checkPatientAccess(req, resp)) return;
        
        String doctorId = req.getParameter("doctorId");
        String date = req.getParameter("date");
        String time = req.getParameter("time");
        String reason = req.getParameter("reason");
        
        // TODO: Create appointment through service layer
        boolean success = bookAppointment(doctorId, date, time, reason);
        
        if (success) {
            resp.sendRedirect(req.getContextPath() + "/patient/appointments?success=true");
        } else {
            req.setAttribute("error", "Impossible de réserver ce créneau");
            doGet(req, resp);
        }
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
    
    private Object getMockSpecialties() {
        return new Object[0];
    }
    
    private Object getMockDoctors() {
        return new Object[0];
    }
    
    private boolean bookAppointment(String doctorId, String date, String time, String reason) {
        // TODO: Implement booking logic
        return true;
    }
}
