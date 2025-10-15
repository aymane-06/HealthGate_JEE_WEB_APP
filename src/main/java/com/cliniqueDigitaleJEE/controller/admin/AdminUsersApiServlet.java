package com.cliniqueDigitaleJEE.controller.admin;

import com.cliniqueDigitaleJEE.model.Doctor;
import com.cliniqueDigitaleJEE.model.Patient;
import com.cliniqueDigitaleJEE.model.STAFF;
import com.cliniqueDigitaleJEE.model.User;
import com.cliniqueDigitaleJEE.service.UserService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * RESTful API for User Management
 * Supports pagination, sorting, searching, and filtering
 */
@WebServlet(urlPatterns = {"/api/admin/users", "/api/admin/users/*"})
public class AdminUsersApiServlet extends HttpServlet {

    @Inject
    private UserService userService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.setHeader("Cache-Control", "no-cache");

        try {
            // Parse query parameters
            int page = parseIntParam(req.getParameter("page"), 1);
            int pageSize = parseIntParam(req.getParameter("size"), 10);
            String search = req.getParameter("search");
            String sortBy = req.getParameter("sort");
            String order = req.getParameter("order");
            String roleFilter = req.getParameter("role");
            String statusFilter = req.getParameter("status");

            // Validate parameters
            if (page < 1) page = 1;
            if (pageSize < 1 || pageSize > 100) pageSize = 10;

            // Fetch all users
            List<User> allUsers = userService.getAllUsers();

            // Apply search filter
            if (search != null && !search.trim().isEmpty()) {
                String searchLower = search.toLowerCase().trim();
                allUsers = allUsers.stream()
                        .filter(u ->
                                (u.getName() != null && u.getName().toLowerCase().contains(searchLower)) ||
                                        (u.getEmail() != null && u.getEmail().toLowerCase().contains(searchLower)) ||
                                        (u.getRole() != null && u.getRole().name().toLowerCase().contains(searchLower))
                        )
                        .collect(Collectors.toList());
            }

            // Apply role filter
            if (roleFilter != null && !roleFilter.trim().isEmpty() && !roleFilter.equals("ALL")) {
                allUsers = allUsers.stream()
                        .filter(u -> u.getRole() != null && u.getRole().name().equals(roleFilter))
                        .collect(Collectors.toList());
            }

            // Apply status filter
            if (statusFilter != null && !statusFilter.trim().isEmpty()) {
                boolean activeFilter = statusFilter.equalsIgnoreCase("active");
                allUsers = allUsers.stream()
                        .filter(u -> u.isActive() == activeFilter)
                        .collect(Collectors.toList());
            }

            // Apply sorting
            if (sortBy != null && !sortBy.trim().isEmpty()) {
                Comparator<User> comparator = getComparator(sortBy);
                if (comparator != null) {
                    if ("desc".equalsIgnoreCase(order)) {
                        comparator = comparator.reversed();
                    }
                    allUsers.sort(comparator);
                }
            }

            // Calculate pagination
            long totalElements = allUsers.size();
            int totalPages = (int) Math.ceil((double) totalElements / pageSize);
            int startIndex = (page - 1) * pageSize;
            int endIndex = Math.min(startIndex + pageSize, allUsers.size());

            // Get page data
            List<User> pageUsers = startIndex < allUsers.size()
                    ? allUsers.subList(startIndex, endIndex)
                    : List.of();

            // Build JSON response using simple maps to avoid circular references
            String json = buildJsonResponse(pageUsers, page, pageSize, totalPages, totalElements);

            resp.setStatus(HttpServletResponse.SC_OK);
            PrintWriter out = resp.getWriter();
            out.print(json);
            out.flush();

        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write(buildErrorResponse("Server error: " + e.getMessage()));
        }
    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        try {
            String pathInfo = req.getPathInfo(); // e.g., /{id}/status

            if (pathInfo == null || pathInfo.isEmpty()) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                resp.getWriter().write(buildErrorResponse("User ID required"));
                return;
            }

            // Parse path: /{id}/status
            String[] pathParts = pathInfo.split("/");
            if (pathParts.length < 3 || !pathParts[2].equals("status")) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                resp.getWriter().write(buildErrorResponse("Invalid endpoint"));
                return;
            }

            String userId = pathParts[1];

            // Read body to get new status
            String body = req.getReader().lines().collect(Collectors.joining());

            // Parse status from JSON: {"status": "ACTIVE"} or {"status": "INACTIVE"}
            boolean newStatus;
            if (body.contains("\"status\"")) {
                newStatus = body.contains("\"ACTIVE\"");
            } else {
                throw new IllegalArgumentException("Invalid request body: missing 'status' field");
            }

            // Update user status
            User user = userService.getUserById(userId);
            if (user == null) {
                resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
                resp.getWriter().write(buildErrorResponse("User not found"));
                return;
            }

            user.setActive(newStatus);
            userService.updateUser(user);

            resp.setStatus(HttpServletResponse.SC_OK);
            resp.getWriter().write("{\"status\":\"success\",\"message\":\"User status updated successfully\"}");

        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write(buildErrorResponse(e.getMessage()));
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
                resp.getWriter().write(buildErrorResponse("User ID required"));
                return;
            }

            // Parse path: /{id}
            String userId = pathInfo.substring(1); // Remove leading slash

            // Check if user exists
            User user = userService.getUserById(userId);
            if (user == null) {
                resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
                resp.getWriter().write(buildErrorResponse("User not found"));
                return;
            }

            // Delete user
            userService.deleteUser(userId);

            resp.setStatus(HttpServletResponse.SC_OK);
            resp.getWriter().write("{\"status\":\"success\",\"message\":\"User deleted successfully\"}");

        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write(buildErrorResponse("Error deleting user: " + e.getMessage()));
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

    private Comparator<User> getComparator(String sortBy) {
        switch (sortBy.toLowerCase()) {
            case "name":
                return Comparator.comparing(u -> u.getName() != null ? u.getName() : "", String.CASE_INSENSITIVE_ORDER);
            case "email":
                return Comparator.comparing(u -> u.getEmail() != null ? u.getEmail() : "", String.CASE_INSENSITIVE_ORDER);
            case "role":
                return Comparator.comparing(u -> u.getRole() != null ? u.getRole().name() : "");
            case "status":
                return Comparator.comparing(User::isActive).reversed();
            default:
                return null;
        }
    }

    private String buildJsonResponse(List<User> users, int currentPage, int pageSize, int totalPages, long totalElements) {
        // Use simple maps instead of direct object serialization to avoid circular references
        List<Map<String, Object>> userMaps = users.stream()
                .map(this::convertUserToMap)
                .collect(Collectors.toList());

        StringBuilder json = new StringBuilder();
        json.append("{");
        json.append("\"status\":\"success\",");
        json.append("\"data\":{");
        json.append("\"users\":[");

        for (int i = 0; i < userMaps.size(); i++) {
            Map<String, Object> userMap = userMaps.get(i);
            if (i > 0) json.append(",");
            json.append(mapToJson(userMap));
        }

        json.append("],");
        json.append("\"pagination\":{");
        json.append("\"currentPage\":").append(currentPage).append(",");
        json.append("\"pageSize\":").append(pageSize).append(",");
        json.append("\"totalPages\":").append(totalPages).append(",");
        json.append("\"totalElements\":").append(totalElements);
        json.append("}");
        json.append("}");
        json.append("}");

        return json.toString();
    }

    private Map<String, Object> convertUserToMap(User user) {
        Map<String, Object> userMap = new HashMap<>();
        userMap.put("id", user.getId().toString());
        userMap.put("name", user.getName());
        userMap.put("email", user.getEmail());
        userMap.put("role", user.getRole().name());
        userMap.put("active", user.isActive());

        // Add role-specific fields without circular references
        switch (user.getRole()) {
            case PATIENT:
                Patient patient = (Patient) user;
                userMap.put("cin", patient.getCIN());
                userMap.put("address", patient.getAddress());
                userMap.put("phone", patient.getPhone());
                userMap.put("birthDate", patient.getBirthDate());
                userMap.put("gender", patient.getGender() != null ? patient.getGender().name() : null);
                userMap.put("bloodType", patient.getBloodType());
                break;

            case DOCTOR:
                Doctor doctor = (Doctor) user;
                userMap.put("matricule", doctor.getMatricule());
                userMap.put("title", doctor.getTitle());

                // Only include basic info about specialty to avoid circular references
                if (doctor.getSpecialty() != null) {
                    Map<String, Object> specialtyMap = new HashMap<>();
                    specialtyMap.put("id", doctor.getSpecialty().getId().toString());
                    specialtyMap.put("name", doctor.getSpecialty().getName());
                    specialtyMap.put("code", doctor.getSpecialty().getCode());
                    userMap.put("specialty", specialtyMap);
                }

                // Only include basic info about department to avoid circular references
                if (doctor.getResponsibleDepartment() != null) {
                    Map<String, Object> deptMap = new HashMap<>();
                    deptMap.put("id", doctor.getResponsibleDepartment().getId().toString());
                    deptMap.put("name", doctor.getResponsibleDepartment().getName());
                    deptMap.put("code", doctor.getResponsibleDepartment().getCode());
                    userMap.put("responsibleDepartment", deptMap);
                }
                break;

            case STAFF:
                STAFF staff = (STAFF) user;
                userMap.put("position", staff.getPosition());
                userMap.put("employeeId", staff.getEmployeeId());
                break;

            case ADMIN:
                // No additional fields for admin
                break;
        }

        return userMap;
    }

    private String mapToJson(Map<String, Object> map) {
        StringBuilder json = new StringBuilder();
        json.append("{");

        boolean first = true;
        for (Map.Entry<String, Object> entry : map.entrySet()) {
            if (!first) json.append(",");
            first = false;

            json.append("\"").append(escapeJson(entry.getKey())).append("\":");

            Object value = entry.getValue();
            if (value == null) {
                json.append("null");
            } else if (value instanceof String) {
                json.append("\"").append(escapeJson(value.toString())).append("\"");
            } else if (value instanceof Boolean || value instanceof Number) {
                json.append(value);
            } else if (value instanceof Map) {
                json.append(mapToJson((Map<String, Object>) value));
            } else {
                json.append("\"").append(escapeJson(value.toString())).append("\"");
            }
        }

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