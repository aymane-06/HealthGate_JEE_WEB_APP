<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tableau de bord Personnel - Clinique Digitale</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="../components/sidebar.jsp" />
    
    <main class="main-content">
        <div class="d-flex justify-between align-center mb-4">
            <div>
                <h1>Tableau de bord Personnel</h1>
                <p class="text-muted">Gestion administrative</p>
            </div>
            <button class="btn btn-primary" onclick="CliniqueApp.openModal('scheduleAppointmentModal')">
                + Planifier un rendez-vous
            </button>
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
                    <div class="stat-value">${stats.waitingList}</div>
                    <div class="stat-label">Liste d'attente</div>
                </div>
            </div>
            <div class="col-3">
                <div class="stat-card success">
                    <div class="stat-value">${stats.scheduledToday}</div>
                    <div class="stat-label">Planifiés ce jour</div>
                </div>
            </div>
            <div class="col-3">
                <div class="stat-card danger">
                    <div class="stat-value">${stats.canceledToday}</div>
                    <div class="stat-label">Annulés ce jour</div>
                </div>
            </div>
        </div>
        
        <!-- Appointments Overview -->
        <div class="row mb-4">
            <div class="col-8">
                <div class="card">
                    <div class="card-header d-flex justify-between align-center">
                        <h5>Rendez-vous du jour</h5>
                        <div>
                            <select class="form-control form-select" id="doctorFilter" 
                                    onchange="filterAppointments()" style="display: inline-block; width: auto;">
                                <option value="">Tous les docteurs</option>
                                <c:forEach items="${doctors}" var="doctor">
                                    <option value="${doctor.id}">${doctor.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>Heure</th>
                                        <th>Patient</th>
                                        <th>Docteur</th>
                                        <th>Type</th>
                                        <th>Statut</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${todayAppointments}" var="apt">
                                        <tr>
                                            <td><strong>${apt.time}</strong></td>
                                            <td>
                                                ${apt.patientName}<br>
                                                <small class="text-muted">${apt.patientPhone}</small>
                                            </td>
                                            <td>Dr. ${apt.doctorName}</td>
                                            <td><span class="badge badge-info">${apt.type}</span></td>
                                            <td>
                                                <span class="badge badge-${apt.status == 'PLANNED' ? 'primary' : 
                                                    apt.status == 'DONE' ? 'success' : 'danger'}">
                                                    ${apt.status}
                                                </span>
                                            </td>
                                            <td>
                                                <button class="btn btn-sm btn-info" 
                                                        onclick="viewAppointment('${apt.id}')">
                                                    👁️
                                                </button>
                                                <c:if test="${apt.status == 'PLANNED'}">
                                                    <button class="btn btn-sm btn-warning" 
                                                            onclick="rescheduleAppointment('${apt.id}')">
                                                        📅
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
            </div>
            
            <div class="col-4">
                <div class="card mb-3">
                    <div class="card-header">
                        <h5>Actions rapides</h5>
                    </div>
                    <div class="card-body">
                        <button class="btn btn-primary btn-block mb-2" 
                                onclick="CliniqueApp.openModal('scheduleAppointmentModal')">
                            📅 Planifier RDV
                        </button>
                        <a href="${pageContext.request.contextPath}/staff/waiting-list.jsp" 
                           class="btn btn-outline-primary btn-block mb-2">
                            ⏳ Liste d'attente (${stats.waitingList})
                        </a>
                        <button class="btn btn-outline-primary btn-block" 
                                onclick="printSchedule()">
                            🖨️ Imprimer planning
                        </button>
                    </div>
                </div>
                
                <div class="card">
                    <div class="card-header">
                        <h5>Notifications</h5>
                    </div>
                    <div class="card-body">
                        <c:forEach items="${notifications}" var="notif">
                            <div class="alert alert-${notif.type} mb-2">
                                <small><strong>${notif.time}</strong></small><br>
                                ${notif.message}
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Recent Activity -->
        <div class="card">
            <div class="card-header">
                <h5>Activité récente</h5>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Date & Heure</th>
                                <th>Action</th>
                                <th>Patient</th>
                                <th>Docteur</th>
                                <th>Par</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${recentActivity}" var="activity">
                                <tr>
                                    <td>${activity.timestamp}</td>
                                    <td>
                                        <span class="badge badge-${activity.actionType == 'CREATE' ? 'success' : 
                                            activity.actionType == 'CANCEL' ? 'danger' : 'warning'}">
                                            ${activity.action}
                                        </span>
                                    </td>
                                    <td>${activity.patientName}</td>
                                    <td>Dr. ${activity.doctorName}</td>
                                    <td>${activity.performedBy}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </main>
    
    <!-- Schedule Appointment Modal -->
    <div class="modal" id="scheduleAppointmentModal">
        <div class="modal-dialog" style="max-width: 800px;">
            <div class="modal-header">
                <h5 class="modal-title">Planifier un rendez-vous</h5>
                <button class="close" onclick="CliniqueApp.closeModal('scheduleAppointmentModal')">&times;</button>
            </div>
            <div class="modal-body">
                <form id="scheduleAppointmentForm">
                    <div class="row">
                        <div class="col-6">
                            <h6>Informations patient</h6>
                            <div class="form-group">
                                <label class="form-label">Patient existant</label>
                                <select class="form-control form-select" id="existingPatient" 
                                        onchange="toggleNewPatient()">
                                    <option value="">-- Nouveau patient --</option>
                                    <c:forEach items="${patients}" var="patient">
                                        <option value="${patient.id}">${patient.name} - ${patient.cin}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            
                            <div id="newPatientFields">
                                <div class="form-group">
                                    <label class="form-label required">Nom complet</label>
                                    <input type="text" class="form-control" name="patientName">
                                </div>
                                <div class="form-group">
                                    <label class="form-label required">CIN</label>
                                    <input type="text" class="form-control" name="patientCin">
                                </div>
                                <div class="form-group">
                                    <label class="form-label required">Téléphone</label>
                                    <input type="tel" class="form-control" name="patientPhone">
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-6">
                            <h6>Détails du rendez-vous</h6>
                            <div class="form-group">
                                <label class="form-label required">Docteur</label>
                                <select class="form-control form-select" name="doctorId" required>
                                    <option value="">Sélectionner</option>
                                    <c:forEach items="${doctors}" var="doctor">
                                        <option value="${doctor.id}">${doctor.name} - ${doctor.specialty}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-group">
                                <label class="form-label required">Date</label>
                                <input type="date" class="form-control" name="date" required>
                            </div>
                            <div class="form-group">
                                <label class="form-label required">Heure</label>
                                <input type="time" class="form-control" name="time" required>
                            </div>
                            <div class="form-group">
                                <label class="form-label required">Type</label>
                                <select class="form-control form-select" name="type" required>
                                    <option value="CONSULTATION">Consultation</option>
                                    <option value="FOLLOW_UP">Suivi</option>
                                    <option value="EMERGENCY">Urgence</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Notes</label>
                        <textarea class="form-control" name="notes" rows="2"></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button class="btn btn-secondary" onclick="CliniqueApp.closeModal('scheduleAppointmentModal')">
                    Annuler
                </button>
                <button class="btn btn-primary" onclick="scheduleAppointment()">
                    Planifier
                </button>
            </div>
        </div>
    </div>
    
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
    <script>
        function toggleNewPatient() {
            const existingPatient = document.getElementById('existingPatient').value;
            const newPatientFields = document.getElementById('newPatientFields');
            
            if (existingPatient) {
                newPatientFields.style.display = 'none';
                newPatientFields.querySelectorAll('input').forEach(input => input.required = false);
            } else {
                newPatientFields.style.display = 'block';
                newPatientFields.querySelectorAll('input').forEach(input => input.required = true);
            }
        }
        
        function scheduleAppointment() {
            if (!CliniqueApp.validateForm('scheduleAppointmentForm')) return;
            
            const formData = new FormData(document.getElementById('scheduleAppointmentForm'));
            const data = Object.fromEntries(formData);
            data.patientId = document.getElementById('existingPatient').value;
            
            CliniqueApp.fetchData('${pageContext.request.contextPath}/api/staff/appointments', {
                method: 'POST',
                body: JSON.stringify(data)
            })
            .then(() => {
                CliniqueApp.showAlert('Rendez-vous planifié avec succès', 'success');
                CliniqueApp.closeModal('scheduleAppointmentModal');
                setTimeout(() => location.reload(), 1500);
            });
        }
        
        function viewAppointment(appointmentId) {
            window.location.href = `${pageContext.request.contextPath}/staff/appointment-details?id=${appointmentId}`;
        }
        
        function rescheduleAppointment(appointmentId) {
            window.location.href = `${pageContext.request.contextPath}/staff/reschedule?id=${appointmentId}`;
        }
        
        function printSchedule() {
            window.print();
        }
        
        function filterAppointments() {
            // Implement filtering logic
            const doctorId = document.getElementById('doctorFilter').value;
            window.location.href = `${pageContext.request.contextPath}/staff/dashboard.jsp?doctorId=${doctorId}`;
        }
    </script>
</body>
</html>
