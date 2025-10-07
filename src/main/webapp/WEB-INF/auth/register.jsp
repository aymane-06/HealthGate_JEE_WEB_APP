<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inscription - Clinique Digitale</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 2rem 0;
        }
        .register-container {
            background: white;
            border-radius: 16px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            max-width: 800px;
            margin: 0 auto;
            padding: 3rem;
        }
        .register-header {
            text-align: center;
            margin-bottom: 2rem;
        }
        .register-logo {
            font-size: 2rem;
            font-weight: 700;
            color: var(--primary-color);
            margin-bottom: 0.5rem;
        }
        .role-selector {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 1rem;
            margin-bottom: 2rem;
        }
        .role-card {
            border: 2px solid var(--gray-300);
            border-radius: var(--border-radius);
            padding: 1.5rem;
            text-align: center;
            cursor: pointer;
            transition: var(--transition);
        }
        .role-card:hover {
            border-color: var(--primary-color);
            transform: translateY(-2px);
        }
        .role-card.selected {
            border-color: var(--primary-color);
            background-color: rgba(37, 99, 235, 0.1);
        }
        .role-card input[type="radio"] {
            display: none;
        }
        .role-icon {
            font-size: 2rem;
            margin-bottom: 0.5rem;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="register-container">
            <div class="register-header">
                <div class="register-logo">Clinique Digitale</div>
                <p>Créez votre compte</p>
            </div>
            
            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>
            
            <form action="${pageContext.request.contextPath}/register" method="post" id="registerForm" data-validate>
                <!-- Role Selection -->
                <div class="form-group">
                    <label class="form-label required">Type de compte</label>
                    <div class="role-selector">
                        <label class="role-card" onclick="selectRole(this)">
                            <input type="radio" name="role" value="PATIENT" required>
                            <div class="role-icon">👤</div>
                            <div>Patient</div>
                        </label>
                        <label class="role-card" onclick="selectRole(this)">
                            <input type="radio" name="role" value="DOCTOR" required>
                            <div class="role-icon">👨‍⚕️</div>
                            <div>Docteur</div>
                        </label>
                        <label class="role-card" onclick="selectRole(this)">
                            <input type="radio" name="role" value="STAFF" required>
                            <div class="role-icon">👔</div>
                            <div>Personnel</div>
                        </label>
                    </div>
                </div>
                
                <!-- Basic Information -->
                <div class="row">
                    <div class="col-6">
                        <div class="form-group">
                            <label for="firstName" class="form-label required">Prénom</label>
                            <input type="text" class="form-control" id="firstName" name="firstName" required>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="form-group">
                            <label for="lastName" class="form-label required">Nom</label>
                            <input type="text" class="form-control" id="lastName" name="lastName" required>
                        </div>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="email" class="form-label required">Email</label>
                    <input type="email" class="form-control" id="email" name="email" required>
                    <small class="form-text">Utilisé pour la connexion</small>
                </div>
                
                <div class="row">
                    <div class="col-6">
                        <div class="form-group">
                            <label for="password" class="form-label required">Mot de passe</label>
                            <input type="password" class="form-control" id="password" name="password" 
                                   minlength="8" required>
                            <small class="form-text">Minimum 8 caractères</small>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="form-group">
                            <label for="confirmPassword" class="form-label required">Confirmer mot de passe</label>
                            <input type="password" class="form-control" id="confirmPassword" 
                                   name="confirmPassword" required>
                        </div>
                    </div>
                </div>
                
                <!-- Patient-specific fields -->
                <div id="patientFields" style="display: none;">
                    <h5 class="mt-4 mb-3">Informations patient</h5>
                    
                    <div class="row">
                        <div class="col-6">
                            <div class="form-group">
                                <label for="cin" class="form-label required">CIN</label>
                                <input type="text" class="form-control" id="cin" name="cin">
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="form-group">
                                <label for="dateOfBirth" class="form-label required">Date de naissance</label>
                                <input type="date" class="form-control" id="dateOfBirth" name="dateOfBirth">
                            </div>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-4">
                            <div class="form-group">
                                <label for="gender" class="form-label required">Sexe</label>
                                <select class="form-control form-select" id="gender" name="gender">
                                    <option value="">Sélectionner</option>
                                    <option value="M">Homme</option>
                                    <option value="F">Femme</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-4">
                            <div class="form-group">
                                <label for="bloodType" class="form-label">Groupe sanguin</label>
                                <select class="form-control form-select" id="bloodType" name="bloodType">
                                    <option value="">Sélectionner</option>
                                    <option value="A+">A+</option>
                                    <option value="A-">A-</option>
                                    <option value="B+">B+</option>
                                    <option value="B-">B-</option>
                                    <option value="AB+">AB+</option>
                                    <option value="AB-">AB-</option>
                                    <option value="O+">O+</option>
                                    <option value="O-">O-</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-4">
                            <div class="form-group">
                                <label for="phone" class="form-label required">Téléphone</label>
                                <input type="tel" class="form-control" id="phone" name="phone">
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="address" class="form-label">Adresse</label>
                        <textarea class="form-control" id="address" name="address" rows="2"></textarea>
                    </div>
                </div>
                
                <!-- Doctor-specific fields -->
                <div id="doctorFields" style="display: none;">
                    <h5 class="mt-4 mb-3">Informations docteur</h5>
                    
                    <div class="row">
                        <div class="col-4">
                            <div class="form-group">
                                <label for="matricule" class="form-label required">Matricule</label>
                                <input type="text" class="form-control" id="matricule" name="matricule">
                            </div>
                        </div>
                        <div class="col-4">
                            <div class="form-group">
                                <label for="title" class="form-label required">Titre</label>
                                <select class="form-control form-select" id="title" name="title">
                                    <option value="">Sélectionner</option>
                                    <option value="Dr">Dr</option>
                                    <option value="Pr">Pr</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-4">
                            <div class="form-group">
                                <label for="specialty" class="form-label required">Spécialité</label>
                                <select class="form-control form-select" id="specialty" name="specialtyId">
                                    <option value="">Sélectionner</option>
                                    <!-- Populated from backend -->
                                    <c:forEach items="${specialties}" var="specialty">
                                        <option value="${specialty.id}">${specialty.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="form-check mt-3">
                    <input type="checkbox" class="form-check-input" id="terms" name="terms" required>
                    <label class="form-check-label" for="terms">
                        J'accepte les <a href="#" target="_blank">termes et conditions</a>
                    </label>
                </div>
                
                <button type="submit" class="btn btn-primary btn-block btn-lg mt-4">S'inscrire</button>
            </form>
            
            <div class="text-center mt-3">
                <p>Vous avez déjà un compte ? 
                    <a href="${pageContext.request.contextPath}/auth/login.jsp">Se connecter</a>
                </p>
            </div>
        </div>
    </div>
    
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
    <script>
        function selectRole(element) {
            // Remove selected class from all role cards
            document.querySelectorAll('.role-card').forEach(card => {
                card.classList.remove('selected');
            });
            
            // Add selected class to clicked card
            element.classList.add('selected');
            
            // Check the radio button
            const radio = element.querySelector('input[type="radio"]');
            radio.checked = true;
            
            // Show/hide role-specific fields
            const role = radio.value;
            document.getElementById('patientFields').style.display = role === 'PATIENT' ? 'block' : 'none';
            document.getElementById('doctorFields').style.display = role === 'DOCTOR' ? 'block' : 'none';
            
            // Update required fields
            if (role === 'PATIENT') {
                ['cin', 'dateOfBirth', 'gender', 'phone'].forEach(id => {
                    document.getElementById(id).required = true;
                });
                ['matricule', 'title', 'specialty'].forEach(id => {
                    document.getElementById(id).required = false;
                });
            } else if (role === 'DOCTOR') {
                ['matricule', 'title', 'specialty'].forEach(id => {
                    document.getElementById(id).required = true;
                });
                ['cin', 'dateOfBirth', 'gender', 'phone'].forEach(id => {
                    document.getElementById(id).required = false;
                });
            } else {
                ['cin', 'dateOfBirth', 'gender', 'phone', 'matricule', 'title', 'specialty'].forEach(id => {
                    document.getElementById(id).required = false;
                });
            }
        }
        
        // Password confirmation validation
        document.getElementById('registerForm').addEventListener('submit', function(e) {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            if (password !== confirmPassword) {
                e.preventDefault();
                CliniqueApp.showAlert('Les mots de passe ne correspondent pas', 'danger');
            }
        });
    </script>
</body>
</html>
