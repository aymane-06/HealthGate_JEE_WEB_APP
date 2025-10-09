package com.cliniqueDigitaleJEE.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;


/**
 * AdminUsersServlet - Manage users
 */
@WebServlet("/admin/users")
public class AdminUsersServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!checkAdminAccess(req, resp)) return;
        
        // TODO: Fetch users from service layer
        req.setAttribute("users", getMockUsers());
        
        req.getRequestDispatcher("/WEB-INF/admin/users.jsp").forward(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!checkAdminAccess(req, resp)) return;
    
        
        
        String action = req.getParameter("action");
        
        switch (action) {
            case "create":
                // TODO: Create user
                break;
            case "update":
                // TODO: Update user
                break;
            case "delete":
                // TODO: Delete user
                break;
        }
        
        resp.sendRedirect(req.getContextPath() + "/admin/users");
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
            
        }
        
        return true;
    }
    
    private Object getMockUsers() {
        return new Object[0];
    }
}
