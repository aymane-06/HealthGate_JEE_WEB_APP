package com.cliniqueDigitaleJEE.controller.admin;

import com.cliniqueDigitaleJEE.model.Doctor;
import com.cliniqueDigitaleJEE.service.DoctorService;
import jakarta.inject.Inject;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.UUID;

@WebServlet(urlPatterns = {"/api/admin/doctors", "/api/admin/doctors/*"})
public class AdminDoctorsApiServlet extends HttpServlet {

    @Inject
    private DoctorService doctorService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.setHeader("Cache-Control", "no-cache");

        String pathInfo = req.getPathInfo();

        try {
            if (pathInfo == null || pathInfo.equals("/")) {
                // Get all doctors
                List<Doctor> doctors = doctorService.findAllDoctors();
                String jsonResponse = buildDoctorsJson(doctors);
                resp.getWriter().write(jsonResponse);

            } else {
                // Get single doctor by ID
                String idStr = pathInfo.substring(1);
                try {
                    UUID id = UUID.fromString(idStr);
                    Doctor doctor = doctorService.findById(id);

                    if (doctor != null) {
                        String jsonResponse = buildDoctorJson(doctor);
                        resp.getWriter().write(jsonResponse);
                    } else {
                        resp.setStatus(404);
                        resp.getWriter().write("{\"status\":\"error\",\"message\":\"Doctor not found\"}");
                    }
                } catch (IllegalArgumentException e) {
                    resp.setStatus(400);
                    resp.getWriter().write("{\"status\":\"error\",\"message\":\"Invalid doctor ID format\"}");
                }
            }
        } catch (Exception e) {
            resp.setStatus(500);
            resp.getWriter().write("{\"status\":\"error\",\"message\":\"Internal server error: " + e.getMessage() + "\"}");
        }
    }

    private String buildDoctorsJson(List<Doctor> doctors) {
        StringBuilder json = new StringBuilder();
        json.append("{\"status\":\"success\",\"data\":[");

        for (int i = 0; i < doctors.size(); i++) {
            Doctor doctor = doctors.get(i);
            json.append(buildDoctorObject(doctor));
            if (i < doctors.size() - 1) {
                json.append(",");
            }
        }

        json.append("]}");
        return json.toString();
    }

    private String buildDoctorJson(Doctor doctor) {
        return "{\"status\":\"success\",\"data\":" + buildDoctorObject(doctor) + "}";
    }

    private String buildDoctorObject(Doctor doctor) {
        if (doctor == null) {
            return "null";
        }

        return "{" +
                "\"id\":\"" + doctor.getId() + "\"," +
                "\"Name\":\"" + escapeJson(doctor.getName()) + "\"," +
                "\"email\":\"" + escapeJson(doctor.getEmail()) + "\"," +
                "\"title\":\"" + escapeJson(doctor.getTitle()) + "\"," +
                "\"specialty\":" + buildSpecialtyObject(doctor.getSpecialty()) +
                "}";
    }

    private String buildSpecialtyObject(Object specialty) {
        if (specialty == null) {
            return "null";
        }
        // Adjust this based on your Specialty class structure
        return "{\"id\":\"spec-id\",\"name\":\"Specialty Name\"}";
    }

    private String escapeJson(String text) {
        if (text == null) return "";
        return text.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\b", "\\b")
                .replace("\f", "\\f")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t");
    }
}