package com.cliniqueDigitaleJEE.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * ErrorServlet - Handles error pages
 */
@WebServlet({"/403", "/404", "/500"})
public class ErrorServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        
        switch (path) {
            case "/403":
                resp.setStatus(HttpServletResponse.SC_FORBIDDEN);
                req.setAttribute("errorCode", "403");
                req.setAttribute("errorTitle", "Accès Refusé");
                req.setAttribute("errorMessage", "Vous n'avez pas les permissions nécessaires pour accéder à cette page.");
                break;
            case "/404":
                resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
                req.setAttribute("errorCode", "404");
                req.setAttribute("errorTitle", "Page Non Trouvée");
                req.setAttribute("errorMessage", "La page que vous recherchez n'existe pas.");
                break;
            case "/500":
                resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                req.setAttribute("errorCode", "500");
                req.setAttribute("errorTitle", "Erreur Serveur");
                req.setAttribute("errorMessage", "Une erreur interne s'est produite. Veuillez réessayer plus tard.");
                break;
        }
        
        req.getRequestDispatcher("/WEB-INF/error.jsp").forward(req, resp);
    }
}
