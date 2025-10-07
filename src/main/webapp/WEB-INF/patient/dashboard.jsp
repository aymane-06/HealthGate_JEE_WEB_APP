<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tableau de bord Patient - Clinique Digitale</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="../components/sidebar.jsp" />
    
    <main class="main-content">
        <div class="d-flex justify-between align-center mb-4">
            <div>
                <h1>Bienvenue, ${sessionScope.user.firstName}</h1>
                <p class="text-muted">Votre espace santé</p>
            </div>
            <a href="${pageContext.request.contextPath}/patient/book-appointment.jsp" 
               class="btn btn-primary">
                📅 Prendre rendez-vous
            </a>
        </div>
        
        <div id="alert-container"></div>
        
        <!-- Quick Stats -->
        <div class="row mb-4">
            <div class="col-3">
                <div class="stat-card">
                    <div class="stat-value">${stats.upcomingAppointments}</div>
                    <div class="stat-label">RDV à venir</div>
                </div>
            </div>
            <div class="col-3">
                <div class="stat-card success">
                    <div class="stat-value">${stats.completedAppointments}</div>
                    <div class="stat-label">RDV terminés</div>
                </div>
            </div>
            <div class="col-3">
                <div class="stat-card warning">
                    <div class="stat-value">${stats.doctorsVisited}</div>
                    <div class="stat-label">Docteurs consultés</div>
                </div>
            </div>
            <div class="col-3">
                <div class="stat-card danger">
                    <div class="stat-value">${stats.medicalNotes}</div>
                    <div class="stat-label">Notes médicales</div>
                </div>
            </div>
        </div>
        
        <!-- Upcoming Appointments -->
        <div class="row mb-4">
            <div class="col-8">
                <div class="card">
                    <div class="card-header">
                        <h5>Prochains rendez-vous</h5>
                    </div>
                    <div class="card-body">
                        <c:if test="${empty upcomingAppointments}">
                            <div class="text-center p-4 text-muted">
                                <p>Aucun rendez-vous prévu</p>
                                <a href="${pageContext.request.contextPath}/patient/book-appointment.jsp" 
                                   class="btn btn-primary">
                                    Prendre rendez-vous
                                </a>
                            </div>
                        </c:if>
                        
                        <c:forEach items="${upcomingAppointments}" var="apt">
                            <div class="card mb-3">
                                <div class="card-body">
                                    <div class="row align-center">
                                        <div class="col-2 text-center">
                                            <div style="background: var(--primary-color); color: white; 
                                                        padding: 1rem; border-radius: 8px;">
                                                <div style="font-size: 1.5rem; font-weight: 700;">
                                                    ${apt.day}
                                                </div>
                                                <div style="font-size: 0.875rem;">
                                                    ${apt.month}
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-6">
                                            <h6 class="mb-1">Dr. ${apt.doctorName}</h6>
                                            <p class="text-muted mb-1">
                                                <strong>${apt.specialty}</strong> | ${apt.time}
                                            </p>
                                            <p class="text-muted mb-0">
                                                Type: ${apt.type}
                                            </p>
                                        </div>
                                        <div class="col-4 text-right">
                                            <span class="badge badge-info mb-2">${apt.status}</span>
                                            <br>
                                            <c:if test="${apt.canCancel}">
                                                <button class="btn btn-sm btn-danger" 
                                                        onclick="cancelAppointment('${apt.id}')">
                                                    Annuler
                                                </button>
                                            </c:if>
                                            <button class="btn btn-sm btn-info" 
                                                    onclick="viewAppointmentDetails('${apt.id}')">
                                                Détails
                                            </button>
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
                        <h5>Mon profil</h5>
                    </div>
                    <div class="card-body">
                        <p><strong>Nom:</strong> ${sessionScope.user.firstName} ${sessionScope.user.lastName}</p>
                        <p><strong>CIN:</strong> ${patient.cin}</p>
                        <p><strong>Date naissance:</strong> ${patient.dateOfBirth}</p>
                        <p><strong>Groupe sanguin:</strong> ${patient.bloodType}</p>
                        <p><strong>Téléphone:</strong> ${patient.phone}</p>
                        <a href="${pageContext.request.contextPath}/profile.jsp" class="btn btn-outline-primary btn-block">
                            Modifier profil
                        </a>
                    </div>
                </div>
                
                <div class="card">
                    <div class="card-header">
                        <h5>Actions rapides</h5>
                    </div>
                    <div class="card-body">
                        <a href="${pageContext.request.contextPath}/patient/book-appointment.jsp" 
                           class="btn btn-primary btn-block mb-2">
                            📅 Prendre RDV
                        </a>
                        <a href="${pageContext.request.contextPath}/patient/appointments.jsp" 
                           class="btn btn-outline-primary btn-block mb-2">
                            📋 Mes rendez-vous
                        </a>
                        <a href="${pageContext.request.contextPath}/patient/medical-history.jsp" 
                           class="btn btn-outline-primary btn-block">
                            📄 Historique médical
                        </a>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Recent Medical History -->
        <div class="card">
            <div class="card-header">
                <h5>Historique récent</h5>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Date</th>
                                <th>Docteur</th>
                                <th>Spécialité</th>
                                <th>Type</th>
                                <th>Note médicale</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${recentHistory}" var="record">
                                <tr>
                                    <td>${record.date}</td>
                                    <td>Dr. ${record.doctorName}</td>
                                    <td>${record.specialty}</td>
                                    <td><span class="badge badge-info">${record.type}</span></td>
                                    <td>
                                        <c:if test="${record.hasMedicalNote}">
                                            <span class="badge badge-success">✓ Disponible</span>
                                        </c:if>
                                        <c:if test="${!record.hasMedicalNote}">
                                            <span class="badge badge-secondary">N/A</span>
                                        </c:if>
                                    </td>
                                    <td>
                                        <c:if test="${record.hasMedicalNote}">
                                            <button class="btn btn-sm btn-info" 
                                                    onclick="viewMedicalNote('${record.id}')">
                                                📖 Voir note
                                            </button>
                                        </c:if>
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
        function cancelAppointment(appointmentId) {
            CliniqueApp.confirmAction('Voulez-vous vraiment annuler ce rendez-vous ?', () => {
                CliniqueApp.fetchData(`${pageContext.request.contextPath}/api/appointments/${appointmentId}/cancel`, {
                    method: 'PUT'
                })
                .then(() => {
                    CliniqueApp.showAlert('Rendez-vous annulé avec succès', 'success');
                    setTimeout(() => location.reload(), 1500);
                })
                .catch(error => {
                    CliniqueApp.showAlert('Erreur: Annulation non autorisée (moins de 12h)', 'danger');
                });
            });
        }
        
        function viewAppointmentDetails(appointmentId) {
            window.location.href = `${pageContext.request.contextPath}/patient/appointment-details?id=${appointmentId}`;
        }
        
        function viewMedicalNote(appointmentId) {
            window.location.href = `${pageContext.request.contextPath}/patient/medical-note?id=${appointmentId}`;
        }
    </script>
</body>
</html>
