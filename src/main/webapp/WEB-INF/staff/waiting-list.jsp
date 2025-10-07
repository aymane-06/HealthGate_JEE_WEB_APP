<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste d'attente - Clinique Digitale</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="../components/sidebar.jsp" />
    
    <main class="main-content">
        <h1 class="mb-4">Liste d'attente</h1>
        
        <div id="alert-container"></div>
        
        <div class="row">
            <div class="col-8">
                <div class="card">
                    <div class="card-header d-flex justify-between align-center">
                        <h5>Patients en attente</h5>
                        <span class="badge badge-warning" style="font-size: 1rem;">
                            ${waitingList.size()} patient(s)
                        </span>
                    </div>
                    <div class="card-body">
                        <c:if test="${empty waitingList}">
                            <div class="text-center p-4 text-muted">
                                Aucun patient en liste d'attente
                            </div>
                        </c:if>
                        
                        <c:forEach items="${waitingList}" var="item" varStatus="status">
                            <div class="card mb-3">
                                <div class="card-body">
                                    <div class="row align-center">
                                        <div class="col-1 text-center">
                                            <div style="width: 40px; height: 40px; border-radius: 50%; 
                                                        background: var(--warning-color); color: white; 
                                                        display: flex; align-items: center; 
                                                        justify-content: center; font-weight: 700;">
                                                ${status.index + 1}
                                            </div>
                                        </div>
                                        <div class="col-5">
                                            <h6 class="mb-1">${item.patientName}</h6>
                                            <p class="text-muted mb-0">
                                                CIN: ${item.patientCin} | Tél: ${item.patientPhone}
                                            </p>
                                        </div>
                                        <div class="col-3">
                                            <p class="mb-0">
                                                <strong>Spécialité demandée:</strong><br>
                                                ${item.specialtyName}
                                            </p>
                                            <p class="mb-0">
                                                <small class="text-muted">Ajouté le: ${item.addedDate}</small>
                                            </p>
                                        </div>
                                        <div class="col-3 text-right">
                                            <button class="btn btn-sm btn-success mb-1" 
                                                    onclick="assignAppointment('${item.id}')">
                                                ✓ Assigner
                                            </button>
                                            <button class="btn btn-sm btn-info mb-1" 
                                                    onclick="contactPatient('${item.patientPhone}')">
                                                📞 Contacter
                                            </button>
                                            <button class="btn btn-sm btn-danger" 
                                                    onclick="removeFromWaitingList('${item.id}')">
                                                ✗ Retirer
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
                        <h5>Créneaux disponibles</h5>
                    </div>
                    <div class="card-body">
                        <div class="form-group">
                            <label class="form-label">Spécialité</label>
                            <select class="form-control form-select" id="specialtyFilter" 
                                    onchange="loadAvailableSlots()">
                                <option value="">Toutes</option>
                                <c:forEach items="${specialties}" var="specialty">
                                    <option value="${specialty.id}">${specialty.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        
                        <div id="availableSlotsContainer">
                            <div class="text-center p-3 text-muted">
                                Sélectionnez une spécialité
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="card">
                    <div class="card-header">
                        <h5>Statistiques</h5>
                    </div>
                    <div class="card-body">
                        <p><strong>Total en attente:</strong> ${stats.totalWaiting}</p>
                        <p><strong>Assignés aujourd'hui:</strong> ${stats.assignedToday}</p>
                        <p><strong>Temps d'attente moyen:</strong> ${stats.avgWaitTime} jours</p>
                        <p><strong>Créneaux libérés:</strong> ${stats.freedSlots}</p>
                    </div>
                </div>
            </div>
        </div>
    </main>
    
    <!-- Assign Appointment Modal -->
    <div class="modal" id="assignAppointmentModal">
        <div class="modal-dialog">
            <div class="modal-header">
                <h5 class="modal-title">Assigner un rendez-vous</h5>
                <button class="close" onclick="CliniqueApp.closeModal('assignAppointmentModal')">&times;</button>
            </div>
            <div class="modal-body">
                <div id="patientInfo" class="mb-3"></div>
                
                <form id="assignAppointmentForm">
                    <input type="hidden" id="waitingListItemId" name="waitingListItemId">
                    
                    <div class="form-group">
                        <label class="form-label required">Docteur</label>
                        <select class="form-control form-select" name="doctorId" required 
                                onchange="loadDoctorAvailability()">
                            <option value="">Sélectionner</option>
                            <c:forEach items="${doctors}" var="doctor">
                                <option value="${doctor.id}">${doctor.name} - ${doctor.specialty}</option>
                            </c:forEach>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label required">Date</label>
                        <input type="date" class="form-control" name="date" required 
                               onchange="loadTimeSlots()">
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label required">Heure</label>
                        <select class="form-control form-select" name="time" id="timeSlots" required>
                            <option value="">Sélectionner une date d'abord</option>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Notes</label>
                        <textarea class="form-control" name="notes" rows="2"></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button class="btn btn-secondary" onclick="CliniqueApp.closeModal('assignAppointmentModal')">
                    Annuler
                </button>
                <button class="btn btn-primary" onclick="confirmAssignment()">
                    Assigner
                </button>
            </div>
        </div>
    </div>
    
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
    <script>
        function assignAppointment(waitingListItemId) {
            document.getElementById('waitingListItemId').value = waitingListItemId;
            
            // Load patient info
            CliniqueApp.fetchData(`${pageContext.request.contextPath}/api/waiting-list/${waitingListItemId}`)
                .then(item => {
                    document.getElementById('patientInfo').innerHTML = `
                        <div class="alert alert-info">
                            <strong>Patient:</strong> ${item.patientName}<br>
                            <strong>Spécialité demandée:</strong> ${item.specialtyName}
                        </div>
                    `;
                });
            
            CliniqueApp.openModal('assignAppointmentModal');
        }
        
        function loadDoctorAvailability() {
            // Load doctor's available dates
            const doctorId = document.querySelector('select[name="doctorId"]').value;
            if (!doctorId) return;
            
            // Set min date to today
            const dateInput = document.querySelector('input[name="date"]');
            dateInput.min = new Date().toISOString().split('T')[0];
        }
        
        function loadTimeSlots() {
            const doctorId = document.querySelector('select[name="doctorId"]').value;
            const date = document.querySelector('input[name="date"]').value;
            const timeSlots = document.getElementById('timeSlots');
            
            if (!doctorId || !date) return;
            
            timeSlots.innerHTML = '<option value="">Chargement...</option>';
            
            CliniqueApp.fetchData(`${pageContext.request.contextPath}/api/appointments/available-slots?doctorId=${doctorId}&date=${date}`)
                .then(slots => {
                    timeSlots.innerHTML = '<option value="">Sélectionner</option>';
                    slots.forEach(slot => {
                        if (slot.available) {
                            const option = document.createElement('option');
                            option.value = slot.time;
                            option.textContent = slot.time;
                            timeSlots.appendChild(option);
                        }
                    });
                });
        }
        
        function confirmAssignment() {
            if (!CliniqueApp.validateForm('assignAppointmentForm')) return;
            
            const formData = new FormData(document.getElementById('assignAppointmentForm'));
            const data = Object.fromEntries(formData);
            
            CliniqueApp.fetchData('${pageContext.request.contextPath}/api/waiting-list/assign', {
                method: 'POST',
                body: JSON.stringify(data)
            })
            .then(() => {
                CliniqueApp.showAlert('Rendez-vous assigné avec succès', 'success');
                CliniqueApp.closeModal('assignAppointmentModal');
                setTimeout(() => location.reload(), 1500);
            });
        }
        
        function contactPatient(phone) {
            window.location.href = `tel:${phone}`;
        }
        
        function removeFromWaitingList(itemId) {
            CliniqueApp.confirmAction('Retirer ce patient de la liste d\'attente ?', () => {
                CliniqueApp.fetchData(`${pageContext.request.contextPath}/api/waiting-list/${itemId}`, {
                    method: 'DELETE'
                })
                .then(() => {
                    CliniqueApp.showAlert('Patient retiré de la liste', 'success');
                    setTimeout(() => location.reload(), 1500);
                });
            });
        }
        
        function loadAvailableSlots() {
            const specialtyId = document.getElementById('specialtyFilter').value;
            const container = document.getElementById('availableSlotsContainer');
            
            if (!specialtyId) {
                container.innerHTML = '<div class="text-center p-3 text-muted">Sélectionnez une spécialité</div>';
                return;
            }
            
            container.innerHTML = '<div class="text-center p-3">Chargement...</div>';
            
            CliniqueApp.fetchData(`${pageContext.request.contextPath}/api/appointments/available-slots-summary?specialtyId=${specialtyId}`)
                .then(slots => {
                    if (slots.length === 0) {
                        container.innerHTML = '<div class="alert alert-warning">Aucun créneau disponible</div>';
                        return;
                    }
                    
                    let html = '';
                    slots.forEach(slot => {
                        html += `
                            <div class="card mb-2">
                                <div class="card-body p-2">
                                    <strong>${slot.doctorName}</strong><br>
                                    <small>${slot.date} - ${slot.availableSlots} créneau(x)</small>
                                </div>
                            </div>
                        `;
                    });
                    container.innerHTML = html;
                });
        }
    </script>
</body>
</html>
