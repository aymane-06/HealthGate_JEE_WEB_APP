<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des utilisateurs - Clinique Digitale</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="../components/sidebar.jsp" />
    
    <main class="main-content">
        <div class="d-flex justify-between align-center mb-4">
            <div>
                <h1>Gestion des utilisateurs</h1>
                <p class="text-muted">Gérer tous les comptes utilisateurs</p>
            </div>
            <button class="btn btn-primary" onclick="CliniqueApp.openModal('createUserModal')">
                + Nouvel utilisateur
            </button>
        </div>
        
        <div id="alert-container"></div>
        
        <!-- Filters -->
        <div class="card mb-4">
            <div class="card-body">
                <form class="row" id="filterForm">
                    <div class="col-3">
                        <input type="text" class="form-control" placeholder="Rechercher..." 
                               name="search" id="searchInput">
                    </div>
                    <div class="col-2">
                        <select class="form-control form-select" name="role" id="roleFilter">
                            <option value="">Tous les rôles</option>
                            <option value="ADMIN">Admin</option>
                            <option value="DOCTOR">Docteur</option>
                            <option value="PATIENT">Patient</option>
                            <option value="STAFF">Personnel</option>
                        </select>
                    </div>
                    <div class="col-2">
                        <select class="form-control form-select" name="status" id="statusFilter">
                            <option value="">Tous les statuts</option>
                            <option value="active">Actif</option>
                            <option value="inactive">Inactif</option>
                        </select>
                    </div>
                    <div class="col-2">
                        <button type="submit" class="btn btn-secondary">Filtrer</button>
                    </div>
                </form>
            </div>
        </div>
        
        <!-- Users Table -->
        <div class="card">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nom complet</th>
                                <th>Email</th>
                                <th>Rôle</th>
                                <th>Statut</th>
                                <th>Date création</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${users}" var="user">
                                <tr>
                                    <td>${user.id}</td>
                                    <td>${user.firstName} ${user.lastName}</td>
                                    <td>${user.email}</td>
                                    <td>
                                        <span class="badge badge-primary">${user.role}</span>
                                    </td>
                                    <td>
                                        <span class="badge badge-${user.active ? 'success' : 'danger'}">
                                            ${user.active ? 'Actif' : 'Inactif'}
                                        </span>
                                    </td>
                                    <td>${user.createdAt}</td>
                                    <td>
                                        <button class="btn btn-sm btn-info" 
                                                onclick="viewUser(${user.id})">
                                            👁️
                                        </button>
                                        <button class="btn btn-sm btn-warning" 
                                                onclick="editUser(${user.id})">
                                            ✏️
                                        </button>
                                        <button class="btn btn-sm btn-${user.active ? 'danger' : 'success'}" 
                                                onclick="toggleUserStatus(${user.id}, ${user.active})">
                                            ${user.active ? '🚫' : '✅'}
                                        </button>
                                        <button class="btn btn-sm btn-secondary" 
                                                onclick="resetPassword(${user.id})">
                                            🔑
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                
                <!-- Pagination -->
                <div class="d-flex justify-between align-center mt-3">
                    <div>
                        Affichage ${startIndex} à ${endIndex} sur ${totalUsers} utilisateurs
                    </div>
                    <div>
                        <button class="btn btn-sm btn-secondary" ${currentPage == 1 ? 'disabled' : ''}>
                            Précédent
                        </button>
                        <span class="ml-2 mr-2">Page ${currentPage} sur ${totalPages}</span>
                        <button class="btn btn-sm btn-secondary" ${currentPage == totalPages ? 'disabled' : ''}>
                            Suivant
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </main>
    
    <!-- Create User Modal -->
    <div class="modal" id="createUserModal">
        <div class="modal-dialog">
            <div class="modal-header">
                <h5 class="modal-title">Créer un utilisateur</h5>
                <button class="close" onclick="CliniqueApp.closeModal('createUserModal')">&times;</button>
            </div>
            <div class="modal-body">
                <form id="createUserForm">
                    <div class="form-group">
                        <label class="form-label required">Prénom</label>
                        <input type="text" class="form-control" name="firstName" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label required">Nom</label>
                        <input type="text" class="form-control" name="lastName" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label required">Email</label>
                        <input type="email" class="form-control" name="email" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label required">Rôle</label>
                        <select class="form-control form-select" name="role" required>
                            <option value="">Sélectionner</option>
                            <option value="ADMIN">Admin</option>
                            <option value="DOCTOR">Docteur</option>
                            <option value="PATIENT">Patient</option>
                            <option value="STAFF">Personnel</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label class="form-label required">Mot de passe</label>
                        <input type="password" class="form-control" name="password" minlength="8" required>
                    </div>
                    <div class="form-check">
                        <input type="checkbox" class="form-check-input" name="active" checked>
                        <label class="form-check-label">Compte actif</label>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button class="btn btn-secondary" onclick="CliniqueApp.closeModal('createUserModal')">
                    Annuler
                </button>
                <button class="btn btn-primary" onclick="createUser()">
                    Créer
                </button>
            </div>
        </div>
    </div>
    
    <!-- View User Modal -->
    <div class="modal" id="viewUserModal">
        <div class="modal-dialog">
            <div class="modal-header">
                <h5 class="modal-title">Détails utilisateur</h5>
                <button class="close" onclick="CliniqueApp.closeModal('viewUserModal')">&times;</button>
            </div>
            <div class="modal-body" id="userDetailsContent">
                <!-- Content loaded dynamically -->
            </div>
            <div class="modal-footer">
                <button class="btn btn-secondary" onclick="CliniqueApp.closeModal('viewUserModal')">
                    Fermer
                </button>
            </div>
        </div>
    </div>
    
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
    <script>
        function createUser() {
            if (!CliniqueApp.validateForm('createUserForm')) return;
            
            const formData = new FormData(document.getElementById('createUserForm'));
            const data = Object.fromEntries(formData);
            
            CliniqueApp.fetchData('${pageContext.request.contextPath}/api/users', {
                method: 'POST',
                body: JSON.stringify(data)
            })
            .then(response => {
                CliniqueApp.showAlert('Utilisateur créé avec succès', 'success');
                CliniqueApp.closeModal('createUserModal');
                setTimeout(() => location.reload(), 1500);
            })
            .catch(error => {
                CliniqueApp.showAlert('Erreur lors de la création', 'danger');
            });
        }
        
        function viewUser(userId) {
            CliniqueApp.showLoading('userDetailsContent');
            CliniqueApp.openModal('viewUserModal');
            
            CliniqueApp.fetchData(`${pageContext.request.contextPath}/api/users/${userId}`)
                .then(user => {
                    document.getElementById('userDetailsContent').innerHTML = `
                        <div class="row">
                            <div class="col-6">
                                <p><strong>ID:</strong> ${user.id}</p>
                                <p><strong>Nom:</strong> ${user.firstName} ${user.lastName}</p>
                                <p><strong>Email:</strong> ${user.email}</p>
                            </div>
                            <div class="col-6">
                                <p><strong>Rôle:</strong> <span class="badge badge-primary">${user.role}</span></p>
                                <p><strong>Statut:</strong> <span class="badge badge-${user.active ? 'success' : 'danger'}">${user.active ? 'Actif' : 'Inactif'}</span></p>
                                <p><strong>Créé le:</strong> ${CliniqueApp.formatDate(user.createdAt)}</p>
                            </div>
                        </div>
                    `;
                });
        }
        
        function editUser(userId) {
            // Redirect to edit page or open edit modal
            window.location.href = `${pageContext.request.contextPath}/admin/users/edit?id=${userId}`;
        }
        
        function toggleUserStatus(userId, currentStatus) {
            const action = currentStatus ? 'désactiver' : 'activer';
            CliniqueApp.confirmAction(`Voulez-vous vraiment ${action} cet utilisateur ?`, () => {
                CliniqueApp.fetchData(`${pageContext.request.contextPath}/api/users/${userId}/toggle-status`, {
                    method: 'PUT'
                })
                .then(() => {
                    CliniqueApp.showAlert(`Utilisateur ${action === 'désactiver' ? 'désactivé' : 'activé'} avec succès`, 'success');
                    setTimeout(() => location.reload(), 1500);
                });
            });
        }
        
        function resetPassword(userId) {
            CliniqueApp.confirmAction('Voulez-vous vraiment réinitialiser le mot de passe ?', () => {
                CliniqueApp.fetchData(`${pageContext.request.contextPath}/api/users/${userId}/reset-password`, {
                    method: 'POST'
                })
                .then(() => {
                    CliniqueApp.showAlert('Email de réinitialisation envoyé', 'success');
                });
            });
        }
    </script>
</body>
</html>
