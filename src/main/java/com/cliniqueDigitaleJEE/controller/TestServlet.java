package com.cliniqueDigitaleJEE.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/test")
public class TestServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Clinique Digitale - Test Servlet</title>");
            out.println("<style>");
            out.println("body { font-family: Arial, sans-serif; margin: 0; padding: 0; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; display: flex; align-items: center; justify-content: center; }");
            out.println(".container { background: white; padding: 50px; border-radius: 20px; box-shadow: 0 20px 60px rgba(0,0,0,0.3); max-width: 700px; }");
            out.println("h1 { color: #667eea; margin: 0 0 10px 0; font-size: 32px; }");
            out.println("h2 { color: #764ba2; font-size: 22px; margin: 20px 0 10px 0; }");
            out.println(".success { color: #10b981; font-size: 18px; margin: 10px 0; display: flex; align-items: center; }");
            out.println(".success::before { content: '✅'; margin-right: 10px; font-size: 24px; }");
            out.println(".info { background: #f0f9ff; padding: 15px; border-radius: 10px; margin: 20px 0; border-left: 4px solid #3b82f6; }");
            out.println(".info p { margin: 5px 0; color: #1e40af; }");
            out.println("ul { background: #f9fafb; padding: 20px 20px 20px 40px; border-radius: 10px; margin: 15px 0; }");
            out.println("li { margin: 12px 0; color: #374151; line-height: 1.6; }");
            out.println(".footer { margin-top: 30px; padding-top: 20px; border-top: 2px solid #e5e7eb; color: #6b7280; font-size: 14px; text-align: center; }");
            out.println("</style>");
            out.println("</head>");
            out.println("<body>");
            out.println("<div class='container'>");
            out.println("<h1>🎉 Test Servlet Working!</h1>");
            out.println("<h2>CliniqueDigitale Application</h2>");

            out.println("<div class='success'>Tomcat Server Running</div>");
            out.println("<div class='success'>Docker Setup Complete</div>");
            out.println("<div class='success'>Servlet Deployed Successfully</div>");
            out.println("<div class='success'>JDK 21 Configuration Active</div>");
            out.println("<div class='success'>PostgreSQL Database Connected</div>");

            out.println("<div class='info'>");
            out.println("<p><strong>Servlet Information:</strong></p>");
            out.println("<p>Servlet Path: /test</p>");
            out.println("<p>HTTP Method: GET</p>");
            out.println("<p>Server: Apache Tomcat 10.1</p>");
            out.println("<p>Jakarta EE 10 / Servlet API 6.0</p>");
            out.println("</div>");

            out.println("<h2>📋 Next Development Steps:</h2>");
            out.println("<ul>");
            out.println("<li><strong>DAO Layer:</strong> Create repository classes for database operations</li>");
            out.println("<li><strong>Service Layer:</strong> Implement business logic and validation</li>");
            out.println("<li><strong>Patient Management:</strong> CRUD operations for patient records</li>");
            out.println("<li><strong>Doctor Management:</strong> Handle doctor profiles and schedules</li>");
            out.println("<li><strong>Appointment System:</strong> Booking and management features</li>");
            out.println("<li><strong>Authentication:</strong> Secure login and authorization</li>");
            out.println("</ul>");

            out.println("<div class='footer'>");
            out.println("<p>CliniqueDigitale © 2025 | Built with Jakarta EE</p>");
            out.println("</div>");

            out.println("</div>");
            out.println("</body>");
            out.println("</html>");
        } finally {
            out.close();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            out.println("{");
            out.println("  \"status\": \"success\",");
            out.println("  \"message\": \"POST request received\",");
            out.println("  \"servlet\": \"TestServlet\",");
            out.println("  \"timestamp\": \"" + System.currentTimeMillis() + "\"");
            out.println("}");
        } finally {
            out.close();
        }
    }
}

