package com.cliniqueDigitaleJEE.controller;

import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Validation;

import java.io.IOException;

import com.cliniqueDigitaleJEE.dto.UserDTO;
import com.cliniqueDigitaleJEE.mapper.UserMapper;
import com.cliniqueDigitaleJEE.model.User;
import com.cliniqueDigitaleJEE.service.UserService;

/**
 * LoginServlet - Handles login page display and authentication
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Inject
    private UserService userService;

    @Inject
    private UserMapper userMapper;


    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        
        // If already logged in, redirect to appropriate dashboard
        if (session != null && session.getAttribute("user") != null) {
            String role = (String) session.getAttribute("userRole");
            resp.sendRedirect(req.getContextPath() + "/" + role.toLowerCase() + "/dashboard");
            return;
        }
        
        // Show login page
        req.getRequestDispatcher("/WEB-INF/auth/login.jsp").forward(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        
        try {
            // Mock authentication - replace with actual service call
            User user = userService.authenticate(email, password);


            if (user != null) {
                HttpSession session = req.getSession(true);
                UserDTO userDTO = userMapper.toDTO(user);
                
                // Mock user data - replace with actual user from database
                session.setAttribute("user", userDTO);
                session.setAttribute("userEmail", email);
                session.setAttribute("userRole", user.getRole());
                
                // Redirect based on role
                String role = (String) session.getAttribute("userRole");
                resp.sendRedirect(req.getContextPath() + "/" + role.toLowerCase() + "/dashboard");
            } else {
                req.setAttribute("error", "Email ou mot de passe incorrect");
                req.getRequestDispatcher("/WEB-INF/auth/login.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            req.setAttribute("error", "Une erreur est survenue. Veuillez réessayer.");
            req.getRequestDispatcher("/WEB-INF/auth/login.jsp").forward(req, resp);
        }
    }
    
}
