package com.cliniqueDigitaleJEE.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * HomeServlet - Landing page and home navigation
 */
@WebServlet(urlPatterns = {"", "/", "/home", "/index"})
public class HomeServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        
        // If user is logged in, redirect to appropriate dashboard
        if (session != null && session.getAttribute("user") != null) {
            Object roleObj = session.getAttribute("userRole");
            String role = null;
            if (roleObj != null) {
                role = roleObj instanceof String ? (String) roleObj : roleObj.toString();
            }

            switch (role) {
                case "ADMIN":
                    resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
                    return;
                case "DOCTOR":
                    resp.sendRedirect(req.getContextPath() + "/doctor/dashboard");
                    return;
                case "PATIENT":
                    resp.sendRedirect(req.getContextPath() + "/patient/dashboard");
                    return;
                case "STAFF":
                    resp.sendRedirect(req.getContextPath() + "/staff/dashboard");
                    return;
            }
        }
        
        // Show landing page for non-logged-in users
        req.getRequestDispatcher("/WEB-INF/index.jsp").forward(req, resp);
    }
}
