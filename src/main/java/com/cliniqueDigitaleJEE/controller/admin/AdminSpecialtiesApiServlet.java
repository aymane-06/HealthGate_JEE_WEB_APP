package com.cliniqueDigitaleJEE.controller.admin;

import com.cliniqueDigitaleJEE.model.Specialty;
import com.cliniqueDigitaleJEE.service.SpecialtyService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Comparator;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

/**
 * RESTful API for Specialty Management
 * Supports pagination, sorting, and searching
 */
@WebServlet(urlPatterns = {"/api/admin/specialties", "/api/admin/specialties/*"})
public class AdminSpecialtiesApiServlet extends HttpServlet {

    @Inject
    private SpecialtyService specialtyService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.setHeader("Cache-Control", "no-cache");

        try {
            // Check if requesting a single specialty: /api/admin/specialties/{id}
            String pathInfo = req.getPathInfo();
            if (pathInfo != null && !pathInfo.isEmpty() && !pathInfo.equals("/")) {
                String specialtyId = pathInfo.substring(1); // Remove leading "/"
                Specialty specialty = specialtyService.findById(UUID.fromString(specialtyId));
                
                if (specialty == null) {
                    resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    resp.getWriter().write(buildErrorResponse("Specialty not found"));
                    return;
                }
                
                // Return single specialty
                resp.setStatus(HttpServletResponse.SC_OK);
                resp.getWriter().write("{\"status\":\"success\",\"data\":" + buildSpecialtyJson(specialty) + "}");
                return;
            }
            
            // Parse query parameters for list
            int page = parseIntParam(req.getParameter("page"), 1);
            int pageSize = parseIntParam(req.getParameter("size"), 10);
            String search = req.getParameter("search");
            String sortBy = req.getParameter("sort");
            String order = req.getParameter("order");

            // Validate parameters
            if (page < 1) page = 1;
            if (pageSize < 1 || pageSize > 100) pageSize = 10;

            // Fetch all specialties
            List<Specialty> allSpecialties = specialtyService.findAllSpecialties();



             // Apply search filter
            if (search != null && !search.trim().isEmpty()) {
                String searchLower = search.toLowerCase().trim();
                allSpecialties = allSpecialties.stream()
                    .filter(s -> 
                        (s.getName() != null && s.getName().toLowerCase().contains(searchLower)) ||
                        (s.getCode() != null && s.getCode().toLowerCase().contains(searchLower)) ||
                        (s.getDescription() != null && s.getDescription().toLowerCase().contains(searchLower))
                    )
                    .collect(Collectors.toList());
            }

            // Apply sorting
            if (sortBy != null && !sortBy.trim().isEmpty()) {
                Comparator<Specialty> comparator = getComparator(sortBy);
                if (comparator != null) {
                    if ("desc".equalsIgnoreCase(order)) {
                        comparator = comparator.reversed();
                    }
                    allSpecialties.sort(comparator);
                }
            }

            // Calculate pagination
            int totalElements = allSpecialties.size();
            int totalPages = (int) Math.ceil((double) totalElements / pageSize);
            int startIndex = (page - 1) * pageSize;
            int endIndex = Math.min(startIndex + pageSize, totalElements);

            // Get page data
            List<Specialty> pageSpecialties = allSpecialties.subList(startIndex, endIndex);

            // Build JSON response
            StringBuilder json = new StringBuilder();
            json.append("{\"status\":\"success\",\"data\":{");
            json.append("\"specialties\":[");
            
            for (int i = 0; i < pageSpecialties.size(); i++) {
                if (i > 0) json.append(",");
                json.append(buildSpecialtyJson(pageSpecialties.get(i)));
            }
            
            json.append("],\"pagination\":{");
            json.append("\"currentPage\":").append(page).append(",");
            json.append("\"pageSize\":").append(pageSize).append(",");
            json.append("\"totalElements\":").append(totalElements).append(",");
            json.append("\"totalPages\":").append(totalPages);
            json.append("}}}");

            resp.setStatus(HttpServletResponse.SC_OK);
            resp.getWriter().write(json.toString());

        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write(buildErrorResponse("Server error: " + e.getMessage()));
        }
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        try {
            String pathInfo = req.getPathInfo(); // e.g., /{id}
            
            if (pathInfo == null || pathInfo.isEmpty()) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                resp.getWriter().write(buildErrorResponse("Specialty ID required"));
                return;
            }

            // Parse path: /{id}
            String specialtyId = pathInfo.substring(1); // Remove leading slash
            
            // Check if specialty exists
            Specialty specialty = specialtyService.findById(UUID.fromString(specialtyId));
            if (specialty == null) {
                resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
                resp.getWriter().write(buildErrorResponse("Specialty not found"));
                return;
            }

            // Delete specialty
            specialtyService.delete(UUID.fromString(specialtyId));

            resp.setStatus(HttpServletResponse.SC_OK);
            resp.getWriter().write("{\"status\":\"success\",\"message\":\"Specialty deleted successfully\"}");

        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write(buildErrorResponse("Error deleting specialty: " + e.getMessage()));
        }
    }

    private int parseIntParam(String param, int defaultValue) {
        if (param == null || param.trim().isEmpty()) {
            return defaultValue;
        }
        try {
            return Integer.parseInt(param);
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }

    private Comparator<Specialty> getComparator(String sortBy) {
        switch (sortBy.toLowerCase()) {
            case "name":
                return Comparator.comparing(Specialty::getName, Comparator.nullsLast(String.CASE_INSENSITIVE_ORDER));
            case "code":
                return Comparator.comparing(Specialty::getCode, Comparator.nullsLast(String.CASE_INSENSITIVE_ORDER));
            default:
                return Comparator.comparing(Specialty::getName, Comparator.nullsLast(String.CASE_INSENSITIVE_ORDER));
        }
    }

    private String buildDepartmentJson(com.cliniqueDigitaleJEE.model.Department department) {
        if (department == null) return "null";
        StringBuilder json = new StringBuilder("{");
        json.append("\"id\":\"").append(escapeJson(department.getId().toString())).append("\",");
        json.append("\"code\":\"").append(escapeJson(department.getCode())).append("\",");
        json.append("\"name\":\"").append(escapeJson(department.getName())).append("\",");
        json.append("\"description\":\"").append(department.getDescription() != null ? escapeJson(department.getDescription()) : "").append("\",");
        json.append("\"isActive\":").append(department.isActive()).append(",");
        json.append("\"location\":\"").append(department.getLocation() != null ? escapeJson(department.getLocation()) : "").append("\",");
        json.append("\"contactInfo\":\"").append(department.getContactInfo() != null ? escapeJson(department.getContactInfo()) : "").append("\",");
        json.append("\"color\":\"").append(department.getColor() != null ? escapeJson(department.getColor()) : "").append("\",");
        json.append("\"createdAt\":\"").append(department.getCreatedAt() != null ? department.getCreatedAt().toString() : "").append("\"");
        json.append("}");
        return json.toString();
    }

    private String buildSpecialtyJson(Specialty specialty) {
        StringBuilder json = new StringBuilder("{");
        json.append("\"id\":\"").append(escapeJson(specialty.getId().toString())).append("\",");
        json.append("\"code\":\"").append(escapeJson(specialty.getCode())).append("\",");
        json.append("\"name\":\"").append(escapeJson(specialty.getName())).append("\",");
        json.append("\"description\":\"").append(specialty.getDescription() != null ? escapeJson(specialty.getDescription()) : "").append("\",");
        json.append("\"department\":").append(specialty.getDepartment() != null ? buildDepartmentJson(specialty.getDepartment()) : "null").append(",");
        json.append("\"doctorsCount\":").append(specialty.getDoctors() != null ? specialty.getDoctors().size() : 0).append(",");
        json.append("\"color\":\"").append(specialty.getColor() != null ? escapeJson(specialty.getColor()) : "").append("\",");
        json.append("\"isActive\":").append(specialty.isActive()).append(",");
        json.append("\"createdAt\":\"").append(specialty.getCreatedAt() != null ? specialty.getCreatedAt().toString() : "").append("\",");
        json.append("\"icon\":\"").append(specialty.getIcon() != null ? escapeJson(specialty.getIcon()) : "").append("\"");
        json.append("}");
        return json.toString();
    }

    private String buildErrorResponse(String message) {
        return String.format("{\"status\":\"error\",\"message\":\"%s\"}", escapeJson(message));
    }

    private String escapeJson(String str) {
        if (str == null) return "";
        return str.replace("\\", "\\\\")
                  .replace("\"", "\\\"")
                  .replace("\n", "\\n")
                  .replace("\r", "\\r")
                  .replace("\t", "\\t");
    }
}
