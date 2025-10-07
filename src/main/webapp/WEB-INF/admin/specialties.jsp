<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des spécialités - Clinique Digitale</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="../components/sidebar.jsp" />
    
    <main class="main-content">
        <div class="d-flex justify-between align-center mb-4">
            <div>
                <h1>Gestion des spécialités médicales</h1>
                <p class="text-muted">Gérer toutes les spécialités</p>
            </div>
            <button class="btn btn-primary" onclick="CliniqueApp.openModal('createSpecialtyModal')">
                + Nouvelle spécialité
            </button>
        </div>
        
        <div id="alert-container"></div>
        
        <!-- Specialties Grid -->
        <div class="row">
            <c:forEach items="${specialties}" var="specialty">
                <div class="col-4 mb-3">
                    <div class="card">
                        <div class="card-body">
                            <div class="d-flex justify-between align-center mb-2">
                                <h5>${specialty.name}</h5>
                                <span class="badge badge-info">${specialty.code}</span>
                            </div>
                            <p class="text-muted">${specialty.description}</p>
                            <div class="d-flex justify-between align-center mt-3">
                                <span class="text-muted">
                                    ${specialty.doctorCount} docteur(s)
                                </span>
                                <div>
                                    <button class="btn btn-sm btn-warning" 
                                            onclick="editSpecialty('${specialty.id}')">
                                        ✏️
                                    </button>
                                    <button class="btn btn-sm btn-danger" 
                                            onclick="deleteSpecialty('${specialty.id}')">
                                        🗑️
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </main>
    
    <!-- Create Specialty Modal -->
    <div class="modal" id="createSpecialtyModal">
        <div class="modal-dialog">
            <div class="modal-header">
                <h5 class="modal-title">Créer une spécialité</h5>
                <button class="close" onclick="CliniqueApp.closeModal('createSpecialtyModal')">&times;</button>
            </div>
            <div class="modal-body">
                <form id="createSpecialtyForm">
                    <div class="form-group">
                        <label class="form-label required">Code</label>
                        <input type="text" class="form-control" name="code" 
                               placeholder="Ex: CARDIO" required>
                        <small class="form-text">Code unique en majuscules</small>
                    </div>
                    <div class="form-group">
                        <label class="form-label required">Nom</label>
                        <input type="text" class="form-control" name="name" 
                               placeholder="Ex: Cardiologie" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Description</label>
                        <textarea class="form-control" name="description" rows="3" 
                                  placeholder="Description de la spécialité"></textarea>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Département</label>
                        <select class="form-control form-select" name="departmentId">
                            <option value="">Sélectionner un département</option>
                            <c:forEach items="${departments}" var="dept">
                                <option value="${dept.id}">${dept.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button class="btn btn-secondary" onclick="CliniqueApp.closeModal('createSpecialtyModal')">
                    Annuler
                </button>
                <button class="btn btn-primary" onclick="createSpecialty()">
                    Créer
                </button>
            </div>
        </div>
    </div>
    
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
    <script>
        function createSpecialty() {
            if (!CliniqueApp.validateForm('createSpecialtyForm')) return;
            
            const formData = new FormData(document.getElementById('createSpecialtyForm'));
            const data = Object.fromEntries(formData);
            
            CliniqueApp.fetchData('${pageContext.request.contextPath}/api/specialties', {
                method: 'POST',
                body: JSON.stringify(data)
            })
            .then(response => {
                CliniqueApp.showAlert('Spécialité créée avec succès', 'success');
                CliniqueApp.closeModal('createSpecialtyModal');
                setTimeout(() => location.reload(), 1500);
            })
            .catch(error => {
                CliniqueApp.showAlert('Erreur lors de la création', 'danger');
            });
        }
        
        function editSpecialty(specialtyId) {
            window.location.href = `${pageContext.request.contextPath}/admin/specialties/edit?id=${specialtyId}`;
        }
        
        function deleteSpecialty(specialtyId) {
            CliniqueApp.confirmAction('Voulez-vous vraiment supprimer cette spécialité ?', () => {
                CliniqueApp.fetchData(`${pageContext.request.contextPath}/api/specialties/${specialtyId}`, {
                    method: 'DELETE'
                })
                .then(() => {
                    CliniqueApp.showAlert('Spécialité supprimée avec succès', 'success');
                    setTimeout(() => location.reload(), 1500);
                })
                .catch(error => {
                    CliniqueApp.showAlert('Impossible de supprimer (docteurs assignés)', 'danger');
                });
            });
        }
    </script>
</body>
</html>
