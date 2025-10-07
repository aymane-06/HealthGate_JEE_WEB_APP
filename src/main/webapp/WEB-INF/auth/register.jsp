<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inscription - Clinique Digitale</title>
    
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
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .animate-fadeIn { animation: fadeIn 0.8s ease-out; }
    </style>
</head>
<body class="bg-gradient-to-br from-primary-900 via-primary-700 to-secondary-600 min-h-screen flex items-center justify-center p-4">
    
    <!-- Background Pattern -->
    <div class="absolute inset-0 opacity-10 overflow-hidden">
        <div class="absolute inset-0" style="background-image: url('data:image/svg+xml,%3Csvg width=&quot;60&quot; height=&quot;60&quot; viewBox=&quot;0 0 60 60&quot; xmlns=&quot;http://www.w3.org/2000/svg&quot;%3E%3Cg fill=&quot;none&quot; fill-rule=&quot;evenodd&quot;%3E%3Cg fill=&quot;%23ffffff&quot; fill-opacity=&quot;0.4&quot;%3E%3Cpath d=&quot;M36 34v-4h-2v4h-4v2h4v4h2v-4h4v-2h-4zm0-30V0h-2v4h-4v2h4v4h2V6h4V4h-4zM6 34v-4H4v4H0v2h4v4h2v-4h4v-2H6zM6 4V0H4v4H0v2h4v4h2V6h4V4H6z&quot;/%3E%3C/g%3E%3C/g%3E%3C/svg%3E');"></div>
    </div>
    
    <!-- Registration Container -->
    <div class="relative w-full max-w-4xl">
        <div class="bg-white rounded-3xl shadow-2xl overflow-hidden animate-fadeIn">
            
            <!-- Header -->
            <div class="bg-gradient-to-r from-primary-600 to-primary-700 text-white p-8 text-center">
                <div class="mb-4">
                    <i class="fas fa-hospital text-5xl mb-4 inline-block"></i>
                </div>
                <h1 class="text-3xl font-bold mb-2">Créer un Compte</h1>
                <p class="text-primary-100">Rejoignez la Clinique Digitale pour des soins modernes</p>
            </div>
            
            <div class="p-8 sm:p-12">
                <!-- Back Button -->
                <div class="mb-6">
                    <a href="${pageContext.request.contextPath}/" class="inline-flex items-center text-gray-600 hover:text-primary-600 transition-colors">
                        <i class="fas fa-arrow-left mr-2"></i>
                        <span>Retour à l'accueil</span>
                    </a>
                </div>
                
                <!-- Error Message -->
                <c:if test="${not empty error}">
                    <div class="mb-6 bg-red-50 border-l-4 border-red-500 p-4 rounded-lg">
                        <div class="flex items-start">
                            <i class="fas fa-exclamation-circle text-red-500 mt-0.5 mr-3"></i>
                            <div>
                                <p class="font-semibold text-red-800">Erreur d'inscription</p>
                                <p class="text-sm text-red-700">${error}</p>
                            </div>
                        </div>
                    </div>
                </c:if>
                
                <!-- Role Selection -->
                <div class="mb-8">
                    <label class="block text-sm font-bold text-gray-700 mb-4">Je m'inscris en tant que :</label>
                    <div class="grid grid-cols-2 sm:grid-cols-4 gap-4">
                        <label class="role-card cursor-pointer">
                            <input type="radio" name="role" value="PATIENT" class="hidden peer" checked>
                            <div class="border-2 border-gray-200 rounded-xl p-4 text-center transition-all peer-checked:border-primary-600 peer-checked:bg-primary-50 hover:border-primary-300">
                                <div class="bg-primary-100 w-16 h-16 rounded-full flex items-center justify-center mx-auto mb-3 peer-checked:bg-primary-200">
                                    <i class="fas fa-user text-2xl text-primary-600"></i>
                                </div>
                                <p class="font-semibold text-gray-900">Patient</p>
                                <p class="text-xs text-gray-500 mt-1">Prendre RDV</p>
                            </div>
                        </label>
                        
                        <label class="role-card cursor-pointer">
                            <input type="radio" name="role" value="DOCTOR" class="hidden peer">
                            <div class="border-2 border-gray-200 rounded-xl p-4 text-center transition-all peer-checked:border-secondary-600 peer-checked:bg-secondary-50 hover:border-secondary-300">
                                <div class="bg-secondary-100 w-16 h-16 rounded-full flex items-center justify-center mx-auto mb-3 peer-checked:bg-secondary-200">
                                    <i class="fas fa-user-md text-2xl text-secondary-600"></i>
                                </div>
                                <p class="font-semibold text-gray-900">Médecin</p>
                                <p class="text-xs text-gray-500 mt-1">Gérer consultations</p>
                            </div>
                        </label>
                        
                        <label class="role-card cursor-pointer">
                            <input type="radio" name="role" value="STAFF" class="hidden peer">
                            <div class="border-2 border-gray-200 rounded-xl p-4 text-center transition-all peer-checked:border-purple-600 peer-checked:bg-purple-50 hover:border-purple-300">
                                <div class="bg-purple-100 w-16 h-16 rounded-full flex items-center justify-center mx-auto mb-3 peer-checked:bg-purple-200">
                                    <i class="fas fa-user-nurse text-2xl text-purple-600"></i>
                                </div>
                                <p class="font-semibold text-gray-900">Personnel</p>
                                <p class="text-xs text-gray-500 mt-1">Accueil/Secrétariat</p>
                            </div>
                        </label>
                        
                        <label class="role-card cursor-pointer">
                            <input type="radio" name="role" value="ADMIN" class="hidden peer">
                            <div class="border-2 border-gray-200 rounded-xl p-4 text-center transition-all peer-checked:border-orange-600 peer-checked:bg-orange-50 hover:border-orange-300">
                                <div class="bg-orange-100 w-16 h-16 rounded-full flex items-center justify-center mx-auto mb-3 peer-checked:bg-orange-200">
                                    <i class="fas fa-user-shield text-2xl text-orange-600"></i>
                                </div>
                                <p class="font-semibold text-gray-900">Admin</p>
                                <p class="text-xs text-gray-500 mt-1">Administration</p>
                            </div>
                        </label>
                    </div>
                </div>
                
                <!-- Registration Form -->
                <form action="${pageContext.request.contextPath}/register" method="post" class="space-y-6">
                    <!-- Hidden role field (will be set by JavaScript) -->
                    <input type="hidden" name="role" id="selectedRole" value="PATIENT">
                    
                    <!-- Name Fields -->
                    <div class="grid grid-cols-1 sm:grid-cols-2 gap-6">
                        <div>
                            <label for="firstName" class="block text-sm font-semibold text-gray-700 mb-2">
                                Prénom <span class="text-red-500">*</span>
                            </label>
                            <div class="relative">
                                <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                                    <i class="fas fa-user text-gray-400"></i>
                                </div>
                                <input 
                                    type="text" 
                                    id="firstName" 
                                    name="firstName" 
                                    required 
                                    value="${param.firstName}"
                                    class="w-full pl-12 pr-4 py-3.5 border-2 border-gray-200 rounded-xl focus:border-primary-500 focus:ring-4 focus:ring-primary-100 transition-all outline-none text-gray-900"
                                    placeholder="Jean"
                                >
                            </div>
                        </div>
                        
                        <div>
                            <label for="lastName" class="block text-sm font-semibold text-gray-700 mb-2">
                                Nom <span class="text-red-500">*</span>
                            </label>
                            <div class="relative">
                                <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                                    <i class="fas fa-user text-gray-400"></i>
                                </div>
                                <input 
                                    type="text" 
                                    id="lastName" 
                                    name="lastName" 
                                    required 
                                    value="${param.lastName}"
                                    class="w-full pl-12 pr-4 py-3.5 border-2 border-gray-200 rounded-xl focus:border-primary-500 focus:ring-4 focus:ring-primary-100 transition-all outline-none text-gray-900"
                                    placeholder="Dupont"
                                >
                            </div>
                        </div>
                    </div>
                    
                    <!-- Email Field -->
                    <div>
                        <label for="email" class="block text-sm font-semibold text-gray-700 mb-2">
                            Adresse Email <span class="text-red-500">*</span>
                        </label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                                <i class="fas fa-envelope text-gray-400"></i>
                            </div>
                            <input 
                                type="email" 
                                id="email" 
                                name="email" 
                                required 
                                value="${param.email}"
                                class="w-full pl-12 pr-4 py-3.5 border-2 border-gray-200 rounded-xl focus:border-primary-500 focus:ring-4 focus:ring-primary-100 transition-all outline-none text-gray-900"
                                placeholder="jean.dupont@email.com"
                            >
                        </div>
                    </div>
                    
                    <!-- Phone Field -->
                    <div>
                        <label for="phone" class="block text-sm font-semibold text-gray-700 mb-2">
                            Téléphone <span class="text-red-500">*</span>
                        </label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                                <i class="fas fa-phone text-gray-400"></i>
                            </div>
                            <input 
                                type="tel" 
                                id="phone" 
                                name="phone" 
                                required 
                                value="${param.phone}"
                                class="w-full pl-12 pr-4 py-3.5 border-2 border-gray-200 rounded-xl focus:border-primary-500 focus:ring-4 focus:ring-primary-100 transition-all outline-none text-gray-900"
                                placeholder="+212 6XX XX XX XX"
                            >
                        </div>
                    </div>
                    
                    <!-- Password Fields -->
                    <div class="grid grid-cols-1 sm:grid-cols-2 gap-6">
                        <div>
                            <label for="password" class="block text-sm font-semibold text-gray-700 mb-2">
                                Mot de Passe <span class="text-red-500">*</span>
                            </label>
                            <div class="relative">
                                <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                                    <i class="fas fa-lock text-gray-400"></i>
                                </div>
                                <input 
                                    type="password" 
                                    id="password" 
                                    name="password" 
                                    required 
                                    minlength="6"
                                    class="w-full pl-12 pr-12 py-3.5 border-2 border-gray-200 rounded-xl focus:border-primary-500 focus:ring-4 focus:ring-primary-100 transition-all outline-none text-gray-900"
                                    placeholder="••••••••"
                                >
                                <button 
                                    type="button" 
                                    onclick="togglePassword('password')" 
                                    class="absolute inset-y-0 right-0 pr-4 flex items-center text-gray-400 hover:text-gray-600"
                                >
                                    <i id="password-eye" class="fas fa-eye"></i>
                                </button>
                            </div>
                            <p class="mt-1 text-xs text-gray-500">Minimum 6 caractères</p>
                        </div>
                        
                        <div>
                            <label for="confirmPassword" class="block text-sm font-semibold text-gray-700 mb-2">
                                Confirmer Mot de Passe <span class="text-red-500">*</span>
                            </label>
                            <div class="relative">
                                <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                                    <i class="fas fa-lock text-gray-400"></i>
                                </div>
                                <input 
                                    type="password" 
                                    id="confirmPassword" 
                                    name="confirmPassword" 
                                    required 
                                    minlength="6"
                                    class="w-full pl-12 pr-12 py-3.5 border-2 border-gray-200 rounded-xl focus:border-primary-500 focus:ring-4 focus:ring-primary-100 transition-all outline-none text-gray-900"
                                    placeholder="••••••••"
                                >
                                <button 
                                    type="button" 
                                    onclick="togglePassword('confirmPassword')" 
                                    class="absolute inset-y-0 right-0 pr-4 flex items-center text-gray-400 hover:text-gray-600"
                                >
                                    <i id="confirmPassword-eye" class="fas fa-eye"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Terms Checkbox -->
                    <div class="bg-gray-50 rounded-xl p-4">
                        <label class="flex items-start cursor-pointer group">
                            <input type="checkbox" name="terms" required class="w-5 h-5 text-primary-600 border-gray-300 rounded focus:ring-primary-500 mt-0.5 flex-shrink-0">
                            <span class="ml-3 text-sm text-gray-600 group-hover:text-gray-900">
                                J'accepte les <a href="#" class="text-primary-600 hover:text-primary-700 font-semibold">conditions d'utilisation</a> et la <a href="#" class="text-primary-600 hover:text-primary-700 font-semibold">politique de confidentialité</a>
                            </span>
                        </label>
                    </div>
                    
                    <!-- Submit Button -->
                    <button 
                        type="submit" 
                        class="w-full bg-gradient-to-r from-primary-600 to-primary-700 text-white py-4 rounded-xl font-semibold hover:from-primary-700 hover:to-primary-800 transition-all shadow-lg hover:shadow-xl transform hover:scale-[1.02] active:scale-[0.98]"
                    >
                        <i class="fas fa-user-plus mr-2"></i>
                        Créer Mon Compte
                    </button>
                </form>
                
                <!-- Sign In Link -->
                <div class="mt-8 text-center">
                    <p class="text-gray-600">
                        Vous avez déjà un compte ?
                        <a href="${pageContext.request.contextPath}/login" class="font-semibold text-primary-600 hover:text-primary-700 transition-colors ml-1">
                            Se connecter
                        </a>
                    </p>
                </div>
            </div>
        </div>
        
        <!-- Footer Note -->
        <div class="text-center mt-8">
            <p class="text-white/80 text-sm">
                <i class="fas fa-shield-alt mr-1"></i>
                Vos données sont sécurisées et confidentielles
            </p>
        </div>
    </div>
    
    <script>
        // Role selection handler
        document.querySelectorAll('input[name="role"]').forEach(radio => {
            radio.addEventListener('change', function() {
                document.getElementById('selectedRole').value = this.value;
            });
        });
        
        // Password visibility toggle
        function togglePassword(fieldId) {
            const passwordInput = document.getElementById(fieldId);
            const eyeIcon = document.getElementById(fieldId + '-eye');
            
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                eyeIcon.classList.remove('fa-eye');
                eyeIcon.classList.add('fa-eye-slash');
            } else {
                passwordInput.type = 'password';
                eyeIcon.classList.remove('fa-eye-slash');
                eyeIcon.classList.add('fa-eye');
            }
        }
        
        // Password match validation
        document.getElementById('confirmPassword').addEventListener('input', function() {
            const password = document.getElementById('password').value;
            const confirmPassword = this.value;
            
            if (confirmPassword && password !== confirmPassword) {
                this.setCustomValidity('Les mots de passe ne correspondent pas');
                this.classList.add('border-red-500');
                this.classList.remove('border-gray-200');
            } else {
                this.setCustomValidity('');
                this.classList.remove('border-red-500');
                this.classList.add('border-gray-200');
            }
        });
        
        // Auto-focus on first input
        document.addEventListener('DOMContentLoaded', function() {
            document.getElementById('firstName').focus();
        });
    </script>
</body>
</html>
