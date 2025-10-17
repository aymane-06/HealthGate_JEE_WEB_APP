package com.cliniqueDigitaleJEE.controller.doctor;

import com.cliniqueDigitaleJEE.dto.UserDTO;
import com.cliniqueDigitaleJEE.model.Appointment;
import com.cliniqueDigitaleJEE.model.Availability;
import com.cliniqueDigitaleJEE.model.Doctor;
import com.cliniqueDigitaleJEE.model.ENUMS.AvailabilityStatus;
import com.cliniqueDigitaleJEE.service.AvailabilityService;
import com.cliniqueDigitaleJEE.service.DoctorService;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalTime;
import java.util.List;
import java.util.UUID;

@WebServlet(urlPatterns = {"/api/doctor/availabilities", "/api/doctor/availabilities/*"})
@MultipartConfig
public class DoctorAvailabilityApiServlet extends HttpServlet {

    @Inject
    private DoctorService doctorService;

    @Inject
    private AvailabilityService availabilityService;

    private static final ObjectMapper objectMapper = new ObjectMapper()
        .registerModule(new com.fasterxml.jackson.datatype.jsr310.JavaTimeModule());

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        PrintWriter out = resp.getWriter();
        String pathInfo = req.getPathInfo();



        if (pathInfo != null && !pathInfo.equals("/")) {
            String doctorID = pathInfo.substring(1);
            Doctor doctor = doctorService.findById(UUID.fromString(doctorID));
            if(doctor == null) {
                resp.setStatus(404);
                out.write("{\"status\":\"error\",\"message\":\"Doctor not found\"}");
                out.flush();
                return;
            }
            List<Availability> doctorAvailabilities = doctor.getAvailabilities();
            StringBuilder jsonResponse = new StringBuilder();
            jsonResponse.append("{\"status\":\"success\",\"data\":[");
            for (int i = 0; i < doctorAvailabilities.size(); i++) {
                Availability availability = doctorAvailabilities.get(i);
                jsonResponse.append("{");
                jsonResponse.append("\"id\":\"").append(availability.getId()).append("\",");
                jsonResponse.append("\"day\":\"").append(availability.getDay()).append("\",");
                jsonResponse.append("\"startTime\":\"").append(availability.getStartTime()).append("\",");
                jsonResponse.append("\"endTime\":\"").append(availability.getEndTime()).append("\",");
                jsonResponse.append("\"status\":\"").append(availability.getStatus()).append("\"");
                jsonResponse.append("}");
                if (i < doctorAvailabilities.size() - 1) {
                    jsonResponse.append(",");
                }
        }
            jsonResponse.append("]}");
            resp.setStatus(200);
            out.write(jsonResponse.toString());
            out.flush();
            return;
        }
        out.write("{\"status\":\"success\",\"data\":[]}");
        out.flush();
    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        PrintWriter out = resp.getWriter();
        String pathInfo = req.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            resp.setStatus(400);
            out.write("{\"status\":\"error\",\"message\":\"Availability ID is required in the URL\"}");
            out.flush();
            return;

        }
        Availability NewAvailability=objectMapper.readValue(req.getInputStream(), Availability.class);

        LocalTime startTime = NewAvailability.getStartTime();
        LocalTime endTime = NewAvailability.getEndTime();
        AvailabilityStatus status = NewAvailability.getStatus();

        if (startTime == null || endTime == null  || status == null) {
            resp.setStatus(400);
            out.write("{\"status\":\"error\",\"message\":\"Both startTime , endTime and status parameters are required\"}");
            out.flush();
            return;
        }

        String availabilityID = pathInfo.substring(1);
        try {
            UUID availabilityUUID = UUID.fromString(availabilityID);
            Availability availability = availabilityService.findById(availabilityUUID);
            if (availability == null) {
                resp.setStatus(404);
                out.write("{\"status\":\"error\",\"message\":\"Availability not found\"}");
                out.flush();
                return;
            }
            availability.setStartTime(startTime);
            availability.setEndTime(endTime);
            availability.setStatus(status);
            availabilityService.UpdateAvailability(availability);
            resp.setStatus(200);
            out.write("{\"status\":\"success\",\"message\":\"Availability updated successfully\"}");
            out.flush();
            return;

        } catch (IllegalArgumentException e) {
            resp.setStatus(400);
            out.write("{\"status\":\"error\",\"message\":\"Invalid Availability ID format\"}");
            out.flush();
            return;
        }

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
