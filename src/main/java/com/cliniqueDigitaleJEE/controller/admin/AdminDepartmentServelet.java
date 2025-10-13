package com.cliniqueDigitaleJEE.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.annotation.WebServlet;

import java.io.IOException;

@WebServlet(urlPatterns = {"/admin/departments"})
public class AdminDepartmentServelet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    System.out.println("AdminDepartmentServelet: doGet called");
    req.getRequestDispatcher("/WEB-INF/admin/departments.jsp").forward(req, resp);
}


}

