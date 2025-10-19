package com.cliniqueDigitaleJEE.controller.patient;

import com.cliniqueDigitaleJEE.dto.DepartmentDTO;
import com.cliniqueDigitaleJEE.model.Department;
import com.cliniqueDigitaleJEE.model.Specialty;
import com.cliniqueDigitaleJEE.service.DepartmentService;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.inject.Inject;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;

import java.util.HashMap;
import java.util.List;
import java.util.UUID;

@WebServlet(urlPatterns = {"/api/patient/departments", "/api/patient/departments/*/specialties"})
public class patientDepartmentApiServlet extends HttpServlet {

    @Inject
    private DepartmentService departmentService;

   private static ObjectMapper objectMapper = new ObjectMapper();

    @Override
    protected void doGet(jakarta.servlet.http.HttpServletRequest req, jakarta.servlet.http.HttpServletResponse resp)
            throws jakarta.servlet.ServletException, java.io.IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        String pathInfo = req.getPathInfo();
        if(pathInfo!=null && pathInfo.endsWith("/specialties")){
            try{
            UUID departmentId = UUID.fromString(pathInfo.split("/")[1]);
            List<Specialty> specialties = departmentService.findById(departmentId).getSpecialties();
            HashMap<String,List<Specialty>> responseMap = new HashMap<>();
            responseMap.put("specialties",specialties);
            objectMapper.writeValue(resp.getWriter(), responseMap);
            return;
        } catch (Exception e) {
            resp.setStatus(500);
            resp.getWriter().write("{\"status\":\"error\",\"message\":\"Internal server error: " + e.getMessage() + "\"}");
        }

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
