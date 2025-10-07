<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- Sidebar Navigation Component -->
<aside class="sidebar">
    <div class="sidebar-header">
        <h3>Clinique Digitale</h3>
        <p class="text-muted">${sessionScope.user.role}</p>
    </div>
    
    <ul class="sidebar-menu">
        <c:if test="${sessionScope.user.role == 'ADMIN'}">
            <li class="sidebar-menu-item">
                <a href="${pageContext.request.contextPath}/admin/dashboard.jsp" 
                   class="sidebar-menu-link ${pageContext.request.servletPath.contains('dashboard') ? 'active' : ''}">
                    <span class="sidebar-menu-icon">📊</span>
                    <span>Tableau de bord</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="${pageContext.request.contextPath}/admin/users.jsp" 
                   class="sidebar-menu-link ${pageContext.request.servletPath.contains('users') ? 'active' : ''}">
                    <span class="sidebar-menu-icon">👥</span>
                    <span>Utilisateurs</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="${pageContext.request.contextPath}/admin/specialties.jsp" 
                   class="sidebar-menu-link ${pageContext.request.servletPath.contains('specialties') ? 'active' : ''}">
                    <span class="sidebar-menu-icon">🏥</span>
                    <span>Spécialités</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="${pageContext.request.contextPath}/admin/departments.jsp" 
                   class="sidebar-menu-link ${pageContext.request.servletPath.contains('departments') ? 'active' : ''}">
                    <span class="sidebar-menu-icon">🏢</span>
                    <span>Départements</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="${pageContext.request.contextPath}/admin/statistics.jsp" 
                   class="sidebar-menu-link ${pageContext.request.servletPath.contains('statistics') ? 'active' : ''}">
                    <span class="sidebar-menu-icon">📈</span>
                    <span>Statistiques</span>
                </a>
            </li>
        </c:if>
        
        <c:if test="${sessionScope.user.role == 'DOCTOR'}">
            <li class="sidebar-menu-item">
                <a href="${pageContext.request.contextPath}/doctor/dashboard.jsp" 
                   class="sidebar-menu-link ${pageContext.request.servletPath.contains('dashboard') ? 'active' : ''}">
                    <span class="sidebar-menu-icon">📊</span>
                    <span>Tableau de bord</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="${pageContext.request.contextPath}/doctor/availability.jsp" 
                   class="sidebar-menu-link ${pageContext.request.servletPath.contains('availability') ? 'active' : ''}">
                    <span class="sidebar-menu-icon">📅</span>
                    <span>Disponibilités</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="${pageContext.request.contextPath}/doctor/appointments.jsp" 
                   class="sidebar-menu-link ${pageContext.request.servletPath.contains('appointments') ? 'active' : ''}">
                    <span class="sidebar-menu-icon">📋</span>
                    <span>Rendez-vous</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="${pageContext.request.contextPath}/doctor/patients.jsp" 
                   class="sidebar-menu-link ${pageContext.request.servletPath.contains('patients') ? 'active' : ''}">
                    <span class="sidebar-menu-icon">👤</span>
                    <span>Patients</span>
                </a>
            </li>
        </c:if>
        
        <c:if test="${sessionScope.user.role == 'PATIENT'}">
            <li class="sidebar-menu-item">
                <a href="${pageContext.request.contextPath}/patient/dashboard.jsp" 
                   class="sidebar-menu-link ${pageContext.request.servletPath.contains('dashboard') ? 'active' : ''}">
                    <span class="sidebar-menu-icon">📊</span>
                    <span>Tableau de bord</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="${pageContext.request.contextPath}/patient/book-appointment.jsp" 
                   class="sidebar-menu-link ${pageContext.request.servletPath.contains('book') ? 'active' : ''}">
                    <span class="sidebar-menu-icon">📅</span>
                    <span>Prendre RDV</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="${pageContext.request.contextPath}/patient/appointments.jsp" 
                   class="sidebar-menu-link ${pageContext.request.servletPath.contains('appointments') ? 'active' : ''}">
                    <span class="sidebar-menu-icon">📋</span>
                    <span>Mes rendez-vous</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="${pageContext.request.contextPath}/patient/medical-history.jsp" 
                   class="sidebar-menu-link ${pageContext.request.servletPath.contains('medical-history') ? 'active' : ''}">
                    <span class="sidebar-menu-icon">📄</span>
                    <span>Historique médical</span>
                </a>
            </li>
        </c:if>
        
        <c:if test="${sessionScope.user.role == 'STAFF'}">
            <li class="sidebar-menu-item">
                <a href="${pageContext.request.contextPath}/staff/dashboard.jsp" 
                   class="sidebar-menu-link ${pageContext.request.servletPath.contains('dashboard') ? 'active' : ''}">
                    <span class="sidebar-menu-icon">📊</span>
                    <span>Tableau de bord</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="${pageContext.request.contextPath}/staff/schedule-appointment.jsp" 
                   class="sidebar-menu-link ${pageContext.request.servletPath.contains('schedule') ? 'active' : ''}">
                    <span class="sidebar-menu-icon">📅</span>
                    <span>Planifier RDV</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="${pageContext.request.contextPath}/staff/waiting-list.jsp" 
                   class="sidebar-menu-link ${pageContext.request.servletPath.contains('waiting') ? 'active' : ''}">
                    <span class="sidebar-menu-icon">⏳</span>
                    <span>Liste d'attente</span>
                </a>
            </li>
        </c:if>
        
        <!-- Common menu items -->
        <li class="sidebar-menu-item mt-4">
            <a href="${pageContext.request.contextPath}/profile.jsp" 
               class="sidebar-menu-link ${pageContext.request.servletPath.contains('profile') ? 'active' : ''}">
                <span class="sidebar-menu-icon">⚙️</span>
                <span>Profil</span>
            </a>
        </li>
        <li class="sidebar-menu-item">
            <a href="${pageContext.request.contextPath}/logout" class="sidebar-menu-link">
                <span class="sidebar-menu-icon">🚪</span>
                <span>Déconnexion</span>
            </a>
        </li>
    </ul>
</aside>
