<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mon Profil - Clinique Digitale</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="components/sidebar.jsp" />
    
    <main class="main-content">
        <h1 class="mb-4">Mon Profil</h1>
        
        <div id="alert-container"></div>
        
        <div class="row">
            <div class="col-8">
                <div class="card mb-3">
                    <div class="card-header">
                        <h5>Informations personnelles</h5>
                    </div>
                    <div class="card-body">
                        <form id="profileForm" action="${pageContext.request.contextPath}/profile/update" method="post">
                            <div class="row">
                                <div class="col-6">
                                    <div class="form-group">
                                        <label class="form-label required">Prénom</label>
                                        <input type="text" class="form-control" name="firstName" 
                                               value="${user.firstName}" required>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="form-group">
                                        <label class="form-label required">Nom</label>
                                        <input type="text" class="form-control" name="lastName" 
                                               value="${user.lastName}" required>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label class="form-label required">Email</label>
                                <input type="email" class="form-control" name="email" 
                                       value="${user.email}" required>
                            </div>
                            
                            <c:if test="${user.role == 'PATIENT'}">
                                <div class="row">
                                    <div class="col-6">
                                        <div class="form-group">
                                            <label class="form-label">CIN</label>
                                            <input type="text" class="form-control" name="cin" 
                                                   value="${patient.cin}" readonly>
                                        </div>
                                    </div>
                                    <div class="col-6">
                                        <div class="form-group">
                                            <label class="form-label">Date de naissance</label>
                                            <input type="date" class="form-control" name="dateOfBirth" 
                                                   value="${patient.dateOfBirth}">
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="row">
                                    <div class="col-4">
                                        <div class="form-group">
                                            <label class="form-label">Sexe</label>
                                            <select class="form-control form-select" name="gender">
                                                <option value="M" ${patient.gender == 'M' ? 'selected' : ''}>Homme</option>
                                                <option value="F" ${patient.gender == 'F' ? 'selected' : ''}>Femme</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-4">
                                        <div class="form-group">
                                            <label class="form-label">Groupe sanguin</label>
                                            <select class="form-control form-select" name="bloodType">
                                                <option value="">Sélectionner</option>
                                                <option value="A+" ${patient.bloodType == 'A+' ? 'selected' : ''}>A+</option>
                                                <option value="A-" ${patient.bloodType == 'A-' ? 'selected' : ''}>A-</option>
                                                <option value="B+" ${patient.bloodType == 'B+' ? 'selected' : ''}>B+</option>
                                                <option value="B-" ${patient.bloodType == 'B-' ? 'selected' : ''}>B-</option>
                                                <option value="AB+" ${patient.bloodType == 'AB+' ? 'selected' : ''}>AB+</option>
                                                <option value="AB-" ${patient.bloodType == 'AB-' ? 'selected' : ''}>AB-</option>
                                                <option value="O+" ${patient.bloodType == 'O+' ? 'selected' : ''}>O+</option>
                                                <option value="O-" ${patient.bloodType == 'O-' ? 'selected' : ''}>O-</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-4">
                                        <div class="form-group">
                                            <label class="form-label">Téléphone</label>
                                            <input type="tel" class="form-control" name="phone" 
                                                   value="${patient.phone}">
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <label class="form-label">Adresse</label>
                                    <textarea class="form-control" name="address" rows="2">${patient.address}</textarea>
                                </div>
                            </c:if>
                            
                            <c:if test="${user.role == 'DOCTOR'}">
                                <div class="row">
                                    <div class="col-4">
                                        <div class="form-group">
                                            <label class="form-label">Matricule</label>
                                            <input type="text" class="form-control" value="${doctor.matricule}" readonly>
                                        </div>
                                    </div>
                                    <div class="col-4">
                                        <div class="form-group">
                                            <label class="form-label">Titre</label>
                                            <input type="text" class="form-control" value="${doctor.title}" readonly>
                                        </div>
                                    </div>
                                    <div class="col-4">
                                        <div class="form-group">
                                            <label class="form-label">Spécialité</label>
                                            <input type="text" class="form-control" value="${doctor.specialtyName}" readonly>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                            
                            <button type="submit" class="btn btn-primary">
                                Enregistrer les modifications
                            </button>
                        </form>
                    </div>
                </div>
                
                <div class="card">
                    <div class="card-header">
                        <h5>Changer le mot de passe</h5>
                    </div>
                    <div class="card-body">
                        <form id="passwordForm" action="${pageContext.request.contextPath}/profile/change-password" method="post">
                            <div class="form-group">
                                <label class="form-label required">Mot de passe actuel</label>
                                <input type="password" class="form-control" name="currentPassword" required>
                            </div>
                            
                            <div class="row">
                                <div class="col-6">
                                    <div class="form-group">
                                        <label class="form-label required">Nouveau mot de passe</label>
                                        <input type="password" class="form-control" name="newPassword" 
                                               id="newPassword" minlength="8" required>
                                        <small class="form-text">Minimum 8 caractères</small>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="form-group">
                                        <label class="form-label required">Confirmer nouveau mot de passe</label>
                                        <input type="password" class="form-control" name="confirmPassword" 
                                               id="confirmPassword" required>
                                    </div>
                                </div>
                            </div>
                            
                            <button type="submit" class="btn btn-warning">
                                Changer le mot de passe
                            </button>
                        </form>
                    </div>
                </div>
            </div>
            
            <div class="col-4">
                <div class="card mb-3">
                    <div class="card-header">
                        <h5>Informations du compte</h5>
                    </div>
                    <div class="card-body">
                        <p><strong>Rôle:</strong> 
                            <span class="badge badge-primary">${user.role}</span>
                        </p>
                        <p><strong>Statut:</strong> 
                            <span class="badge badge-${user.active ? 'success' : 'danger'}">
                                ${user.active ? 'Actif' : 'Inactif'}
                            </span>
                        </p>
                        <p><strong>Membre depuis:</strong> ${user.createdAt}</p>
                        <p><strong>Dernière connexion:</strong> ${user.lastLogin}</p>
                    </div>
                </div>
                
                <div class="card">
                    <div class="card-header">
                        <h5>Préférences</h5>
                    </div>
                    <div class="card-body">
                        <div class="form-check mb-2">
                            <input type="checkbox" class="form-check-input" id="emailNotifications" checked>
                            <label class="form-check-label" for="emailNotifications">
                                Notifications email
                            </label>
                        </div>
                        <div class="form-check mb-2">
                            <input type="checkbox" class="form-check-input" id="smsNotifications">
                            <label class="form-check-label" for="smsNotifications">
                                Notifications SMS
                            </label>
                        </div>
                        <div class="form-check">
                            <input type="checkbox" class="form-check-input" id="reminders" checked>
                            <label class="form-check-label" for="reminders">
                                Rappels de RDV
                            </label>
                        </div>
                        
                        <button class="btn btn-outline-primary btn-block mt-3" onclick="savePreferences()">
                            Enregistrer les préférences
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </main>
    
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
    <script>
        // Password confirmation validation
        document.getElementById('passwordForm').addEventListener('submit', function(e) {
            const newPassword = document.getElementById('newPassword').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            if (newPassword !== confirmPassword) {
                e.preventDefault();
                CliniqueApp.showAlert('Les mots de passe ne correspondent pas', 'danger');
            }
        });
        
        function savePreferences() {
            const preferences = {
                emailNotifications: document.getElementById('emailNotifications').checked,
                smsNotifications: document.getElementById('smsNotifications').checked,
                reminders: document.getElementById('reminders').checked
            };
            
            CliniqueApp.fetchData('${pageContext.request.contextPath}/api/profile/preferences', {
                method: 'PUT',
                body: JSON.stringify(preferences)
            })
            .then(() => {
                CliniqueApp.showAlert('Préférences enregistrées', 'success');
            });
        }
    </script>
</body>
</html>
