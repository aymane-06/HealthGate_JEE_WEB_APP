<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mon Profil - Clinique Digitale</title>
    
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: {
                            50: '#e6f2ff', 100: '#b3d9ff', 200: '#80bfff',
                            300: '#4da6ff', 400: '#1a8cff', 500: '#0073e6',
                            600: '#0066CC', 700: '#0052a3', 800: '#003d7a',
                            900: '#002952',
                        },
                        secondary: {
                            50: '#e6fff9', 100: '#b3ffe9', 200: '#80ffd9',
                            300: '#4dffc9', 400: '#1affb9', 500: '#00e6a0',
                            600: '#00D9A5', 700: '#00a67a', 800: '#007352',
                            900: '#004029',
                        }
                    }
                }
            }
        }
    </script>
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
    
    <style>
        * { font-family: 'Inter', sans-serif; }
    </style>
</head>
<body class="bg-gray-50">
    <jsp:include page="components/sidebar.jsp" />
    
    <div class="flex h-screen overflow-hidden">
        <div class="flex-1 flex flex-col overflow-hidden">
            
            <!-- Top Bar -->
            <header class="bg-white shadow-sm border-b border-gray-200">
                <div class="flex items-center justify-between p-4">
                    <div>
                        <h2 class="text-2xl font-bold text-gray-900">Mon Profil</h2>
                        <p class="text-sm text-gray-500">Gérez vos informations personnelles et préférences</p>
                    </div>
                    <a href="${pageContext.request.contextPath}/${user.role.toLowerCase()}/dashboard" class="flex items-center space-x-2 text-primary-600 hover:text-primary-700 font-semibold">
                        <i class="fas fa-arrow-left"></i>
                        <span>Retour au tableau de bord</span>
                    </a>
                </div>
            </header>
            
            <!-- Main Content -->
            <main class="flex-1 overflow-x-hidden overflow-y-auto bg-gray-50 p-6">
                
                <!-- Alert Container -->
                <div id="alert-container" class="mb-6"></div>
                
                <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
                    
                    <!-- Left Column - Profile & Settings -->
                    <div class="lg:col-span-2 space-y-6">
                        
                        <!-- Personal Information Card -->
                        <div class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
                            <div class="bg-gradient-to-r from-primary-600 to-primary-700 p-6 text-white">
                                <div class="flex items-center space-x-4">
                                    <div class="w-20 h-20 bg-white/20 backdrop-blur-sm rounded-2xl flex items-center justify-center text-white font-bold text-3xl shadow-lg">
                                        ${sessionScope.user.firstName.substring(0,1)}${sessionScope.user.lastName.substring(0,1)}
                                    </div>
                                    <div>
                                        <h3 class="text-2xl font-bold">${sessionScope.user.firstName} ${sessionScope.user.lastName}</h3>
                                        <p class="text-primary-100 flex items-center space-x-2">
                                            <span class="px-3 py-1 bg-white/20 rounded-full text-sm font-semibold">${sessionScope.user.role}</span>
                                        </p>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="p-6">
                                <form id="profileForm" action="${pageContext.request.contextPath}/profile/update" method="post">
                                    <div class="space-y-4">
                                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                            <div>
                                                <label class="block text-sm font-semibold text-gray-700 mb-2">
                                                    <i class="fas fa-user text-primary-600 mr-2"></i>Prénom <span class="text-red-500">*</span>
                                                </label>
                                                <input type="text" name="firstName" value="${user.firstName}" required
                                                       class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent transition-all">
                                            </div>
                                            <div>
                                                <label class="block text-sm font-semibold text-gray-700 mb-2">
                                                    <i class="fas fa-user text-primary-600 mr-2"></i>Nom <span class="text-red-500">*</span>
                                                </label>
                                                <input type="text" name="lastName" value="${user.lastName}" required
                                                       class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent transition-all">
                                            </div>
                                        </div>
                                        
                                        <div>
                                            <label class="block text-sm font-semibold text-gray-700 mb-2">
                                                <i class="fas fa-envelope text-primary-600 mr-2"></i>Email <span class="text-red-500">*</span>
                                            </label>
                                            <input type="email" name="email" value="${user.email}" required
                                                   class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent transition-all">
                                        </div>
                                        
                                        <c:if test="${user.role == 'PATIENT'}">
                                            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                                <div>
                                                    <label class="block text-sm font-semibold text-gray-700 mb-2">
                                                        <i class="fas fa-id-card text-primary-600 mr-2"></i>CIN
                                                    </label>
                                                    <input type="text" name="cin" value="${patient.cin}" readonly
                                                           class="w-full px-4 py-3 bg-gray-100 border border-gray-300 rounded-lg cursor-not-allowed">
                                                </div>
                                                <div>
                                                    <label class="block text-sm font-semibold text-gray-700 mb-2">
                                                        <i class="fas fa-calendar text-primary-600 mr-2"></i>Date de naissance
                                                    </label>
                                                    <input type="date" name="dateOfBirth" value="${patient.dateOfBirth}"
                                                           class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent transition-all">
                                                </div>
                                            </div>
                                            
                                            <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                                                <div>
                                                    <label class="block text-sm font-semibold text-gray-700 mb-2">
                                                        <i class="fas fa-venus-mars text-primary-600 mr-2"></i>Sexe
                                                    </label>
                                                    <select name="gender" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent transition-all">
                                                        <option value="M" ${patient.gender == 'M' ? 'selected' : ''}>Homme</option>
                                                        <option value="F" ${patient.gender == 'F' ? 'selected' : ''}>Femme</option>
                                                    </select>
                                                </div>
                                                <div>
                                                    <label class="block text-sm font-semibold text-gray-700 mb-2">
                                                        <i class="fas fa-tint text-primary-600 mr-2"></i>Groupe sanguin
                                                    </label>
                                                    <select name="bloodType" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent transition-all">
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
                                                <div>
                                                    <label class="block text-sm font-semibold text-gray-700 mb-2">
                                                        <i class="fas fa-phone text-primary-600 mr-2"></i>Téléphone
                                                    </label>
                                                    <input type="tel" name="phone" value="${patient.phone}"
                                                           class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent transition-all">
                                                </div>
                                            </div>
                                            
                                            <div>
                                                <label class="block text-sm font-semibold text-gray-700 mb-2">
                                                    <i class="fas fa-map-marker-alt text-primary-600 mr-2"></i>Adresse
                                                </label>
                                                <textarea name="address" rows="3" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent transition-all">${patient.address}</textarea>
                                            </div>
                                        </c:if>
                                        
                                        <c:if test="${user.role == 'DOCTOR'}">
                                            <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                                                <div>
                                                    <label class="block text-sm font-semibold text-gray-700 mb-2">
                                                        <i class="fas fa-id-badge text-primary-600 mr-2"></i>Matricule
                                                    </label>
                                                    <input type="text" value="${doctor.matricule}" readonly
                                                           class="w-full px-4 py-3 bg-gray-100 border border-gray-300 rounded-lg cursor-not-allowed">
                                                </div>
                                                <div>
                                                    <label class="block text-sm font-semibold text-gray-700 mb-2">
                                                        <i class="fas fa-award text-primary-600 mr-2"></i>Titre
                                                    </label>
                                                    <input type="text" value="${doctor.title}" readonly
                                                           class="w-full px-4 py-3 bg-gray-100 border border-gray-300 rounded-lg cursor-not-allowed">
                                                </div>
                                                <div>
                                                    <label class="block text-sm font-semibold text-gray-700 mb-2">
                                                        <i class="fas fa-stethoscope text-primary-600 mr-2"></i>Spécialité
                                                    </label>
                                                    <input type="text" value="${doctor.specialtyName}" readonly
                                                           class="w-full px-4 py-3 bg-gray-100 border border-gray-300 rounded-lg cursor-not-allowed">
                                                </div>
                                            </div>
                                        </c:if>
                                    </div>
                                    
                                    <div class="mt-6 pt-6 border-t border-gray-200">
                                        <button type="submit" class="w-full md:w-auto px-8 py-3 bg-primary-600 hover:bg-primary-700 text-white rounded-lg font-semibold transition-colors shadow-lg shadow-primary-600/30">
                                            <i class="fas fa-save mr-2"></i>Enregistrer les modifications
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                        
                        <!-- Change Password Card -->
                        <div class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
                            <div class="p-6 border-b border-gray-100">
                                <h3 class="text-lg font-bold text-gray-900 flex items-center">
                                    <i class="fas fa-lock text-orange-600 mr-3"></i>
                                    Changer le mot de passe
                                </h3>
                            </div>
                            <div class="p-6">
                                <form id="passwordForm" action="${pageContext.request.contextPath}/profile/change-password" method="post">
                                    <div class="space-y-4">
                                        <div>
                                            <label class="block text-sm font-semibold text-gray-700 mb-2">
                                                <i class="fas fa-key text-orange-600 mr-2"></i>Mot de passe actuel <span class="text-red-500">*</span>
                                            </label>
                                            <div class="relative">
                                                <input type="password" name="currentPassword" id="currentPassword" required
                                                       class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-orange-500 focus:border-transparent transition-all pr-12">
                                                <button type="button" onclick="togglePassword('currentPassword')" class="absolute right-3 top-1/2 -translate-y-1/2 text-gray-500 hover:text-gray-700">
                                                    <i class="fas fa-eye"></i>
                                                </button>
                                            </div>
                                        </div>
                                        
                                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                            <div>
                                                <label class="block text-sm font-semibold text-gray-700 mb-2">
                                                    <i class="fas fa-key text-orange-600 mr-2"></i>Nouveau mot de passe <span class="text-red-500">*</span>
                                                </label>
                                                <div class="relative">
                                                    <input type="password" name="newPassword" id="newPassword" minlength="8" required
                                                           class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-orange-500 focus:border-transparent transition-all pr-12">
                                                    <button type="button" onclick="togglePassword('newPassword')" class="absolute right-3 top-1/2 -translate-y-1/2 text-gray-500 hover:text-gray-700">
                                                        <i class="fas fa-eye"></i>
                                                    </button>
                                                </div>
                                                <p class="text-xs text-gray-500 mt-1">Minimum 8 caractères</p>
                                            </div>
                                            <div>
                                                <label class="block text-sm font-semibold text-gray-700 mb-2">
                                                    <i class="fas fa-check-circle text-orange-600 mr-2"></i>Confirmer le mot de passe <span class="text-red-500">*</span>
                                                </label>
                                                <div class="relative">
                                                    <input type="password" name="confirmPassword" id="confirmPassword" required
                                                           class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-orange-500 focus:border-transparent transition-all pr-12">
                                                    <button type="button" onclick="togglePassword('confirmPassword')" class="absolute right-3 top-1/2 -translate-y-1/2 text-gray-500 hover:text-gray-700">
                                                        <i class="fas fa-eye"></i>
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="mt-6 pt-6 border-t border-gray-200">
                                        <button type="submit" class="w-full md:w-auto px-8 py-3 bg-orange-600 hover:bg-orange-700 text-white rounded-lg font-semibold transition-colors shadow-lg shadow-orange-600/30">
                                            <i class="fas fa-shield-alt mr-2"></i>Changer le mot de passe
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                        
                    </div>
                    
                    <!-- Right Column - Account Info & Preferences -->
                    <div class="space-y-6">
                        
                        <!-- Account Information Card -->
                        <div class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
                            <div class="p-6 border-b border-gray-100">
                                <h3 class="text-lg font-bold text-gray-900 flex items-center">
                                    <i class="fas fa-info-circle text-blue-600 mr-3"></i>
                                    Informations du compte
                                </h3>
                            </div>
                            <div class="p-6 space-y-4">
                                <div class="flex items-center justify-between p-3 bg-blue-50 rounded-lg">
                                    <span class="text-sm font-semibold text-gray-700">Rôle</span>
                                    <span class="px-3 py-1 text-xs font-bold rounded-full bg-blue-600 text-white">${user.role}</span>
                                </div>
                                <div class="flex items-center justify-between p-3 bg-green-50 rounded-lg">
                                    <span class="text-sm font-semibold text-gray-700">Statut</span>
                                    <span class="px-3 py-1 text-xs font-bold rounded-full ${user.active ? 'bg-green-600 text-white' : 'bg-red-600 text-white'}">
                                        ${user.active ? 'Actif' : 'Inactif'}
                                    </span>
                                </div>
                                <div class="flex items-center justify-between p-3 bg-purple-50 rounded-lg">
                                    <span class="text-sm font-semibold text-gray-700">Membre depuis</span>
                                    <span class="text-sm font-medium text-gray-900">${user.createdAt}</span>
                                </div>
                                <div class="flex items-center justify-between p-3 bg-orange-50 rounded-lg">
                                    <span class="text-sm font-semibold text-gray-700">Dernière connexion</span>
                                    <span class="text-sm font-medium text-gray-900">${user.lastLogin}</span>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Preferences Card -->
                        <div class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
                            <div class="p-6 border-b border-gray-100">
                                <h3 class="text-lg font-bold text-gray-900 flex items-center">
                                    <i class="fas fa-cog text-purple-600 mr-3"></i>
                                    Préférences
                                </h3>
                            </div>
                            <div class="p-6 space-y-3">
                                <label class="flex items-center p-3 bg-gray-50 rounded-lg cursor-pointer hover:bg-gray-100 transition-colors">
                                    <input type="checkbox" id="emailNotifications" checked class="w-5 h-5 text-primary-600 rounded focus:ring-2 focus:ring-primary-500">
                                    <span class="ml-3 text-sm font-medium text-gray-900 flex items-center">
                                        <i class="fas fa-envelope text-primary-600 mr-2"></i>
                                        Notifications email
                                    </span>
                                </label>
                                <label class="flex items-center p-3 bg-gray-50 rounded-lg cursor-pointer hover:bg-gray-100 transition-colors">
                                    <input type="checkbox" id="smsNotifications" class="w-5 h-5 text-primary-600 rounded focus:ring-2 focus:ring-primary-500">
                                    <span class="ml-3 text-sm font-medium text-gray-900 flex items-center">
                                        <i class="fas fa-sms text-secondary-600 mr-2"></i>
                                        Notifications SMS
                                    </span>
                                </label>
                                <label class="flex items-center p-3 bg-gray-50 rounded-lg cursor-pointer hover:bg-gray-100 transition-colors">
                                    <input type="checkbox" id="reminders" checked class="w-5 h-5 text-primary-600 rounded focus:ring-2 focus:ring-primary-500">
                                    <span class="ml-3 text-sm font-medium text-gray-900 flex items-center">
                                        <i class="fas fa-bell text-orange-600 mr-2"></i>
                                        Rappels de RDV
                                    </span>
                                </label>
                                
                                <button onclick="savePreferences()" class="w-full mt-4 px-6 py-3 bg-purple-600 hover:bg-purple-700 text-white rounded-lg font-semibold transition-colors shadow-lg shadow-purple-600/30">
                                    <i class="fas fa-save mr-2"></i>Enregistrer les préférences
                                </button>
                            </div>
                        </div>
                        
                        <!-- Security Tips -->
                        <div class="bg-gradient-to-br from-yellow-50 to-orange-50 rounded-2xl shadow-sm border border-yellow-200 p-6">
                            <div class="flex items-start space-x-3">
                                <i class="fas fa-shield-alt text-yellow-600 text-2xl mt-1"></i>
                                <div>
                                    <h4 class="font-bold text-gray-900 mb-2">Conseil de sécurité</h4>
                                    <p class="text-sm text-gray-700 mb-3">
                                        Changez régulièrement votre mot de passe et utilisez un mot de passe unique pour ce compte.
                                    </p>
                                    <ul class="text-xs text-gray-600 space-y-1">
                                        <li class="flex items-center"><i class="fas fa-check text-green-600 mr-2"></i>Au moins 8 caractères</li>
                                        <li class="flex items-center"><i class="fas fa-check text-green-600 mr-2"></i>Majuscules et minuscules</li>
                                        <li class="flex items-center"><i class="fas fa-check text-green-600 mr-2"></i>Chiffres et symboles</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        
                    </div>
                    
                </div>
                
            </main>
        </div>
    </div>
    
    <script>
        // Toggle password visibility
        function togglePassword(inputId) {
            const input = document.getElementById(inputId);
            const icon = event.currentTarget.querySelector('i');
            
            if (input.type === 'password') {
                input.type = 'text';
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            } else {
                input.type = 'password';
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            }
        }
        
        // Password confirmation validation
        document.getElementById('passwordForm').addEventListener('submit', function(e) {
            const newPassword = document.getElementById('newPassword').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            if (newPassword !== confirmPassword) {
                e.preventDefault();
                showAlert('Les mots de passe ne correspondent pas', 'danger');
            }
        });
        
        // Save preferences
        function savePreferences() {
            const preferences = {
                emailNotifications: document.getElementById('emailNotifications').checked,
                smsNotifications: document.getElementById('smsNotifications').checked,
                reminders: document.getElementById('reminders').checked
            };
            
            fetch('${pageContext.request.contextPath}/api/profile/preferences', {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(preferences)
            })
            .then(response => response.json())
            .then(() => {
                showAlert('Préférences enregistrées avec succès', 'success');
            })
            .catch(() => {
                showAlert('Erreur lors de l\'enregistrement des préférences', 'danger');
            });
        }
        
        // Show alert
        function showAlert(message, type) {
            const alertContainer = document.getElementById('alert-container');
            const colors = {
                success: 'bg-green-100 border-green-500 text-green-700',
                danger: 'bg-red-100 border-red-500 text-red-700',
                info: 'bg-blue-100 border-blue-500 text-blue-700'
            };
            
            alertContainer.innerHTML = `
                <div class="${colors[type]} border-l-4 p-4 rounded-lg shadow-sm">
                    <div class="flex items-center">
                        <i class="fas fa-${type === 'success' ? 'check-circle' : type === 'danger' ? 'exclamation-circle' : 'info-circle'} mr-3"></i>
                        <span class="font-semibold">${message}</span>
                    </div>
                </div>
            `;
            
            setTimeout(() => {
                alertContainer.innerHTML = '';
            }, 5000);
        }
    </script>
</body>
</html>
