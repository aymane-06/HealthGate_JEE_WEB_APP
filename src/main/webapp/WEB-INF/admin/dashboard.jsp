<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tableau de bord Admin - Clinique Digitale</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="../components/sidebar.jsp" />
    
    <main class="main-content">
        <div class="d-flex justify-between align-center mb-4">
            <div>
                <h1>Tableau de bord</h1>
                <p class="text-muted">Vue d'ensemble de la clinique</p>
            </div>
            <button id="sidebar-toggle" class="btn btn-secondary">☰</button>
        </div>
        
        <div id="alert-container"></div>
        
        <!-- Statistics Cards -->
        <div class="row mb-4">
            <div class="col-3">
                <div class="stat-card">
                    <div class="stat-value">${stats.totalUsers}</div>
                    <div class="stat-label">Utilisateurs totaux</div>
                </div>
            </div>
            <div class="col-3">
                <div class="stat-card success">
                    <div class="stat-value">${stats.totalDoctors}</div>
                    <div class="stat-label">Docteurs</div>
                </div>
            </div>
            <div class="col-3">
                <div class="stat-card warning">
                    <div class="stat-value">${stats.totalPatients}</div>
                    <div class="stat-label">Patients</div>
                </div>
            </div>
            <div class="col-3">
                <div class="stat-card danger">
                    <div class="stat-value">${stats.todayAppointments}</div>
                    <div class="stat-label">RDV aujourd'hui</div>
                </div>
            </div>
        </div>
        
        <!-- Charts Row -->
        <div class="row mb-4">
            <div class="col-8">
                <div class="card">
                    <div class="card-header">
                        <h5>Rendez-vous par mois</h5>
                    </div>
                    <div class="card-body">
                        <canvas id="appointmentsChart" height="100"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-4">
                <div class="card">
                    <div class="card-header">
                        <h5>Taux de statuts</h5>
                    </div>
                    <div class="card-body">
                        <canvas id="statusChart"></canvas>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Recent Activity -->
        <div class="row">
            <div class="col-6">
                <div class="card">
                    <div class="card-header">
                        <h5>Nouveaux utilisateurs</h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>Nom</th>
                                        <th>Email</th>
                                        <th>Rôle</th>
                                        <th>Date</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${recentUsers}" var="user">
                                        <tr>
                                            <td>${user.firstName} ${user.lastName}</td>
                                            <td>${user.email}</td>
                                            <td><span class="badge badge-primary">${user.role}</span></td>
                                            <td>${user.createdAt}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="col-6">
                <div class="card">
                    <div class="card-header">
                        <h5>Prochains rendez-vous</h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>Patient</th>
                                        <th>Docteur</th>
                                        <th>Date & Heure</th>
                                        <th>Statut</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${upcomingAppointments}" var="apt">
                                        <tr>
                                            <td>${apt.patientName}</td>
                                            <td>${apt.doctorName}</td>
                                            <td>${apt.dateTime}</td>
                                            <td>
                                                <span class="badge badge-${apt.status == 'PLANNED' ? 'info' : 'success'}">
                                                    ${apt.status}
                                                </span>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- System Alerts -->
        <div class="row mt-4">
            <div class="col-12">
                <div class="card">
                    <div class="card-header">
                        <h5>Alertes système</h5>
                    </div>
                    <div class="card-body">
                        <div class="alert alert-warning">
                            <strong>⚠️ Attention:</strong> ${stats.inactiveDoctors} docteur(s) inactif(s)
                        </div>
                        <div class="alert alert-info">
                            <strong>ℹ️ Info:</strong> ${stats.pendingAppointments} rendez-vous en attente de confirmation
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
    
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.9.1/dist/chart.min.js"></script>
    <script>
        // Appointments Chart
        const appointmentsCtx = document.getElementById('appointmentsChart');
        if (appointmentsCtx) {
            new Chart(appointmentsCtx, {
                type: 'line',
                data: {
                    labels: ['Jan', 'Fév', 'Mar', 'Avr', 'Mai', 'Juin'],
                    datasets: [{
                        label: 'Rendez-vous',
                        data: [65, 78, 90, 81, 96, 105],
                        borderColor: '#2563eb',
                        backgroundColor: 'rgba(37, 99, 235, 0.1)',
                        tension: 0.4
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: false
                        }
                    }
                }
            });
        }
        
        // Status Chart
        const statusCtx = document.getElementById('statusChart');
        if (statusCtx) {
            new Chart(statusCtx, {
                type: 'doughnut',
                data: {
                    labels: ['Planifiés', 'Terminés', 'Annulés'],
                    datasets: [{
                        data: [45, 40, 15],
                        backgroundColor: ['#06b6d4', '#22c55e', '#ef4444']
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: true
                }
            });
        }
    </script>
</body>
</html>
