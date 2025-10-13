package com.cliniqueDigitaleJEE.controller.admin;

import com.cliniqueDigitaleJEE.model.Specialty;
import com.cliniqueDigitaleJEE.service.SpecialtyService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

/**
 * AdminSpecialtiesServlet - Manage medical specialties
 */
@WebServlet("/admin/specialties")
@MultipartConfig
public class AdminSpecialtiesServlet extends HttpServlet {
    
    @Inject
    private SpecialtyService specialtyService;
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!checkAdminAccess(req, resp)) return;
        
        req.getRequestDispatcher("/WEB-INF/admin/specialties.jsp").forward(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!checkAdminAccess(req, resp)) return;
        
        resp.setContentType("application/json");
        
        // Check if this is an update (specialtyId present) or create (no specialtyId)
        String specialtyId = req.getParameter("specialtyId");
        boolean isUpdate = specialtyId != null && !specialtyId.trim().isEmpty();
        
        String code = req.getParameter("code");
        String name = req.getParameter("name");
        String description = req.getParameter("description");
        
        
        
        // Validate required fields
        if (code == null || code.trim().isEmpty()) {
            String jsonResponse = "{\"status\":\"error\",\"message\":\"Code is required\"}";
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            resp.getWriter().write(jsonResponse);
            return;
        }
        
        if (name == null || name.trim().isEmpty()) {
            String jsonResponse = "{\"status\":\"error\",\"message\":\"Name is required\"}";
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            resp.getWriter().write(jsonResponse);
            return;
        }
        
        try {
            Specialty specialty;
            
            if (isUpdate) {
                // Update existing specialty
                specialty = specialtyService.findById(UUID.fromString(specialtyId));
                if (specialty == null) {
                    String jsonResponse = "{\"status\":\"error\",\"message\":\"Specialty not found\"}";
                    resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    resp.getWriter().write(jsonResponse);
                    return;
                }
                
                specialty.setCode(code);
                specialty.setName(name);
                specialty.setDescription(description);
                specialtyService.update(specialty);
                
                String jsonResponse = String.format(
                        "{\"status\":\"success\",\"message\":\"Specialty updated successfully\",\"data\":{\"code\":\"%s\",\"name\":\"%s\"}}",
                        code, name
                );
                resp.setStatus(HttpServletResponse.SC_OK);
                resp.getWriter().write(jsonResponse);
            } else {
                // Create new specialty
                specialty = new Specialty(code, name, description, null);
                specialtyService.save(specialty);
                
                String jsonResponse = String.format(
                        "{\"status\":\"success\",\"message\":\"Specialty created successfully\",\"data\":{\"code\":\"%s\",\"name\":\"%s\"}}",
                        code, name
                );
                resp.setStatus(HttpServletResponse.SC_OK);
                resp.getWriter().write(jsonResponse);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            String jsonResponse = String.format(
                    "{\"status\":\"error\",\"message\":\"%s\"}",
                    e.getMessage()
            );
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            resp.getWriter().write(jsonResponse);
        }
    }
    
    private boolean checkAdminAccess(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession(true);
        
        // TEMPORARILY DISABLED FOR UI TESTING - RE-ENABLE IN PRODUCTION!
        /*
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return false;
        }
        
        String userRole = (String) session.getAttribute("userRole");
        if (!"ADMIN".equals(userRole)) {
            resp.sendRedirect(req.getContextPath() + "/403");
            return false;
        }
        */
        
        // Create mock admin user for UI testing
        if (session.getAttribute("user") == null) {
            Map<String, Object> mockUser = new HashMap<>();
            mockUser.put("id", 1L);
            mockUser.put("firstName", "Mohammed");
            mockUser.put("lastName", "Alami");
            mockUser.put("email", "admin@clinique.ma");
            mockUser.put("role", "ADMIN");
            mockUser.put("active", true);
            mockUser.put("createdAt", "01/04/2025 10:00");
            mockUser.put("lastLogin", "07/10/2025 19:30");
            session.setAttribute("user", mockUser);
            session.setAttribute("userRole", "ADMIN");
            session.setAttribute("userEmail", "admin@clinique.ma");
        }
        
        return true;
    }
}
