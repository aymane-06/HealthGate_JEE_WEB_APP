<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mes disponibilités - Clinique Digitale</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="../components/sidebar.jsp" />
    
    <main class="main-content">
        <h1 class="mb-4">Gestion des disponibilités</h1>
        
        <div id="alert-container"></div>
        
        <div class="row">
            <div class="col-8">
                <div class="card">
                    <div class="card-header d-flex justify-between align-center">
                        <h5>Calendrier des disponibilités</h5>
                        <button class="btn btn-primary" onclick="CliniqueApp.openModal('addAvailabilityModal')">
                            + Ajouter disponibilité
                        </button>
                    </div>
                    <div class="card-body">
                        <div class="calendar">
                            <div class="calendar-header">
                                <button class="btn btn-sm btn-secondary" onclick="previousMonth()">‹</button>
                                <h4 id="currentMonth">Octobre 2025</h4>
                                <button class="btn btn-sm btn-secondary" onclick="nextMonth()">›</button>
                            </div>
                            <div class="calendar-weekdays mb-2">
                                <div class="text-center font-weight-bold">Lun</div>
                                <div class="text-center font-weight-bold">Mar</div>
                                <div class="text-center font-weight-bold">Mer</div>
                                <div class="text-center font-weight-bold">Jeu</div>
                                <div class="text-center font-weight-bold">Ven</div>
                                <div class="text-center font-weight-bold">Sam</div>
                                <div class="text-center font-weight-bold">Dim</div>
                            </div>
                            <div class="calendar-grid" id="calendarGrid">
                                <!-- Calendar days rendered by JS -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="col-4">
                <div class="card mb-3">
                    <div class="card-header">
                        <h5>Disponibilités récurrentes</h5>
                    </div>
                    <div class="card-body">
                        <c:forEach items="${recurringAvailabilities}" var="avail">
                            <div class="card mb-2">
                                <div class="card-body p-2">
                                    <div class="d-flex justify-between align-center">
                                        <div>
                                            <strong>${avail.dayOfWeek}</strong><br>
                                            <small>${avail.startTime} - ${avail.endTime}</small>
                                        </div>
                                        <button class="btn btn-sm btn-danger" 
                                                onclick="deleteAvailability('${avail.id}')">
                                            🗑️
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                
                <div class="card">
                    <div class="card-header">
                        <h5>Congés & Absences</h5>
                    </div>
                    <div class="card-body">
                        <button class="btn btn-warning btn-block" 
                                onclick="CliniqueApp.openModal('addLeaveModal')">
                            + Déclarer une absence
                        </button>
                        
                        <div class="mt-3">
                            <c:forEach items="${upcomingLeaves}" var="leave">
                                <div class="alert alert-warning mb-2">
                                    <strong>${leave.startDate}</strong> au <strong>${leave.endDate}</strong>
                                    <br>
                                    <small>${leave.reason}</small>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
    
    <!-- Add Availability Modal -->
    <div class="modal" id="addAvailabilityModal">
        <div class="modal-dialog">
            <div class="modal-header">
                <h5 class="modal-title">Ajouter une disponibilité</h5>
                <button class="close" onclick="CliniqueApp.closeModal('addAvailabilityModal')">&times;</button>
            </div>
            <div class="modal-body">
                <form id="addAvailabilityForm">
                    <div class="form-group">
                        <label class="form-label required">Type</label>
                        <select class="form-control form-select" name="type" id="availabilityType" onchange="toggleRecurring()">
                            <option value="single">Ponctuelle</option>
                            <option value="recurring">Récurrente</option>
                        </select>
                    </div>
                    
                    <div id="singleDateFields">
                        <div class="form-group">
                            <label class="form-label required">Date</label>
                            <input type="date" class="form-control" name="date" required>
                        </div>
                    </div>
                    
                    <div id="recurringFields" style="display: none;">
                        <div class="form-group">
                            <label class="form-label required">Jour de la semaine</label>
                            <select class="form-control form-select" name="dayOfWeek">
                                <option value="MONDAY">Lundi</option>
                                <option value="TUESDAY">Mardi</option>
                                <option value="WEDNESDAY">Mercredi</option>
                                <option value="THURSDAY">Jeudi</option>
                                <option value="FRIDAY">Vendredi</option>
                                <option value="SATURDAY">Samedi</option>
                                <option value="SUNDAY">Dimanche</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-6">
                            <div class="form-group">
                                <label class="form-label required">Heure début</label>
                                <input type="time" class="form-control" name="startTime" required>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="form-group">
                                <label class="form-label required">Heure fin</label>
                                <input type="time" class="form-control" name="endTime" required>
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
                <button class="btn btn-secondary" onclick="CliniqueApp.closeModal('addAvailabilityModal')">
                    Annuler
                </button>
                <button class="btn btn-primary" onclick="addAvailability()">
                    Ajouter
                </button>
            </div>
        </div>
    </div>
    
    <!-- Add Leave Modal -->
    <div class="modal" id="addLeaveModal">
        <div class="modal-dialog">
            <div class="modal-header">
                <h5 class="modal-title">Déclarer une absence</h5>
                <button class="close" onclick="CliniqueApp.closeModal('addLeaveModal')">&times;</button>
            </div>
            <div class="modal-body">
                <form id="addLeaveForm">
                    <div class="row">
                        <div class="col-6">
                            <div class="form-group">
                                <label class="form-label required">Date début</label>
                                <input type="date" class="form-control" name="startDate" required>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="form-group">
                                <label class="form-label required">Date fin</label>
                                <input type="date" class="form-control" name="endDate" required>
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label required">Type</label>
                        <select class="form-control form-select" name="leaveType" required>
                            <option value="">Sélectionner</option>
                            <option value="VACATION">Congé</option>
                            <option value="SICK_LEAVE">Maladie</option>
                            <option value="CONFERENCE">Conférence</option>
                            <option value="OTHER">Autre</option>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label required">Raison</label>
                        <textarea class="form-control" name="reason" rows="3" required></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button class="btn btn-secondary" onclick="CliniqueApp.closeModal('addLeaveModal')">
                    Annuler
                </button>
                <button class="btn btn-primary" onclick="addLeave()">
                    Déclarer
                </button>
            </div>
        </div>
    </div>
    
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
    <script>
        let currentDate = new Date();
        
        function toggleRecurring() {
            const type = document.getElementById('availabilityType').value;
            document.getElementById('singleDateFields').style.display = type === 'single' ? 'block' : 'none';
            document.getElementById('recurringFields').style.display = type === 'recurring' ? 'block' : 'none';
        }
        
        function renderCalendar() {
            const grid = document.getElementById('calendarGrid');
            const year = currentDate.getFullYear();
            const month = currentDate.getMonth();
            
            // Update month display
            document.getElementById('currentMonth').textContent = 
                currentDate.toLocaleDateString('fr-FR', { month: 'long', year: 'numeric' });
            
            // Clear grid
            grid.innerHTML = '';
            
            // Get first day and total days
            const firstDay = new Date(year, month, 1).getDay();
            const daysInMonth = new Date(year, month + 1, 0).getDate();
            
            // Add empty cells for days before first day
            for (let i = 0; i < (firstDay === 0 ? 6 : firstDay - 1); i++) {
                const emptyCell = document.createElement('div');
                emptyCell.className = 'calendar-day disabled';
                grid.appendChild(emptyCell);
            }
            
            // Add days
            for (let day = 1; day <= daysInMonth; day++) {
                const dayCell = document.createElement('div');
                dayCell.className = 'calendar-day';
                dayCell.textContent = day;
                dayCell.onclick = () => selectDate(year, month, day);
                grid.appendChild(dayCell);
            }
        }
        
        function selectDate(year, month, day) {
            const dateStr = `${year}-${String(month + 1).padStart(2, '0')}-${String(day).padStart(2, '0')}`;
            document.querySelector('input[name="date"]').value = dateStr;
            CliniqueApp.openModal('addAvailabilityModal');
        }
        
        function previousMonth() {
            currentDate.setMonth(currentDate.getMonth() - 1);
            renderCalendar();
        }
        
        function nextMonth() {
            currentDate.setMonth(currentDate.getMonth() + 1);
            renderCalendar();
        }
        
        function addAvailability() {
            if (!CliniqueApp.validateForm('addAvailabilityForm')) return;
            
            const formData = new FormData(document.getElementById('addAvailabilityForm'));
            const data = Object.fromEntries(formData);
            
            CliniqueApp.fetchData('${pageContext.request.contextPath}/api/availability', {
                method: 'POST',
                body: JSON.stringify(data)
            })
            .then(() => {
                CliniqueApp.showAlert('Disponibilité ajoutée avec succès', 'success');
                CliniqueApp.closeModal('addAvailabilityModal');
                setTimeout(() => location.reload(), 1500);
            });
        }
        
        function addLeave() {
            if (!CliniqueApp.validateForm('addLeaveForm')) return;
            
            const formData = new FormData(document.getElementById('addLeaveForm'));
            const data = Object.fromEntries(formData);
            
            CliniqueApp.fetchData('${pageContext.request.contextPath}/api/availability/leave', {
                method: 'POST',
                body: JSON.stringify(data)
            })
            .then(() => {
                CliniqueApp.showAlert('Absence déclarée avec succès', 'success');
                CliniqueApp.closeModal('addLeaveModal');
                setTimeout(() => location.reload(), 1500);
            });
        }
        
        function deleteAvailability(availId) {
            CliniqueApp.confirmAction('Supprimer cette disponibilité ?', () => {
                CliniqueApp.fetchData(`${pageContext.request.contextPath}/api/availability/${availId}`, {
                    method: 'DELETE'
                })
                .then(() => {
                    CliniqueApp.showAlert('Disponibilité supprimée', 'success');
                    setTimeout(() => location.reload(), 1500);
                });
            });
        }
        
        // Initialize calendar
        renderCalendar();
    </script>
</body>
</html>
