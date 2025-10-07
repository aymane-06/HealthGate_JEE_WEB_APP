package com.cliniqueDigitaleJEE.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * AuthServlet - Redirect to login/register pages
 */
@WebServlet("/auth/*")
public class AuthServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pathInfo = req.getPathInfo();
        
        if (pathInfo == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        
        switch (pathInfo) {
            case "/login":
                resp.sendRedirect(req.getContextPath() + "/login");
                break;
            case "/register":
                resp.sendRedirect(req.getContextPath() + "/register");
                break;
            case "/forgot-password":
                req.getRequestDispatcher("/WEB-INF/auth/forgot-password.jsp").forward(req, resp);
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/404");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
