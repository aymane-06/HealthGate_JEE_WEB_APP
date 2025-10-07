<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tableau de bord Docteur - Clinique Digitale</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="../components/sidebar.jsp" />
    
    <main class="main-content">
        <div class="d-flex justify-between align-center mb-4">
            <div>
                <h1>Bienvenue, Dr. ${sessionScope.user.lastName}</h1>
                <p class="text-muted">Votre tableau de bord</p>
            </div>
            <button id="sidebar-toggle" class="btn btn-secondary">☰</button>
        </div>
        
        <div id="alert-container"></div>
        
        <!-- Quick Stats -->
        <div class="row mb-4">
            <div class="col-3">
                <div class="stat-card">
                    <div class="stat-value">${stats.todayAppointments}</div>
                    <div class="stat-label">RDV aujourd'hui</div>
                </div>
            </div>
            <div class="col-3">
                <div class="stat-card warning">
                    <div class="stat-value">${stats.weekAppointments}</div>
                    <div class="stat-label">RDV cette semaine</div>
                </div>
            </div>
            <div class="col-3">
                <div class="stat-card success">
                    <div class="stat-value">${stats.completedAppointments}</div>
                    <div class="stat-label">RDV terminés</div>
                </div>
            </div>
            <div class="col-3">
                <div class="stat-card danger">
                    <div class="stat-value">${stats.totalPatients}</div>
                    <div class="stat-label">Patients suivis</div>
                </div>
            </div>
        </div>
        
        <!-- Today's Schedule -->
        <div class="row mb-4">
            <div class="col-8">
                <div class="card">
                    <div class="card-header">
                        <h5>Agenda du jour - ${currentDate}</h5>
                    </div>
                    <div class="card-body">
                        <c:if test="${empty todayAppointments}">
                            <div class="text-center p-4 text-muted">
                                Aucun rendez-vous prévu aujourd'hui
                            </div>
                        </c:if>
                        
                        <c:forEach items="${todayAppointments}" var="apt">
                            <div class="card mb-2" style="border-left: 4px solid 
                                ${apt.status == 'PLANNED' ? '#06b6d4' : 
                                  apt.status == 'DONE' ? '#22c55e' : '#ef4444'};">
                                <div class="card-body p-3">
                                    <div class="d-flex justify-between align-center">
                                        <div>
                                            <h6 class="mb-1">${apt.time} - ${apt.patientName}</h6>
                                            <p class="text-muted mb-1">
                                                Type: ${apt.type} | CIN: ${apt.patientCin}
                                            </p>
                                        </div>
                                        <div>
                                            <c:if test="${apt.status == 'PLANNED'}">
                                                <button class="btn btn-sm btn-success" 
                                                        onclick="completeAppointment('${apt.id}')">
                                                    ✓ Terminer
                                                </button>
                                                <button class="btn btn-sm btn-danger" 
                                                        onclick="cancelAppointment('${apt.id}')">
                                                    ✗ Annuler
                                                </button>
                                            </c:if>
                                            <c:if test="${apt.status == 'DONE'}">
                                                <button class="btn btn-sm btn-info" 
                                                        onclick="viewMedicalNote('${apt.id}')">
                                                    📄 Note
                                                </button>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
            
            <div class="col-4">
                <div class="card mb-3">
                    <div class="card-header">
                        <h5>Disponibilité cette semaine</h5>
                    </div>
                    <div class="card-body">
                        <c:forEach items="${weekAvailability}" var="day">
                            <div class="d-flex justify-between align-center mb-2 pb-2" 
                                 style="border-bottom: 1px solid #e5e7eb;">
                                <div>
                                    <strong>${day.name}</strong>
                                    <br>
                                    <small class="text-muted">${day.date}</small>
                                </div>
                                <div>
                                    <span class="badge badge-${day.available ? 'success' : 'danger'}">
                                        ${day.available ? 'Disponible' : 'Indisponible'}
                                    </span>
                                </div>
                            </div>
                        </c:forEach>
                        <a href="${pageContext.request.contextPath}/doctor/availability.jsp" 
                           class="btn btn-primary btn-block mt-3">
                            Gérer mes disponibilités
                        </a>
                    </div>
                </div>
                
                <div class="card">
                    <div class="card-header">
                        <h5>Actions rapides</h5>
                    </div>
                    <div class="card-body">
                        <a href="${pageContext.request.contextPath}/doctor/appointments.jsp" 
                           class="btn btn-outline-primary btn-block mb-2">
                            📋 Tous les rendez-vous
                        </a>
                        <a href="${pageContext.request.contextPath}/doctor/patients.jsp" 
                           class="btn btn-outline-primary btn-block">
                            👥 Mes patients
                        </a>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Recent Patients -->
        <div class="card">
            <div class="card-header">
                <h5>Patients récents</h5>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Patient</th>
                                <th>Dernier RDV</th>
                                <th>Type</th>
                                <th>Note médicale</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${recentPatients}" var="patient">
                                <tr>
                                    <td>
                                        <strong>${patient.name}</strong><br>
                                        <small class="text-muted">${patient.cin}</small>
                                    </td>
                                    <td>${patient.lastAppointmentDate}</td>
                                    <td>
                                        <span class="badge badge-info">${patient.appointmentType}</span>
                                    </td>
                                    <td>
                                        <c:if test="${patient.hasMedicalNote}">
                                            <span class="badge badge-success">✓</span>
                                        </c:if>
                                        <c:if test="${!patient.hasMedicalNote}">
                                            <span class="badge badge-warning">Manquante</span>
                                        </c:if>
                                    </td>
                                    <td>
                                        <button class="btn btn-sm btn-info" 
                                                onclick="viewPatientHistory('${patient.id}')">
                                            📖 Historique
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </main>
    
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
    <script>
        function completeAppointment(appointmentId) {
            CliniqueApp.confirmAction('Marquer ce rendez-vous comme terminé ?', () => {
                window.location.href = `${pageContext.request.contextPath}/doctor/medical-note?appointmentId=${appointmentId}`;
            });
        }
        
        function cancelAppointment(appointmentId) {
            CliniqueApp.confirmAction('Voulez-vous vraiment annuler ce rendez-vous ?', () => {
                CliniqueApp.fetchData(`${pageContext.request.contextPath}/api/appointments/${appointmentId}/cancel`, {
                    method: 'PUT'
                })
                .then(() => {
                    CliniqueApp.showAlert('Rendez-vous annulé', 'success');
                    setTimeout(() => location.reload(), 1500);
                });
            });
        }
        
        function viewMedicalNote(appointmentId) {
            window.location.href = `${pageContext.request.contextPath}/doctor/medical-note?appointmentId=${appointmentId}&mode=view`;
        }
        
        function viewPatientHistory(patientId) {
            window.location.href = `${pageContext.request.contextPath}/doctor/patient-history?patientId=${patientId}`;
        }
    </script>
</body>
</html>
