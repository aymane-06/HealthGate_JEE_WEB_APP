<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Prendre rendez-vous - Clinique Digitale</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="../components/sidebar.jsp" />
    
    <main class="main-content">
        <h1 class="mb-4">Prendre un rendez-vous</h1>
        
        <div id="alert-container"></div>
        
        <div class="row">
            <div class="col-8">
                <!-- Step 1: Select Specialty/Doctor -->
                <div class="card mb-3" id="step1">
                    <div class="card-header">
                        <h5>Étape 1: Choisir un docteur</h5>
                    </div>
                    <div class="card-body">
                        <div class="row mb-3">
                            <div class="col-6">
                                <label class="form-label">Filtrer par spécialité</label>
                                <select class="form-control form-select" id="specialtyFilter" 
                                        onchange="filterDoctors()">
                                    <option value="">Toutes les spécialités</option>
                                    <c:forEach items="${specialties}" var="specialty">
                                        <option value="${specialty.id}">${specialty.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-6">
                                <label class="form-label">Rechercher</label>
                                <input type="text" class="form-control" id="doctorSearch" 
                                       placeholder="Nom du docteur..." onkeyup="filterDoctors()">
                            </div>
                        </div>
                        
                        <div class="row" id="doctorsList">
                            <c:forEach items="${doctors}" var="doctor">
                                <div class="col-6 mb-3 doctor-card" 
                                     data-specialty="${doctor.specialtyId}" 
                                     data-name="${doctor.firstName} ${doctor.lastName}">
                                    <div class="card" style="cursor: pointer;" 
                                         onclick="selectDoctor('${doctor.id}', '${doctor.firstName} ${doctor.lastName}')">
                                        <div class="card-body">
                                            <div class="d-flex align-center">
                                                <div style="width: 60px; height: 60px; border-radius: 50%; 
                                                            background: var(--primary-color); color: white; 
                                                            display: flex; align-items: center; 
                                                            justify-content: center; font-size: 1.5rem; 
                                                            margin-right: 1rem;">
                                                    ${doctor.title}
                                                </div>
                                                <div>
                                                    <h6 class="mb-1">${doctor.title} ${doctor.firstName} ${doctor.lastName}</h6>
                                                    <p class="text-muted mb-1">
                                                        <strong>${doctor.specialtyName}</strong>
                                                    </p>
                                                    <p class="text-muted mb-0">
                                                        ${doctor.departmentName}
                                                    </p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
                
                <!-- Step 2: Select Date -->
                <div class="card mb-3" id="step2" style="display: none;">
                    <div class="card-header d-flex justify-between align-center">
                        <h5>Étape 2: Choisir une date</h5>
                        <button class="btn btn-sm btn-secondary" onclick="goToStep(1)">
                            ← Retour
                        </button>
                    </div>
                    <div class="card-body">
                        <div class="calendar">
                            <div class="calendar-header">
                                <button class="btn btn-sm btn-secondary" onclick="previousMonth()">‹</button>
                                <h4 id="currentMonth">Octobre 2025</h4>
                                <button class="btn btn-sm btn-secondary" onclick="nextMonth()">›</button>
                            </div>
                            <div class="calendar-weekdays mb-2" style="display: grid; grid-template-columns: repeat(7, 1fr); gap: 0.5rem;">
                                <div class="text-center font-weight-bold">Lun</div>
                                <div class="text-center font-weight-bold">Mar</div>
                                <div class="text-center font-weight-bold">Mer</div>
                                <div class="text-center font-weight-bold">Jeu</div>
                                <div class="text-center font-weight-bold">Ven</div>
                                <div class="text-center font-weight-bold">Sam</div>
                                <div class="text-center font-weight-bold">Dim</div>
                            </div>
                            <div class="calendar-grid" id="calendarGrid">
                                <!-- Calendar rendered by JS -->
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Step 3: Select Time -->
                <div class="card mb-3" id="step3" style="display: none;">
                    <div class="card-header d-flex justify-between align-center">
                        <h5>Étape 3: Choisir un créneau horaire</h5>
                        <button class="btn btn-sm btn-secondary" onclick="goToStep(2)">
                            ← Retour
                        </button>
                    </div>
                    <div class="card-body">
                        <div id="timeSlotsContainer">
                            <div class="text-center p-4 text-muted">
                                Sélectionnez une date pour voir les créneaux disponibles
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Step 4: Confirm -->
                <div class="card" id="step4" style="display: none;">
                    <div class="card-header d-flex justify-between align-center">
                        <h5>Étape 4: Confirmer le rendez-vous</h5>
                        <button class="btn btn-sm btn-secondary" onclick="goToStep(3)">
                            ← Retour
                        </button>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-6">
                                <h6>Détails du rendez-vous</h6>
                                <p><strong>Docteur:</strong> <span id="confirmDoctor"></span></p>
                                <p><strong>Date:</strong> <span id="confirmDate"></span></p>
                                <p><strong>Heure:</strong> <span id="confirmTime"></span></p>
                            </div>
                            <div class="col-6">
                                <div class="form-group">
                                    <label class="form-label required">Type de consultation</label>
                                    <select class="form-control form-select" id="appointmentType" required>
                                        <option value="">Sélectionner</option>
                                        <option value="CONSULTATION">Consultation</option>
                                        <option value="FOLLOW_UP">Suivi</option>
                                        <option value="EMERGENCY">Urgence</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label class="form-label">Notes (optionnel)</label>
                                    <textarea class="form-control" id="appointmentNotes" rows="3" 
                                              placeholder="Raison de la consultation..."></textarea>
                                </div>
                            </div>
                        </div>
                        
                        <button class="btn btn-primary btn-lg btn-block mt-3" onclick="confirmAppointment()">
                            Confirmer le rendez-vous
                        </button>
                    </div>
                </div>
            </div>
            
            <!-- Sidebar Summary -->
            <div class="col-4">
                <div class="card" style="position: sticky; top: 20px;">
                    <div class="card-header">
                        <h5>Récapitulatif</h5>
                    </div>
                    <div class="card-body">
                        <div class="mb-3">
                            <strong>Docteur:</strong>
                            <p id="summaryDoctor" class="text-muted">Non sélectionné</p>
                        </div>
                        <div class="mb-3">
                            <strong>Date:</strong>
                            <p id="summaryDate" class="text-muted">Non sélectionnée</p>
                        </div>
                        <div class="mb-3">
                            <strong>Heure:</strong>
                            <p id="summaryTime" class="text-muted">Non sélectionnée</p>
                        </div>
                        
                        <div class="alert alert-info mt-3">
                            <small>
                                <strong>ℹ️ À noter:</strong><br>
                                • Réservation minimum 2h à l'avance<br>
                                • Annulation possible 12h avant<br>
                                • Vous recevrez une confirmation par email
                            </small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
    
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
    <script>
        let currentStep = 1;
        let selectedDoctor = null;
        let selectedDoctorName = '';
        let selectedDate = null;
        let selectedTime = null;
        let currentDate = new Date();
        
        function filterDoctors() {
            const specialtyId = document.getElementById('specialtyFilter').value;
            const search = document.getElementById('doctorSearch').value.toLowerCase();
            const doctorCards = document.querySelectorAll('.doctor-card');
            
            doctorCards.forEach(card => {
                const matchesSpecialty = !specialtyId || card.dataset.specialty === specialtyId;
                const matchesSearch = !search || card.dataset.name.toLowerCase().includes(search);
                card.style.display = matchesSpecialty && matchesSearch ? 'block' : 'none';
            });
        }
        
        function selectDoctor(doctorId, doctorName) {
            selectedDoctor = doctorId;
            selectedDoctorName = doctorName;
            document.getElementById('summaryDoctor').textContent = doctorName;
            document.getElementById('confirmDoctor').textContent = doctorName;
            goToStep(2);
        }
        
        function goToStep(step) {
            // Hide all steps
            for (let i = 1; i <= 4; i++) {
                const stepEl = document.getElementById(`step${i}`);
                if (stepEl) stepEl.style.display = 'none';
            }
            
            // Show current step
            const currentStepEl = document.getElementById(`step${step}`);
            if (currentStepEl) currentStepEl.style.display = 'block';
            
            currentStep = step;
            
            // Render calendar if step 2
            if (step === 2) {
                renderCalendar();
            }
        }
        
        function renderCalendar() {
            const grid = document.getElementById('calendarGrid');
            const year = currentDate.getFullYear();
            const month = currentDate.getMonth();
            
            document.getElementById('currentMonth').textContent = 
                currentDate.toLocaleDateString('fr-FR', { month: 'long', year: 'numeric' });
            
            grid.innerHTML = '';
            
            const firstDay = new Date(year, month, 1).getDay();
            const daysInMonth = new Date(year, month + 1, 0).getDate();
            const today = new Date();
            
            // Empty cells
            for (let i = 0; i < (firstDay === 0 ? 6 : firstDay - 1); i++) {
                const emptyCell = document.createElement('div');
                emptyCell.className = 'calendar-day disabled';
                grid.appendChild(emptyCell);
            }
            
            // Days
            for (let day = 1; day <= daysInMonth; day++) {
                const date = new Date(year, month, day);
                const isPast = date < today;
                
                const dayCell = document.createElement('div');
                dayCell.className = 'calendar-day' + (isPast ? ' disabled' : '');
                dayCell.textContent = day;
                
                if (!isPast) {
                    dayCell.onclick = () => selectDate(year, month, day);
                }
                
                grid.appendChild(dayCell);
            }
        }
        
        function previousMonth() {
            currentDate.setMonth(currentDate.getMonth() - 1);
            renderCalendar();
        }
        
        function nextMonth() {
            currentDate.setMonth(currentDate.getMonth() + 1);
            renderCalendar();
        }
        
        function selectDate(year, month, day) {
            selectedDate = `${year}-${String(month + 1).padStart(2, '0')}-${String(day).padStart(2, '0')}`;
            const dateObj = new Date(year, month, day);
            const dateStr = dateObj.toLocaleDateString('fr-FR', { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' });
            
            document.getElementById('summaryDate').textContent = dateStr;
            document.getElementById('confirmDate').textContent = dateStr;
            
            loadTimeSlots();
            goToStep(3);
        }
        
        function loadTimeSlots() {
            const container = document.getElementById('timeSlotsContainer');
            container.innerHTML = '<div class="text-center p-4">Chargement...</div>';
            
            CliniqueApp.fetchData(`${pageContext.request.contextPath}/api/appointments/available-slots?doctorId=${selectedDoctor}&date=${selectedDate}`)
                .then(slots => {
                    if (slots.length === 0) {
                        container.innerHTML = '<div class="alert alert-warning">Aucun créneau disponible pour cette date</div>';
                        return;
                    }
                    
                    container.innerHTML = '<div class="time-slots"></div>';
                    const slotsGrid = container.querySelector('.time-slots');
                    
                    slots.forEach(slot => {
                        const slotEl = document.createElement('div');
                        slotEl.className = 'time-slot' + (!slot.available ? ' unavailable' : '');
                        slotEl.textContent = slot.time;
                        
                        if (slot.available) {
                            slotEl.onclick = () => selectTime(slot.time);
                        }
                        
                        slotsGrid.appendChild(slotEl);
                    });
                })
                .catch(error => {
                    container.innerHTML = '<div class="alert alert-danger">Erreur de chargement</div>';
                });
        }
        
        function selectTime(time) {
            selectedTime = time;
            document.getElementById('summaryTime').textContent = time;
            document.getElementById('confirmTime').textContent = time;
            goToStep(4);
        }
        
        function confirmAppointment() {
            const type = document.getElementById('appointmentType').value;
            const notes = document.getElementById('appointmentNotes').value;
            
            if (!type) {
                CliniqueApp.showAlert('Veuillez sélectionner un type de consultation', 'warning');
                return;
            }
            
            const data = {
                doctorId: selectedDoctor,
                date: selectedDate,
                time: selectedTime,
                type: type,
                notes: notes
            };
            
            CliniqueApp.fetchData('${pageContext.request.contextPath}/api/appointments', {
                method: 'POST',
                body: JSON.stringify(data)
            })
            .then(response => {
                CliniqueApp.showAlert('Rendez-vous confirmé avec succès!', 'success');
                setTimeout(() => {
                    window.location.href = '${pageContext.request.contextPath}/patient/appointments.jsp';
                }, 2000);
            })
            .catch(error => {
                CliniqueApp.showAlert('Erreur lors de la réservation', 'danger');
            });
        }
    </script>
</body>
</html>
