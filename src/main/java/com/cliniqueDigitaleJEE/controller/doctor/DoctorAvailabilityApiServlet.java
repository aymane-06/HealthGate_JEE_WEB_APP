package com.cliniqueDigitaleJEE.controller.doctor;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(urlPatterns = {"/api/availability", "/api/availability/*", "/api/availability/leave"})
public class DoctorAvailabilityApiServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        PrintWriter out = resp.getWriter();
        // TODO: Implement logic to fetch availabilities for the current doctor
        out.write("{\"status\":\"success\",\"data\":[]}");
        out.flush();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        PrintWriter out = resp.getWriter();
        // TODO: Implement logic to add new availability or leave
        out.write("{\"status\":\"success\",\"message\":\"Not implemented yet\"}");
        out.flush();
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        PrintWriter out = resp.getWriter();
        // TODO: Implement logic to delete an availability
        out.write("{\"status\":\"success\",\"message\":\"Not implemented yet\"}");
        out.flush();
    }
}

