package com.cliniqueDigitaleJEE.controller.admin;

import com.cliniqueDigitaleJEE.mapper.DepartmentMapper;
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

    @Inject
    private DepartmentMapper departmentMapper;

    private final ObjectMapper objectMapper = new ObjectMapper();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        try {
            DepartmentDTO dto = objectMapper.readValue(req.getInputStream(), DepartmentDTO.class);
            Department department = new Department();
            department.setCode(dto.code);
            department.setName(dto.name);
            department.setDescription(dto.description);
            department.setActive(dto.isActive);
            department.setLocation(dto.location);
            department.setContactInfo(dto.contactInfo);
            department.setColor(dto.color);
            department.setCreatedAt(LocalDate.now());
            List<Specialty> specialties = null;
            if (dto.specialties != null) {
                if(dto.specialties.isEmpty()){
                    throw new Exception("At least one specialty must be selected");
                }
                specialties = new ArrayList<>();
                for (UUID sid : dto.specialties) {
                    Specialty s = specialtyService.findById(sid);
                    if(s.getDepartment()!=null){
                        throw new Exception("Specialty "+s.getName()+" is already assigned to another department : "+s.getDepartment().getName());
                    }
                    specialties.add(s);
                }
            }
            if (dto.headDoctorId != null) {
                Doctor doc = doctorService.findById(dto.headDoctorId);
                if(doc.getResponsibleDepartment()!=null){
                    throw new Exception("Doctor is already head of another department : "+doc.getResponsibleDepartment().getName());
                }
                department.setResponsibleDoctor(doc);
            }
            departmentService.saveDepartmentWithSpecialties(department, specialties, false);
            objectMapper.writeValue(resp.getWriter(), java.util.Map.of("status", "success", "id", department.getId()));
        } catch (Exception e) {
            resp.setStatus(400);
            objectMapper.writeValue(resp.getWriter(), java.util.Map.of("status", "error", "message", escapeJson(e.getMessage())));
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
                objectMapper.writeValue(resp.getWriter(), java.util.Map.of("status", "error", "message", "Department ID required in URL"));
                return;
            }
            String idStr = pathInfo.substring(1);
            UUID id = UUID.fromString(idStr);
            DepartmentDTO departmentDto = objectMapper.readValue(req.getInputStream(), DepartmentDTO.class);
            departmentDto.id = id;
            Department department = departmentService.findById(id);
            if (department == null) {
                resp.setStatus(404);
                objectMapper.writeValue(resp.getWriter(), java.util.Map.of("status", "error", "message", "Department not found"));
                return;
            }
            department.setCode(departmentDto.code);
            department.setName(departmentDto.name);
            department.setDescription(departmentDto.description);
            department.setActive(departmentDto.isActive);
            department.setLocation(departmentDto.location);
            department.setContactInfo(departmentDto.contactInfo);
            department.setColor(departmentDto.color);
            List<Specialty> specialties = new ArrayList<>();
            if (departmentDto.specialties != null) {
                for (UUID sid : departmentDto.specialties) {
                    Specialty s = specialtyService.findById(sid);
                    if(s.getDepartment()!=null && !s.getDepartment().getId().equals(department.getId())){
                        throw new Exception("Specialty "+s.getName()+" is already assigned to another department : "+s.getDepartment().getName());
                    }
                    specialties.add(s);
                }
            } else {
                department.setSpecialties(new ArrayList<>());
            }
            if (departmentDto.headDoctorId != null) {
                Doctor doc = doctorService.findById(departmentDto.headDoctorId);
                if(doc.getResponsibleDepartment()!=null && !doc.getResponsibleDepartment().getId().equals(department.getId())){
                    throw new Exception("Doctor is already head of another department : "+doc.getResponsibleDepartment().getName());
                }
                department.setResponsibleDoctor(doc);
            } else {
                department.setResponsibleDoctor(null);
            }
            departmentService.saveDepartmentWithSpecialties(department, specialties, true);
            objectMapper.writeValue(resp.getWriter(), java.util.Map.of("status", "success"));
        } catch (Exception e) {
            resp.setStatus(400);
            objectMapper.writeValue(resp.getWriter(), java.util.Map.of("status", "error", "message", escapeJson(e.getMessage())));
        }
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        String pathInfo = req.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            resp.setStatus(400);
            objectMapper.writeValue(resp.getWriter(), java.util.Map.of("status", "error", "message", "Department ID required"));
            return;
        }
        String idStr = pathInfo.substring(1);
        try {
            UUID id = UUID.fromString(idStr);
            departmentService.delete(id);
            objectMapper.writeValue(resp.getWriter(), java.util.Map.of("status", "success"));
        } catch (Exception e) {
            resp.setStatus(400);
            objectMapper.writeValue(resp.getWriter(), java.util.Map.of("status", "error", "message", escapeJson(e.getMessage())));
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

        try {
            if (pathInfo == null || pathInfo.equals("/")) {
                List<DepartmentDTO> departments = departmentService.findAllDepartments();
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
                        departments.removeIf(DepartmentDTO::isActive);
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
                int totalElements = departments.size();
                int pageSize = 9;
                int totalPages = (int) Math.ceil((double) totalElements / pageSize);
                int currentPage = Integer.parseInt(page != null ? page : "1");
                if (currentPage < 1) currentPage = 1;
                if (totalPages > 0 && currentPage > totalPages) currentPage = totalPages;
                int fromIndex = (currentPage - 1) * pageSize;
                if (fromIndex < 0) fromIndex = 0;
                int toIndex = Math.min(fromIndex + pageSize, totalElements);
                List<DepartmentDTO> pagedDepartments = departments.subList(fromIndex, toIndex);

                // Build response map
                java.util.Map<String, Object> response = new java.util.HashMap<>();
                response.put("status", "OK");
                java.util.Map<String, Object> data = new java.util.HashMap<>();
                data.put("departments", pagedDepartments);
                java.util.Map<String, Object> pagination = new java.util.HashMap<>();
                pagination.put("totalElements", totalElements);
                pagination.put("totalPages", totalPages);
                pagination.put("pageSize", pageSize);
                pagination.put("currentPage", currentPage);
                data.put("pagination", pagination);
                java.util.Map<String, Object> stats = new java.util.HashMap<>();
                stats.put("totalDepartments", totalElements);
                stats.put("totalStaff", 0);
                stats.put("monthlyAppointments", 0);
                stats.put("avgRating", 0.0);
                data.put("stats", stats);
                response.put("data", data);
                objectMapper.writeValue(resp.getWriter(), response);
            } else {
                String idStr = pathInfo.substring(1);
                try {
                    UUID id = UUID.fromString(idStr);
                    Department department = departmentService.findById(id);
                    if (department != null) {
                        java.util.Map<String, Object> response = new java.util.HashMap<>();
                        response.put("status", "OK");
                        response.put("data", departmentMapper.EntityToDto(department));
                        objectMapper.writeValue(resp.getWriter(), response);
                    } else {
                        resp.setStatus(404);
                        objectMapper.writeValue(resp.getWriter(), java.util.Map.of("status", "error", "message", "Department not found"));
                    }
                } catch (IllegalArgumentException e) {
                    resp.setStatus(400);
                    objectMapper.writeValue(resp.getWriter(), java.util.Map.of("status", "error", "message", "Invalid department ID format"));
                }
            }
        } catch (Exception e) {
            resp.setStatus(500);
            objectMapper.writeValue(resp.getWriter(), java.util.Map.of("status", "error", "message", "Internal server error: " + escapeJson(e.getMessage())));
        }
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
