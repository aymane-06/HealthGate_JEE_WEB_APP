package com.cliniqueDigitaleJEE.controller.admin;

import com.cliniqueDigitaleJEE.model.Department;
import com.cliniqueDigitaleJEE.model.Doctor;
import com.cliniqueDigitaleJEE.model.Specialty;
import com.cliniqueDigitaleJEE.service.DepartmentService;
import com.cliniqueDigitaleJEE.service.SpecialtyService;
import com.cliniqueDigitaleJEE.service.DoctorService;
import com.cliniqueDigitaleJEE.dto.DepartmentDTO;

import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.inject.Inject;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@WebServlet(urlPatterns = {"/api/admin/departments", "/api/admin/departments/*"})
public class AdminDepartmentApiServlet extends HttpServlet {


    @Inject
    private DepartmentService departmentService;

    @Inject
    private SpecialtyService specialtyService;

    @Inject
    private DoctorService doctorService;

    private final ObjectMapper objectMapper = new ObjectMapper();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        try {
            DepartmentDTO dto = objectMapper.readValue(req.getInputStream(), DepartmentDTO.class);
            Department department = new Department();
            department.setId(dto.id);
            department.setCode(dto.code);
            department.setName(dto.name);
            department.setDescription(dto.description);
            department.setActive(dto.isActive);
            department.setLocation(dto.location);
            department.setContactInfo(dto.contactInfo);
            department.setColor(dto.color);
            department.setCreatedAt(LocalDate.now());
            // Set specialties
            if (dto.specialties != null) {
                List<Specialty> specialties = new ArrayList<>();
                for (UUID sid : dto.specialties) {
                    Specialty s = specialtyService.findById(sid);
                    if (s != null) specialties.add(s);
                }
                department.setSpecialties(specialties);
            }
            // Set responsible doctor
            if (dto.headDoctorId != null) {
                Doctor doc = doctorService.findById(dto.headDoctorId);
                department.setResponsibleDoctor(doc);
            }
            departmentService.save(department);
            resp.getWriter().write("{\"status\":\"success\",\"id\":\"" + department.getId() + "\"}");
        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(400);
            resp.getWriter().write("{\"status\":\"error\",\"message\":\"" + escapeJson(e.getMessage()) + "\"}");
        }
    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        try {
            String pathInfo = req.getPathInfo();
            if (pathInfo == null || pathInfo.equals("/")) {
                resp.setStatus(400);
                resp.getWriter().write("{\"status\":\"error\",\"message\":\"Department ID required in URL\"}");
                return;
            }
            String idStr = pathInfo.substring(1);
            UUID id = UUID.fromString(idStr);
            DepartmentDTO departmentDto = objectMapper.readValue(req.getInputStream(), DepartmentDTO.class);
            departmentDto.id = id;
            Department department = departmentService.findById(id);
            if (department == null) {
                resp.setStatus(404);
                resp.getWriter().write("{\"status\":\"error\",\"message\":\"Department not found\"}");
                return;
            }
            // Update fields
            department.setCode(departmentDto.code);
            department.setName(departmentDto.name);
            department.setDescription(departmentDto.description);
            department.setActive(departmentDto.isActive);
            department.setLocation(departmentDto.location);
            department.setContactInfo(departmentDto.contactInfo);
            department.setColor(departmentDto.color);
            // Update specialties
            if (departmentDto.specialties != null) {
                List<Specialty> specialties = new ArrayList<>();
                for (UUID sid : departmentDto.specialties) {
                    Specialty s = specialtyService.findById(sid);
                    if (s != null) specialties.add(s);
                }
                department.setSpecialties(specialties);
            } else {
                department.setSpecialties(new ArrayList<>());
            }
            // Update responsible doctor
            if (departmentDto.headDoctorId != null) {
                Doctor doc = doctorService.findById(departmentDto.headDoctorId);
                department.setResponsibleDoctor(doc);
            } else {
                department.setResponsibleDoctor(null);
            }
            departmentService.update(department);

            resp.getWriter().write("{\"status\":\"success\"}");
        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(400);
            resp.getWriter().write("{\"status\":\"error\",\"message\":\"" + escapeJson(e.getMessage()) + "\"}");
        }
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        String pathInfo = req.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            resp.setStatus(400);
            resp.getWriter().write("{\"status\":\"error\",\"message\":\"Department ID required\"}");
            return;
        }
        String idStr = pathInfo.substring(1);
        try {
            UUID id = UUID.fromString(idStr);
            departmentService.delete(id);
            resp.getWriter().write("{\"status\":\"success\"}");
        } catch (Exception e) {
            resp.setStatus(400);
            resp.getWriter().write("{\"status\":\"error\",\"message\":\"" + escapeJson(e.getMessage()) + "\"}");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.setHeader("Cache-Control", "no-cache");

        String pathInfo = req.getPathInfo();

        String search = req.getParameter("search");
        String sortBy = req.getParameter("sort");
        String order = req.getParameter("order");
        String statusFilter = req.getParameter("status");
        String page = req.getParameter("page");
        System.out.println("Search: " + search + ", SortBy: " + sortBy + ", Order: " + order + ", Status: " + statusFilter);



        try {
            if (pathInfo == null || pathInfo.equals("/")) {
                // Get all departments
                List<Department> departments = departmentService.findAllDepartments();
                if (search != null && !search.trim().isEmpty()) {
                    String lowerSearch = search.toLowerCase();
                    departments.removeIf(d -> !(d.getName() != null && d.getName().toLowerCase().contains(lowerSearch)) &&
                                              !(d.getCode() != null && d.getCode().toLowerCase().contains(lowerSearch)) &&
                                              !(d.getDescription() != null && d.getDescription().toLowerCase().contains(lowerSearch)));
                }
                if (statusFilter != null) {
                    if (statusFilter.equalsIgnoreCase("active")) {
                        departments.removeIf(d -> !d.isActive());
                    } else if (statusFilter.equalsIgnoreCase("inactive")) {
                        departments.removeIf(d -> d.isActive());
                    }
                }
                if (sortBy != null) {
                    departments.sort((d1, d2) -> {
                        int cmp = 0;
                        if (sortBy.equalsIgnoreCase("name")) {
                            cmp = d1.getName().compareToIgnoreCase(d2.getName());
                        } else if (sortBy.equalsIgnoreCase("staffCount")) {
                            cmp = Integer.compare(d1.getSpecialties().size(), d2.getSpecialties().size());
                        } else if (sortBy.equalsIgnoreCase("createdAt")) {
                            cmp = d1.getCreatedAt().compareTo(d2.getCreatedAt());
                        }
                        return "desc".equalsIgnoreCase(order) ? -cmp : cmp;
                    });
                }



                // Dummy pagination and stats (replace with real logic if needed)
                int totalElements = departments.size();

                int pageSize = 9; // or get from request param
                int totalPages = (int) Math.ceil((double) totalElements / pageSize);

                int currentPage = 1;

                currentPage = Integer.parseInt(page != null ? page : "1");

                if (currentPage < 1) currentPage = 1;
                if (totalPages > 0 && currentPage > totalPages) currentPage = totalPages;
                int fromIndex = (currentPage - 1) * pageSize;
                if (fromIndex < 0) fromIndex = 0;
                int toIndex = Math.min(fromIndex + pageSize, totalElements);
                departments = departments.subList(fromIndex, toIndex);


                String pagination = String.format("\"pagination\":{\"totalElements\":%d,\"totalPages\":%d,\"pageSize\":%d,\"currentPage\":%d}", totalElements, totalPages, pageSize, currentPage);
                String stats = "\"stats\":{\"totalDepartments\":" + totalElements + ",\"totalStaff\":0,\"monthlyAppointments\":0,\"avgRating\":0.0}";

                StringBuilder sb = new StringBuilder();
                sb.append("{\"status\":\"OK\",\"data\":{");
                sb.append("\"departments\":").append(buildDepartmentsJson(departments)).append(",");
                sb.append(pagination).append(",");
                sb.append(stats);
                sb.append("}}\n");
                resp.getWriter().write(sb.toString());
            } else {
                // Get single department by ID
                String idStr = pathInfo.substring(1);
                try {
                    UUID id = UUID.fromString(idStr);
                    Department department = departmentService.findById(id);

                    if (department != null) {
                        StringBuilder sb = new StringBuilder();
                        sb.append("{\"status\":\"OK\",\"data\":");
                        sb.append(buildDepartmentJson(department));
                        sb.append("}");
                        resp.getWriter().write(sb.toString());
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
            resp.getWriter().write("{\"status\":\"error\",\"message\":\"Internal server error: " + escapeJson(e.getMessage()) + "\"}");
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
        StringBuilder sb = new StringBuilder();
        sb.append("{");
        sb.append("\"id\":\"").append(department.getId()).append("\",");
        sb.append("\"code\":\"").append(escapeJson(department.getCode())).append("\",");
        sb.append("\"name\":\"").append(escapeJson(department.getName())).append("\",");
        sb.append("\"description\":\"").append(escapeJson(department.getDescription())).append("\",");
    sb.append("\"isActive\":").append(department.isActive()).append(",");
        sb.append("\"location\":\"").append(escapeJson(department.getLocation())).append("\",");
        sb.append("\"contactInfo\":\"").append(escapeJson(department.getContactInfo())).append("\",");
        sb.append("\"color\":\"").append(escapeJson(department.getColor())).append("\",");
        // Specialties
        sb.append("\"specialties\":[");
        if (department.getSpecialties() != null) {
            for (int i = 0; i < department.getSpecialties().size(); i++) {
                var s = department.getSpecialties().get(i);
                sb.append("{\"id\":\"").append(s.getId()).append("\",\"name\":\"").append(escapeJson(s.getName())).append("\"}");
                if (i < department.getSpecialties().size() - 1) sb.append(",");
            }
        }
        sb.append("],");
        // Responsible Doctor
        sb.append("\"responsibleDoctor\":");
        if (department.getResponsibleDoctor() != null) {
            var d = department.getResponsibleDoctor();
            sb.append("{\"id\":\"").append(d.getId()).append("\",\"name\":\"").append(escapeJson(d.getName())).append("\",\"title\":\"").append(escapeJson(d.getTitle())).append("\"}");
        } else {
            sb.append("null");
        }
        sb.append("}");
        return sb.toString();
    } 

    private Department parseDepartmentFromRequest(HttpServletRequest req) throws IOException {
        // Assumes JSON body, parse manually (for simplicity, not using a JSON lib)
        // In production, use a JSON library like Jackson or Gson
        StringBuilder jb = new StringBuilder();
        String line;
        try (var reader = req.getReader()) {
            while ((line = reader.readLine()) != null)
                jb.append(line);
        }
        String body = jb.toString();
        Department department = new Department();
        // Parse fields (very basic, expects exact field names)
        department.setId(parseUUIDFromJson(body, "id"));
        department.setCode(parseStringFromJson(body, "code"));
        department.setName(parseStringFromJson(body, "name"));
        department.setDescription(parseStringFromJson(body, "description"));
    department.setActive(parseBooleanFromJson(body, "isActive"));
        department.setLocation(parseStringFromJson(body, "location"));
        department.setContactInfo(parseStringFromJson(body, "contactInfo"));
        department.setColor(parseStringFromJson(body, "color"));
        // Specialties (expects array of UUIDs)
        var specialtyIds = parseUUIDArrayFromJson(body, "specialties");
        if (specialtyIds != null) {
            var specialties = new java.util.ArrayList<com.cliniqueDigitaleJEE.model.Specialty>();
            for (UUID sid : specialtyIds) {
                var s = specialtyService.findById(sid);
                if (s != null) specialties.add(s);
            }
            department.setSpecialties(specialties);
        }
        // Responsible Doctor (expects UUID)
        UUID doctorId = parseUUIDFromJson(body, "responsibleDoctor");
        if (doctorId != null) {
            var doc = doctorService.findById(doctorId);
            department.setResponsibleDoctor(doc);
        }
        return department;
    }

    // --- Basic JSON parsing helpers (for demo, not robust) ---
    private String parseStringFromJson(String json, String key) {
        var m = java.util.regex.Pattern.compile("\""+key+"\":\"(.*?)\"").matcher(json);
        return m.find() ? m.group(1) : null;
    }
    private UUID parseUUIDFromJson(String json, String key) {
        String val = parseStringFromJson(json, key);
        if (val == null || val.isEmpty()) return null;
        try { return UUID.fromString(val); } catch (Exception e) { return null; }
    }
    private boolean parseBooleanFromJson(String json, String key) {
        var m = java.util.regex.Pattern.compile("\""+key+"\":(true|false)").matcher(json);
        return m.find() && Boolean.parseBoolean(m.group(1));
    }
    private java.util.List<UUID> parseUUIDArrayFromJson(String json, String key) {
    var m = java.util.regex.Pattern.compile("\\\""+key+"\\\":\\[(.*?)\\]").matcher(json);
        if (!m.find()) return null;
        String arr = m.group(1);
        var ids = new java.util.ArrayList<UUID>();
    var matcher = java.util.regex.Pattern.compile("\\\"([a-fA-F0-9\\-]+)\\\"").matcher(arr);
        while (matcher.find()) {
            try { ids.add(UUID.fromString(matcher.group(1))); } catch (Exception ignored) {}
        }
        return ids;
    }
    private String escapeJson(String value) {
        if (value == null) {
            return "";
        }
        return value.replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "\\r");
    }

}
