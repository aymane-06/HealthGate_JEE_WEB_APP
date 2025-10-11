package com.cliniqueDigitaleJEE.controller;

import com.cliniqueDigitaleJEE.dto.UserDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;

/**
 * AppointmentsServlet - Handles the appointments list page
 */
@WebServlet("/patient/appointments")
public class AppointmentsServlet extends HttpServlet {

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
            // For now, use empty list - you can fetch real appointments later
            req.setAttribute("appointments", new ArrayList<>());
            req.setAttribute("upcomingCount", 0);
            req.setAttribute("pastCount", 0);

            // Forward to JSP
            req.getRequestDispatcher("/WEB-INF/patient/appointments.jsp").forward(req, resp);
            
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Erreur lors du chargement des rendez-vous: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/patient/appointments.jsp").forward(req, resp);
        }
    }
}

