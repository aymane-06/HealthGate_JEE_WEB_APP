<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion - Clinique Digitale</title>
    
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
        * {
            font-family: 'Inter', sans-serif;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .animate-fadeIn {
            animation: fadeIn 0.8s ease-out;
        }
        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-20px); }
        }
        .animate-float {
            animation: float 3s ease-in-out infinite;
        }
    </style>
</head>
<body class="bg-gradient-to-br from-primary-900 via-primary-700 to-secondary-600 min-h-screen flex items-center justify-center p-4">
    
    <!-- Background Pattern -->
    <div class="absolute inset-0 opacity-10 overflow-hidden">
        <div class="absolute inset-0" style="background-image: url('data:image/svg+xml,%3Csvg width=&quot;60&quot; height=&quot;60&quot; viewBox=&quot;0 0 60 60&quot; xmlns=&quot;http://www.w3.org/2000/svg&quot;%3E%3Cg fill=&quot;none&quot; fill-rule=&quot;evenodd&quot;%3E%3Cg fill=&quot;%23ffffff&quot; fill-opacity=&quot;0.4&quot;%3E%3Cpath d=&quot;M36 34v-4h-2v4h-4v2h4v4h2v-4h4v-2h-4zm0-30V0h-2v4h-4v2h4v4h2V6h4V4h-4zM6 34v-4H4v4H0v2h4v4h2v-4h4v-2H6zM6 4V0H4v4H0v2h4v4h2V6h4V4H6z&quot;/%3E%3C/g%3E%3C/g%3E%3C/svg%3E');"></div>
    </div>
    
    <!-- Login Container -->
    <div class="relative w-full max-w-6xl">
        <div class="grid grid-cols-1 lg:grid-cols-2 bg-white rounded-3xl shadow-2xl overflow-hidden animate-fadeIn">
            
            <!-- Left Side - Illustration/Welcome -->
            <div class="hidden lg:flex flex-col justify-center items-center p-12 bg-gradient-to-br from-primary-600 to-primary-800 text-white relative overflow-hidden">
                <!-- Decorative Elements -->
                <div class="absolute top-0 right-0 w-64 h-64 bg-white/10 rounded-full -translate-y-1/2 translate-x-1/2"></div>
                <div class="absolute bottom-0 left-0 w-96 h-96 bg-white/10 rounded-full translate-y-1/2 -translate-x-1/2"></div>
                
                <div class="relative z-10 text-center">
                    <div class="animate-float mb-8">
                        <div class="bg-white/20 backdrop-blur-lg rounded-3xl p-8 inline-block">
                            <i class="fas fa-hospital text-8xl text-white"></i>
                        </div>
                    </div>
                    
                    <h2 class="text-4xl font-bold mb-4">
                        Bienvenue à la<br>Clinique Digitale
                    </h2>
                    <p class="text-lg text-primary-100 mb-8 max-w-md mx-auto">
                        Votre santé, notre priorité. Connectez-vous pour accéder à vos soins de santé personnalisés.
                    </p>
                    
                    <!-- Feature Pills -->
                    <div class="space-y-4">
                        <div class="bg-white/20 backdrop-blur-sm rounded-xl p-4 flex items-center space-x-3 max-w-sm mx-auto">
                            <div class="bg-secondary-500 rounded-lg p-2">
                                <i class="fas fa-shield-alt text-white text-xl"></i>
                            </div>
                            <div class="text-left">
                                <div class="font-semibold">Sécurisé & Confidentiel</div>
                                <div class="text-sm text-primary-200">Vos données sont protégées</div>
                            </div>
                        </div>
                        
                        <div class="bg-white/20 backdrop-blur-sm rounded-xl p-4 flex items-center space-x-3 max-w-sm mx-auto">
                            <div class="bg-green-500 rounded-lg p-2">
                                <i class="fas fa-clock text-white text-xl"></i>
                            </div>
                            <div class="text-left">
                                <div class="font-semibold">Accessible 24/7</div>
                                <div class="text-sm text-primary-200">Consultez à tout moment</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Right Side - Login Form -->
            <div class="p-8 sm:p-12 flex flex-col justify-center">
                <!-- Logo for Mobile -->
                <div class="lg:hidden text-center mb-8">
                    <a href="${pageContext.request.contextPath}/" class="inline-flex items-center space-x-2">
                        <i class="fas fa-hospital text-4xl text-primary-600"></i>
                        <span class="text-2xl font-bold text-gray-900">Clinique Digitale</span>
                    </a>
                </div>
                
                <!-- Back Button -->
                <div class="mb-6">
                    <a href="${pageContext.request.contextPath}/" class="inline-flex items-center text-gray-600 hover:text-primary-600 transition-colors">
                        <i class="fas fa-arrow-left mr-2"></i>
                        <span>Retour à l'accueil</span>
                    </a>
                </div>
                
                <!-- Form Header -->
                <div class="mb-8">
                    <h1 class="text-3xl sm:text-4xl font-bold text-gray-900 mb-2">
                        Connexion
                    </h1>
                    <p class="text-gray-600">
                        Entrez vos identifiants pour accéder à votre espace
                    </p>
                </div>
                
                <!-- Error Message -->
                <c:if test="${not empty error}">
                    <div class="mb-6 bg-red-50 border-l-4 border-red-500 p-4 rounded-lg">
                        <div class="flex items-start">
                            <i class="fas fa-exclamation-circle text-red-500 mt-0.5 mr-3"></i>
                            <div>
                                <p class="font-semibold text-red-800">Erreur de connexion</p>
                                <p class="text-sm text-red-700">${error}</p>
                            </div>
                        </div>
                    </div>
                </c:if>
                
                <!-- Success Message -->
                <c:if test="${not empty success}">
                    <div class="mb-6 bg-green-50 border-l-4 border-green-500 p-4 rounded-lg">
                        <div class="flex items-start">
                            <i class="fas fa-check-circle text-green-500 mt-0.5 mr-3"></i>
                            <div>
                                <p class="text-sm text-green-700">${success}</p>
                            </div>
                        </div>
                    </div>
                </c:if>
                
                <!-- Login Form -->
                <form action="${pageContext.request.contextPath}/login" method="post" class="space-y-6">
                    <!-- Email Field -->
                    <div>
                        <label for="email" class="block text-sm font-semibold text-gray-700 mb-2">
                            Adresse Email
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
                                placeholder="votre.email@exemple.com"
                            >
                        </div>
                    </div>
                    
                    <!-- Password Field -->
                    <div>
                        <label for="password" class="block text-sm font-semibold text-gray-700 mb-2">
                            Mot de Passe
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
                                class="w-full pl-12 pr-12 py-3.5 border-2 border-gray-200 rounded-xl focus:border-primary-500 focus:ring-4 focus:ring-primary-100 transition-all outline-none text-gray-900"
                                placeholder="••••••••"
                            >
                            <button 
                                type="button" 
                                onclick="togglePassword()" 
                                class="absolute inset-y-0 right-0 pr-4 flex items-center text-gray-400 hover:text-gray-600"
                            >
                                <i id="eye-icon" class="fas fa-eye"></i>
                            </button>
                        </div>
                    </div>
                    
                    <!-- Remember Me & Forgot Password -->
                    <div class="flex items-center justify-between">
                        <label class="flex items-center cursor-pointer group">
                            <input type="checkbox" name="remember" class="w-5 h-5 text-primary-600 border-gray-300 rounded focus:ring-primary-500">
                            <span class="ml-2 text-sm text-gray-600 group-hover:text-gray-900">
                                Se souvenir de moi
                            </span>
                        </label>
                        <a href="${pageContext.request.contextPath}/auth/forgot-password" class="text-sm font-semibold text-primary-600 hover:text-primary-700 transition-colors">
                            Mot de passe oublié ?
                        </a>
                    </div>
                    
                    <!-- Submit Button -->
                    <button 
                        type="submit" 
                        class="w-full bg-gradient-to-r from-primary-600 to-primary-700 text-white py-4 rounded-xl font-semibold hover:from-primary-700 hover:to-primary-800 transition-all shadow-lg hover:shadow-xl transform hover:scale-[1.02] active:scale-[0.98]"
                    >
                        <i class="fas fa-sign-in-alt mr-2"></i>
                        Se Connecter
                    </button>
                </form>
                
                <!-- Divider -->
                <div class="my-8 flex items-center">
                    <div class="flex-1 border-t border-gray-200"></div>
                    <span class="px-4 text-sm text-gray-500">OU</span>
                    <div class="flex-1 border-t border-gray-200"></div>
                </div>
                
                <!-- Social Login (Optional) -->
                <div class="grid grid-cols-2 gap-4">
                    <button class="flex items-center justify-center space-x-2 px-4 py-3 border-2 border-gray-200 rounded-xl hover:border-gray-300 hover:bg-gray-50 transition-all">
                        <i class="fab fa-google text-red-500 text-xl"></i>
                        <span class="font-medium text-gray-700">Google</span>
                    </button>
                    <button class="flex items-center justify-center space-x-2 px-4 py-3 border-2 border-gray-200 rounded-xl hover:border-gray-300 hover:bg-gray-50 transition-all">
                        <i class="fab fa-facebook-f text-blue-600 text-xl"></i>
                        <span class="font-medium text-gray-700">Facebook</span>
                    </button>
                </div>
                
                <!-- Sign Up Link -->
                <div class="mt-8 text-center">
                    <p class="text-gray-600">
                        Vous n'avez pas de compte ?
                        <a href="${pageContext.request.contextPath}/register" class="font-semibold text-primary-600 hover:text-primary-700 transition-colors ml-1">
                            S'inscrire maintenant
                        </a>
                    </p>
                </div>
            </div>
        </div>
        
        <!-- Footer Note -->
        <div class="text-center mt-8">
            <p class="text-white/80 text-sm">
                <i class="fas fa-shield-alt mr-1"></i>
                Connexion sécurisée avec cryptage SSL
            </p>
        </div>
    </div>
    
    <script>
        function togglePassword() {
            const passwordInput = document.getElementById('password');
            const eyeIcon = document.getElementById('eye-icon');
            
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
        
        // Auto-focus on first input
        document.addEventListener('DOMContentLoaded', function() {
            document.getElementById('email').focus();
        });
    </script>
</body>
</html>
