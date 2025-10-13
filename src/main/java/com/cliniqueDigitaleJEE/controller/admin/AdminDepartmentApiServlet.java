package com.cliniqueDigitaleJEE.controller.admin;

import com.cliniqueDigitaleJEE.model.Department;
import com.cliniqueDigitaleJEE.service.DepartmentService;
import jakarta.inject.Inject;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.UUID;

@WebServlet(urlPatterns = {"/api/admin/departments", "/api/admin/departments/*"})
public class AdminDepartmentApiServlet extends HttpServlet {

    @Inject
    private DepartmentService departmentService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.setHeader("Cache-Control", "no-cache");

        String pathInfo = req.getPathInfo();

        try {
            if (pathInfo == null || pathInfo.equals("/")) {
                // Get all departments
                List<Department> departments = departmentService.findAllDepartments();
                String jsonResponse = buildDepartmentsJson(departments);
                resp.getWriter().write(jsonResponse);

            } else {
                // Get single department by ID
                String idStr = pathInfo.substring(1);
                try {
                    UUID id = UUID.fromString(idStr);
                    Department department = departmentService.findById(id);

                    if (department != null) {
                        String jsonResponse = buildDepartmentJson(department);
                        resp.getWriter().write(jsonResponse);
                    } else {
                        resp.setStatus(404);
                        resp.getWriter().write("{\"status\":\"error\",\"message\":\"Department not found\"}");
                    }
                } catch (IllegalArgumentException e) {
                    resp.setStatus(400);
                    resp.getWriter().write("{\"status\":\"error\",\"message\":\"Invalid department ID format\"}");
                }
            }
        } catch (Exception e) {
            resp.setStatus(500);
            resp.getWriter().write("{\"status\":\"error\",\"message\":\"Internal server error: " + e.getMessage() + "\"}");
        }
    }
    private String buildDepartmentsJson(List<Department> departments) {
        StringBuilder sb = new StringBuilder();
        sb.append("[");
        for (int i = 0; i < departments.size(); i++) {
            Department dept = departments.get(i);
            sb.append(buildDepartmentJson(dept));
            if (i < departments.size() - 1) {
                sb.append(",");
            }
        }
        sb.append("]");
        return sb.toString();
    }
    private String buildDepartmentJson(Department department) {
        return String.format("{\"id\":\"%s\",\"name\":\"%s\",\"description\":\"%s\"}",
                department.getId(), escapeJson(department.getName()), escapeJson(department.getDescription()));
    }
    private String escapeJson(String value) {
        if (value == null) {
            return "";
        }
        return value.replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "\\r");
    }

}

