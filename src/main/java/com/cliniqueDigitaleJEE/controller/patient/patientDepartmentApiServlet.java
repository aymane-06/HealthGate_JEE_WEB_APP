package com.cliniqueDigitaleJEE.controller.patient;

import com.cliniqueDigitaleJEE.dto.DepartmentDTO;
import com.cliniqueDigitaleJEE.model.Doctor;
import com.cliniqueDigitaleJEE.model.Specialty;
import com.cliniqueDigitaleJEE.service.DepartmentService;
import com.cliniqueDigitaleJEE.service.SpecialtyService;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import com.fasterxml.jackson.databind.SerializationFeature;
import jakarta.inject.Inject;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;

import java.util.HashMap;
import java.util.List;
import java.util.UUID;

@WebServlet(urlPatterns = {"/api/patient/departments", "/api/patient/departments/*"})
public class patientDepartmentApiServlet extends HttpServlet {

    @Inject
    private DepartmentService departmentService;

    @Inject
    private SpecialtyService specialtyService;

   private static final ObjectMapper objectMapper = new ObjectMapper()
            .registerModule(new JavaTimeModule())
            .disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);

    @Override
    protected void doGet(jakarta.servlet.http.HttpServletRequest req, jakarta.servlet.http.HttpServletResponse resp)
            throws jakarta.servlet.ServletException, java.io.IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        String pathInfo = req.getPathInfo();

        //if pathInfo matches /{uuid}/doctors handle doctors list
        if(pathInfo !=null && pathInfo.matches("^/[0-9a-fA-F\\-]+/doctors$")){
            try{
                UUID specialtyId = UUID.fromString(pathInfo.split("/")[1]);
                List<Doctor> doctors= specialtyService.findById(specialtyId).getDoctors();
                HashMap<String,List<Doctor>> responseMap = new HashMap<>();
                responseMap.put("doctors",doctors);
                objectMapper.writeValue(resp.getWriter(),responseMap);
                return; 
            } catch (IllegalArgumentException iae) {
                // invalid UUID
                resp.setStatus(400);
                resp.getWriter().write("{\"status\":\"error\",\"message\":\"Invalid specialty id\"}");
                return;
            } catch (Exception e) {
                resp.setStatus(500);
                resp.getWriter().write("{\"status\":\"error\",\"message\":\"Internal server error: " + e.getMessage() + "\"}");
                return;
            }
        }

        // If pathInfo matches /{uuid}/specialties handle specialties list
        if (pathInfo != null && pathInfo.matches("^/[0-9a-fA-F\\-]+/specialties$")) {

            try {
                UUID departmentId = UUID.fromString(pathInfo.split("/")[1]);
                List<Specialty> specialties = departmentService.findById(departmentId).getSpecialties();
                HashMap<String, List<Specialty>> responseMap = new HashMap<>();
                responseMap.put("specialties", specialties);
                objectMapper.writeValue(resp.getWriter(), responseMap);
                return;
            } catch (IllegalArgumentException iae) {
                // invalid UUID
                resp.setStatus(400);
                resp.getWriter().write("{\"status\":\"error\",\"message\":\"Invalid department id\"}");
                return;
            } catch (Exception e) {
                resp.setStatus(500);
                resp.getWriter().write("{\"status\":\"error\",\"message\":\"Internal server error: " + e.getMessage() + "\"}");
                return;
            }
        } else if (pathInfo != null) {
            // pathInfo present but doesn't match expected pattern -> 404
            resp.setStatus(404);
            resp.getWriter().write("{\"status\":\"error\",\"message\":\"Not found\"}");
            return;
        }

        try{
            List<DepartmentDTO> departments = departmentService.findAllDepartments();

            HashMap<String,List<DepartmentDTO>> responseMap = new HashMap<>();
            responseMap.put("departments",departments);


            objectMapper.writeValue(resp.getWriter(), responseMap);

        } catch (Exception e) {
            resp.setStatus(500);
            resp.getWriter().write("{\"status\":\"error\",\"message\":\"Internal server error: " + e.getMessage() + "\"}");
        }

    }
}

