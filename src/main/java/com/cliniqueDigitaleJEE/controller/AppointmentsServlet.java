package com.cliniqueDigitaleJEE.controller;

import com.cliniqueDigitaleJEE.dto.UserDTO;
import com.cliniqueDigitaleJEE.model.Appointment;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * AppointmentsServlet - Handles the appointments list page
 */
@WebServlet("/patient/appointments")
public class AppointmentsServlet extends HttpServlet {
    @jakarta.inject.Inject
    private com.cliniqueDigitaleJEE.service.PatientService patientService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Check if user is logged in
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        UserDTO user = (UserDTO) session.getAttribute("user");

        try {
            UUID patientId = user.getId();
            List<Appointment> appointments = patientService.getAppointmentsForPatient(patientId);
            int upcomingCount = (int) appointments.stream().filter(a -> a.getDate().isAfter(LocalDate.now())).count();
            int pastCount = appointments.size() - upcomingCount;
            req.setAttribute("appointments", appointments);
            req.setAttribute("upcomingCount", upcomingCount);
            req.setAttribute("pastCount", pastCount);
            req.getRequestDispatcher("/WEB-INF/patient/appointments.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Erreur lors du chargement des rendez-vous: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/patient/appointments.jsp").forward(req, resp);
        }
    }
}

