<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- Premium Sidebar Navigation Component -->
<aside class="sidebar">
    <div class="sidebar-header">
        <h3 style="display: flex; align-items: center; gap: 0.5rem;">
            <span style="font-size: 1.75rem;">🏥</span>
            <span>Clinique Digitale</span>
        </h3>
        <p class="text-muted" style="display: flex; align-items: center; gap: 0.5rem; margin: 0.5rem 0 0;">
            <span class="avatar avatar-sm" style="margin: 0;">
                ${sessionScope.user.firstName.substring(0,1)}${sessionScope.user.lastName.substring(0,1)}
            </span>
            <span style="flex: 1;">
                <strong>${sessionScope.user.firstName} ${sessionScope.user.lastName}</strong><br>
                <small style="opacity: 0.9; font-size: 0.8125rem;">${sessionScope.user.role}</small>
            </span>
        </p>
    </div>
    
    <ul class="sidebar-menu">
        <c:if test="${sessionScope.user.role == 'ADMIN'}">
            <li class="sidebar-menu-item">
                <a href="${pageContext.request.contextPath}/admin/dashboard" 
                   class="sidebar-menu-link ${pageContext.request.servletPath.contains('dashboard') ? 'active' : ''}">
                    <span class="sidebar-menu-icon">📊</span>
                    <span>Tableau de bord</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="${pageContext.request.contextPath}/admin/users" 
                   class="sidebar-menu-link ${pageContext.request.servletPath.contains('users') ? 'active' : ''}">
                    <span class="sidebar-menu-icon">👥</span>
                    <span>Utilisateurs</span>
                    <span class="badge-notification" style="position: relative; margin-left: auto;">3</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="${pageContext.request.contextPath}/admin/specialties" 
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
                <a href="${pageContext.request.contextPath}/doctor/dashboard" 
                   class="sidebar-menu-link ${pageContext.request.servletPath.contains('dashboard') ? 'active' : ''}">
                    <span class="sidebar-menu-icon">📊</span>
                    <span>Tableau de bord</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="${pageContext.request.contextPath}/doctor/availability" 
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
                    <span class="badge-notification" style="position: relative; margin-left: auto;">5</span>
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
                <a href="${pageContext.request.contextPath}/patient/dashboard" 
                   class="sidebar-menu-link ${pageContext.request.servletPath.contains('dashboard') ? 'active' : ''}">
                    <span class="sidebar-menu-icon">📊</span>
                    <span>Tableau de bord</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="${pageContext.request.contextPath}/patient/book-appointment" 
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
                    <span class="badge-notification" style="position: relative; margin-left: auto;">2</span>
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
                <a href="${pageContext.request.contextPath}/staff/dashboard" 
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
        
        <!-- Divider -->
        <li style="margin: 1.5rem 0.75rem 1rem; height: 1px; background: rgba(0, 0, 0, 0.1);"></li>
        
        <!-- Common menu items -->
        <li class="sidebar-menu-item">
            <a href="${pageContext.request.contextPath}/profile" 
               class="sidebar-menu-link ${pageContext.request.servletPath.contains('profile') ? 'active' : ''}">
                <span class="sidebar-menu-icon">⚙️</span>
                <span>Mon Profil</span>
            </a>
        </li>
        <li class="sidebar-menu-item">
            <a href="#" onclick="CliniqueApp.confirmAction('Voulez-vous vraiment vous déconnecter ?', () => window.location.href='${pageContext.request.contextPath}/logout'); return false;" 
               class="sidebar-menu-link" style="color: var(--danger-color);">
                <span class="sidebar-menu-icon">🚪</span>
                <span>Déconnexion</span>
            </a>
        </li>
    </ul>
    
    <!-- Sidebar Footer -->
    <div style="padding: 1.5rem; border-top: 1px solid rgba(0, 0, 0, 0.1); margin-top: auto;">
        <div style="display: flex; align-items: center; gap: 0.75rem; padding: 1rem; background: linear-gradient(135deg, rgba(0, 102, 204, 0.1), rgba(0, 163, 224, 0.05)); border-radius: 12px;">
            <span style="font-size: 2rem;">💡</span>
            <div style="flex: 1;">
                <strong style="font-size: 0.875rem; color: var(--gray-800);">Astuce du jour</strong>
                <p style="font-size: 0.75rem; color: var(--gray-600); margin: 0.25rem 0 0;">
                    Gardez votre profil à jour pour un meilleur suivi.
                </p>
            </div>
        </div>
    </div>
</aside>

<style>
    /* Additional sidebar enhancements */
    .sidebar-menu-link {
        position: relative;
    }
    
    .sidebar-menu-link .badge-notification {
        font-size: 0.625rem;
        min-width: 18px;
        height: 18px;
        padding: 0 5px;
    }
    
    /* Tooltip on hover */
    .sidebar-menu-link::after {
        content: attr(data-tooltip);
        position: absolute;
        left: 100%;
        top: 50%;
        transform: translateY(-50%);
        margin-left: 1rem;
        padding: 0.5rem 0.75rem;
        background: var(--gray-900);
        color: var(--white);
        border-radius: var(--radius);
        font-size: 0.8125rem;
        white-space: nowrap;
        opacity: 0;
        pointer-events: none;
        transition: var(--transition);
        z-index: 1000;
    }
    
    @media (min-width: 769px) {
        .sidebar:not(:hover) .sidebar-menu-link:hover::after {
            opacity: 1;
        }
    }
</style>
