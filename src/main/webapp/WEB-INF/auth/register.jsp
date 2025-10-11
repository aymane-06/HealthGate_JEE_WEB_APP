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

        .section-divider {
            position: relative;
            text-align: center;
            margin: 2rem 0;
        }
        .section-divider::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 0;
            width: 100%;
            height: 2px;
            background: linear-gradient(to right, transparent, #e5e7eb, transparent);
        }
        .section-divider span {
            position: relative;
            background: white;
            padding: 0 1rem;
            color: #6b7280;
            font-weight: 600;
            font-size: 0.875rem;
            letter-spacing: 0.05em;
        }
    </style>
</head>
<body class="bg-gradient-to-br from-primary-900 via-primary-700 to-secondary-600 min-h-screen flex items-center justify-center p-4">

    <!-- Background Pattern -->
    <div class="absolute inset-0 opacity-10 overflow-hidden">
        <div class="absolute inset-0" style="background-image: url('data:image/svg+xml,%3Csvg width=&quot;60&quot; height=&quot;60&quot; viewBox=&quot;0 0 60 60&quot; xmlns=&quot;http://www.w3.org/2000/svg&quot;%3E%3Cg fill=&quot;none&quot; fill-rule=&quot;evenodd&quot;%3E%3Cg fill=&quot;%23ffffff&quot; fill-opacity=&quot;0.4&quot;%3E%3Cpath d=&quot;M36 34v-4h-2v4h-4v2h4v4h2v-4h4v-2h-4zm0-30V0h-2v4h-4v2h4v4h2V6h4V4h-4zM6 34v-4H4v4H0v2h4v4h2v-4h4v-2H6zM6 4V0H4v4H0v2h4v4h2V6h4V4H6z&quot;/%3E%3C/g%3E%3C/g%3E%3C/svg%3E');"></div>
    </div>
    
    <!-- Registration Container -->
    <div class="relative w-full max-w-5xl my-8">
        <div class="bg-white rounded-3xl shadow-2xl overflow-hidden animate-fadeIn">
            
            <!-- Header -->
            <div class="bg-gradient-to-r from-primary-600 to-secondary-600 text-white p-8 text-center relative overflow-hidden">
                <div class="absolute inset-0 opacity-10">
                    <div class="absolute inset-0" style="background: radial-gradient(circle at 20% 50%, white 1px, transparent 1px), radial-gradient(circle at 80% 50%, white 1px, transparent 1px); background-size: 50px 50px;"></div>
                </div>
                <div class="relative z-10">
                    <div class="inline-flex items-center justify-center w-20 h-20 bg-white/20 backdrop-blur-sm rounded-full mb-4">
                        <i class="fas fa-user-plus text-4xl"></i>
                    </div>
                    <h1 class="text-4xl font-bold mb-2">Créer un Compte Patient</h1>
                    <p class="text-white/90 text-lg">Rejoignez la Clinique Digitale pour des soins de qualité</p>
                </div>
            </div>
            
            <div class="p-8 sm:p-12">
                <!-- Back Button -->
                <div class="mb-6">
                    <a href="${pageContext.request.contextPath}/" class="inline-flex items-center text-gray-600 hover:text-primary-600 transition-colors font-medium group">
                        <i class="fas fa-arrow-left mr-2 group-hover:-translate-x-1 transition-transform"></i>
                        <span>Retour à l'accueil</span>
                    </a>
                </div>
                
                <!-- Error Message -->
                <c:if test="${not empty error}">
                    <div class="mb-6 bg-red-50 border-l-4 border-red-500 p-4 rounded-lg animate-fadeIn">
                        <div class="flex items-start">
                            <i class="fas fa-exclamation-circle text-red-500 mt-0.5 mr-3 text-xl"></i>
                            <div>
                                <p class="font-semibold text-red-800">Erreur d'inscription</p>
                                <p class="text-sm text-red-700 mt-1">${error}</p>
                            </div>
                        </div>
                    </div>
                </c:if>
                
                <!-- Registration Form -->
                <form action="${pageContext.request.contextPath}/register" method="post" class="space-y-8">
                    <!-- Hidden role field -->
                    <input type="hidden" name="role" value="PATIENT">

                    <!-- SECTION 1: Personal Information -->
                    <div>
                        <div class="flex items-center mb-6">
                            <div class="flex items-center justify-center w-10 h-10 bg-primary-100 rounded-lg mr-3">
                                <i class="fas fa-user text-primary-600"></i>
                            </div>
                            <h2 class="text-xl font-bold text-gray-800">Informations Personnelles</h2>
                        </div>

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <!-- First Name -->
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

                            <!-- Last Name -->
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

                            <!-- CIN -->
                            <div>
                                <label for="cin" class="block text-sm font-semibold text-gray-700 mb-2">
                                    CIN <span class="text-red-500">*</span>
                                </label>
                                <div class="relative">
                                    <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                                        <i class="fas fa-id-card text-gray-400"></i>
                                    </div>
                                    <input
                                        type="text"
                                        id="cin"
                                        name="cin"
                                        required
                                        value="${param.cin}"
                                        class="w-full pl-12 pr-4 py-3.5 border-2 border-gray-200 rounded-xl focus:border-primary-500 focus:ring-4 focus:ring-primary-100 transition-all outline-none text-gray-900"
                                        placeholder="AA123456"
                                    >
                                </div>
                            </div>

                            <!-- Birth Date -->
                            <div>
                                <label for="birthDate" class="block text-sm font-semibold text-gray-700 mb-2">
                                    Date de Naissance
                                </label>
                                <div class="relative">
                                    <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                                        <i class="fas fa-calendar text-gray-400"></i>
                                    </div>
                                    <input
                                        type="date"
                                        id="birthDate"
                                        name="birthDate"
                                        value="${param.birthDate}"
                                        class="w-full pl-12 pr-4 py-3.5 border-2 border-gray-200 rounded-xl focus:border-primary-500 focus:ring-4 focus:ring-primary-100 transition-all outline-none text-gray-900"
                                    >
                                </div>
                            </div>

                            <!-- Gender -->
                            <div>
                                <label for="gender" class="block text-sm font-semibold text-gray-700 mb-2">
                                    Sexe
                                </label>
                                <div class="relative">
                                    <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                                        <i class="fas fa-venus-mars text-gray-400"></i>
                                    </div>
                                    <select
                                        id="gender"
                                        name="gender"
                                        class="w-full pl-12 pr-4 py-3.5 border-2 border-gray-200 rounded-xl focus:border-primary-500 focus:ring-4 focus:ring-primary-100 transition-all outline-none text-gray-900 appearance-none bg-white"
                                    >
                                        <option value="">Sélectionner</option>
                                        <option value="MALE" ${param.gender == 'MALE' ? 'selected' : ''}>Homme</option>
                                        <option value="FEMALE" ${param.gender == 'FEMALE' ? 'selected' : ''}>Femme</option>
                                    </select>
                                    <div class="absolute inset-y-0 right-0 pr-4 flex items-center pointer-events-none">
                                        <i class="fas fa-chevron-down text-gray-400"></i>
                                    </div>
                                </div>
                            </div>

                            <!-- Blood Type -->
                            <div>
                                <label for="bloodType" class="block text-sm font-semibold text-gray-700 mb-2">
                                    Groupe Sanguin
                                </label>
                                <div class="relative">
                                    <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                                        <i class="fas fa-tint text-gray-400"></i>
                                    </div>
                                    <select
                                        id="bloodType"
                                        name="bloodType"
                                        class="w-full pl-12 pr-4 py-3.5 border-2 border-gray-200 rounded-xl focus:border-primary-500 focus:ring-4 focus:ring-primary-100 transition-all outline-none text-gray-900 appearance-none bg-white"
                                    >
                                        <option value="">Sélectionner</option>
                                        <option value="A+" ${param.bloodType == 'A+' ? 'selected' : ''}>A+</option>
                                        <option value="A-" ${param.bloodType == 'A-' ? 'selected' : ''}>A-</option>
                                        <option value="B+" ${param.bloodType == 'B+' ? 'selected' : ''}>B+</option>
                                        <option value="B-" ${param.bloodType == 'B-' ? 'selected' : ''}>B-</option>
                                        <option value="AB+" ${param.bloodType == 'AB+' ? 'selected' : ''}>AB+</option>
                                        <option value="AB-" ${param.bloodType == 'AB-' ? 'selected' : ''}>AB-</option>
                                        <option value="O+" ${param.bloodType == 'O+' ? 'selected' : ''}>O+</option>
                                        <option value="O-" ${param.bloodType == 'O-' ? 'selected' : ''}>O-</option>
                                    </select>
                                    <div class="absolute inset-y-0 right-0 pr-4 flex items-center pointer-events-none">
                                        <i class="fas fa-chevron-down text-gray-400"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Section Divider -->
                    <div class="section-divider">
                        <span>COORDONNÉES</span>
                    </div>

                    <!-- SECTION 2: Contact Information -->
                    <div>
                        <div class="flex items-center mb-6">
                            <div class="flex items-center justify-center w-10 h-10 bg-secondary-100 rounded-lg mr-3">
                                <i class="fas fa-address-book text-secondary-700"></i>
                            </div>
                            <h2 class="text-xl font-bold text-gray-800">Coordonnées</h2>
                        </div>

                        <div class="space-y-6">
                            <!-- Email -->
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
                                <p class="mt-1 text-xs text-gray-500">
                                    <i class="fas fa-info-circle mr-1"></i>
                                    Utilisé pour la connexion et les notifications
                                </p>
                            </div>

                            <!-- Phone -->
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

                            <!-- Address -->
                            <div>
                                <label for="address" class="block text-sm font-semibold text-gray-700 mb-2">
                                    Adresse
                                </label>
                                <div class="relative">
                                    <div class="absolute top-4 left-0 pl-4 flex items-center pointer-events-none">
                                        <i class="fas fa-map-marker-alt text-gray-400"></i>
                                    </div>
                                    <textarea
                                        id="address"
                                        name="address"
                                        rows="3"
                                        value="${param.address}"
                                        class="w-full pl-12 pr-4 py-3.5 border-2 border-gray-200 rounded-xl focus:border-primary-500 focus:ring-4 focus:ring-primary-100 transition-all outline-none text-gray-900 resize-none"
                                        placeholder="123 Rue Example, Ville, Code Postal"
                                    >${param.address}</textarea>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Section Divider -->
                    <div class="section-divider">
                        <span>SÉCURITÉ</span>
                    </div>

                    <!-- SECTION 3: Security -->
                    <div>
                        <div class="flex items-center mb-6">
                            <div class="flex items-center justify-center w-10 h-10 bg-red-100 rounded-lg mr-3">
                                <i class="fas fa-shield-alt text-red-600"></i>
                            </div>
                            <h2 class="text-xl font-bold text-gray-800">Sécurité du Compte</h2>
                        </div>

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <!-- Password -->
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
                                        class="absolute inset-y-0 right-0 pr-4 flex items-center text-gray-400 hover:text-gray-600 transition-colors"
                                    >
                                        <i id="password-eye" class="fas fa-eye"></i>
                                    </button>
                                </div>
                                <p class="mt-1 text-xs text-gray-500">
                                    <i class="fas fa-check-circle text-green-500 mr-1"></i>
                                    Minimum 6 caractères
                                </p>
                            </div>

                            <!-- Confirm Password -->
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
                                        class="absolute inset-y-0 right-0 pr-4 flex items-center text-gray-400 hover:text-gray-600 transition-colors"
                                    >
                                        <i id="confirmPassword-eye" class="fas fa-eye"></i>
                                    </button>
                                </div>
                                <p id="password-match-message" class="mt-1 text-xs hidden">
                                    <!-- Dynamic message will appear here -->
                                </p>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Terms Checkbox -->
                    <div class="bg-gradient-to-r from-primary-50 to-secondary-50 rounded-xl p-6 border-2 border-primary-100">
                        <label class="flex items-start cursor-pointer group">
                            <input type="checkbox" name="terms" required class="w-5 h-5 text-primary-600 border-gray-300 rounded focus:ring-primary-500 mt-0.5 flex-shrink-0">
                            <span class="ml-3 text-sm text-gray-700 group-hover:text-gray-900">
                                J'accepte les <a href="#" class="text-primary-600 hover:text-primary-700 font-semibold underline">conditions d'utilisation</a> et la <a href="#" class="text-primary-600 hover:text-primary-700 font-semibold underline">politique de confidentialité</a> de la Clinique Digitale
                            </span>
                        </label>
                    </div>
                    
                    <!-- Submit Button -->
                    <button 
                        type="submit" 
                        class="w-full bg-gradient-to-r from-primary-600 to-secondary-600 text-white py-4 px-6 rounded-xl font-bold text-lg hover:from-primary-700 hover:to-secondary-700 transition-all shadow-lg hover:shadow-xl transform hover:scale-[1.02] active:scale-[0.98] flex items-center justify-center gap-3"
                    >
                        <i class="fas fa-user-plus text-xl"></i>
                        <span>Créer Mon Compte Patient</span>
                        <i class="fas fa-arrow-right"></i>
                    </button>

                    <!-- Additional Info -->
                    <div class="flex items-center justify-center gap-8 text-sm text-gray-500 flex-wrap">
                        <div class="flex items-center gap-2">
                            <i class="fas fa-check-circle text-green-500"></i>
                            <span>Inscription gratuite</span>
                        </div>
                        <div class="flex items-center gap-2">
                            <i class="fas fa-lock text-primary-500"></i>
                            <span>Données sécurisées</span>
                        </div>
                        <div class="flex items-center gap-2">
                            <i class="fas fa-clock text-secondary-600"></i>
                            <span>Prise de RDV rapide</span>
                        </div>
                    </div>
                </form>

                <!-- Sign In Link -->
                <div class="mt-8 text-center p-6 bg-gray-50 rounded-xl">
                    <p class="text-gray-600">
                        Vous avez déjà un compte ?
                        <a href="${pageContext.request.contextPath}/login" class="font-semibold text-primary-600 hover:text-primary-700 transition-colors ml-1 inline-flex items-center gap-1">
                            Se connecter
                            <i class="fas fa-sign-in-alt text-sm"></i>
                        </a>
                    </p>
                </div>
            </div>
        </div>

        <!-- Footer Note -->
        <div class="text-center mt-6">
            <p class="text-white/90 text-sm flex items-center justify-center gap-2">
                <i class="fas fa-shield-alt"></i>
                <span>Vos données sont protégées conformément au RGPD</span>
            </p>
        </div>
    </div>

    <script>
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
        const passwordInput = document.getElementById('password');
        const confirmPasswordInput = document.getElementById('confirmPassword');
        const matchMessage = document.getElementById('password-match-message');

        confirmPasswordInput.addEventListener('input', function() {
            const password = passwordInput.value;
            const confirmPassword = this.value;

            if (confirmPassword) {
                matchMessage.classList.remove('hidden');

                if (password !== confirmPassword) {
                    this.setCustomValidity('Les mots de passe ne correspondent pas');
                    this.classList.add('border-red-500');
                    this.classList.remove('border-gray-200', 'border-green-500');
                    matchMessage.innerHTML = '<i class="fas fa-times-circle text-red-500 mr-1"></i>Les mots de passe ne correspondent pas';
                    matchMessage.className = 'mt-1 text-xs text-red-600';
                } else {
                    this.setCustomValidity('');
                    this.classList.add('border-green-500');
                    this.classList.remove('border-gray-200', 'border-red-500');
                    matchMessage.innerHTML = '<i class="fas fa-check-circle text-green-500 mr-1"></i>Les mots de passe correspondent';
                    matchMessage.className = 'mt-1 text-xs text-green-600';
                }
            } else {
                matchMessage.classList.add('hidden');
                this.classList.remove('border-red-500', 'border-green-500');
                this.classList.add('border-gray-200');
            }
        });

        // Auto-focus on first input
        document.addEventListener('DOMContentLoaded', function() {
            document.getElementById('firstName').focus();
        });

        // Form submission loading state
        document.querySelector('form').addEventListener('submit', function(e) {
            const submitBtn = this.querySelector('button[type="submit"]');
            submitBtn.disabled = true;
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin text-xl"></i><span>Création en cours...</span>';
        });
    </script>
</body>
</html>
