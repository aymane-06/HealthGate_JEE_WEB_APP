<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tableau de Bord Médecin - Clinique Digitale</title>
    
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
    
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    
    <style>
        * { font-family: 'Inter', sans-serif; }
    </style>
</head>
<body class="bg-gray-50">
    <div class="flex h-screen overflow-hidden">
        
        <!-- Sidebar -->
        <aside class="w-64 bg-gradient-to-b from-secondary-900 to-secondary-800 text-white flex-shrink-0 hidden md:flex flex-col shadow-2xl">
            <div class="p-6 border-b border-secondary-700">
                <div class="flex items-center space-x-3">
                    <i class="fas fa-hospital text-3xl text-secondary-400"></i>
                    <div>
                        <h1 class="text-xl font-bold">Clinique</h1>
                        <p class="text-xs text-secondary-200">Espace Médecin</p>
                    </div>
                </div>
            </div>
            
            <div class="p-6 border-b border-secondary-700">
                <div class="flex items-center space-x-3">
                    <div class="w-12 h-12 bg-gradient-to-br from-primary-500 to-primary-600 rounded-full flex items-center justify-center text-white font-bold text-lg shadow-lg">
                        DR
                    </div>
                    <div class="flex-1 min-w-0">
                        <p class="font-semibold truncate">Dr. ${sessionScope.user.firstName} ${sessionScope.user.lastName}</p>
                        <p class="text-xs text-secondary-200 truncate">Cardiologue</p>
                    </div>
                </div>
            </div>
            
            <nav class="flex-1 p-4 overflow-y-auto">
                <ul class="space-y-2">
                    <li>
                        <a href="${pageContext.request.contextPath}/doctor/dashboard" class="flex items-center space-x-3 p-3 rounded-lg bg-secondary-700/50 text-white">
                            <i class="fas fa-chart-line w-5"></i>
                            <span class="font-medium">Tableau de bord</span>
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/doctor/appointments" class="flex items-center space-x-3 p-3 rounded-lg hover:bg-secondary-700/30 transition-colors text-secondary-100 hover:text-white">
                            <i class="fas fa-calendar-alt w-5"></i>
                            <span class="font-medium">Mes Rendez-vous</span>
                            <span class="ml-auto bg-red-500 text-white text-xs px-2 py-1 rounded-full">8</span>
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/doctor/patients" class="flex items-center space-x-3 p-3 rounded-lg hover:bg-secondary-700/30 transition-colors text-secondary-100 hover:text-white">
                            <i class="fas fa-hospital-user w-5"></i>
                            <span class="font-medium">Mes Patients</span>
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/doctor/availability" class="flex items-center space-x-3 p-3 rounded-lg hover:bg-secondary-700/30 transition-colors text-secondary-100 hover:text-white">
                            <i class="fas fa-clock w-5"></i>
                            <span class="font-medium">Disponibilités</span>
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/doctor/consultations" class="flex items-center space-x-3 p-3 rounded-lg hover:bg-secondary-700/30 transition-colors text-secondary-100 hover:text-white">
                            <i class="fas fa-notes-medical w-5"></i>
                            <span class="font-medium">Consultations</span>
                        </a>
                    </li>
                </ul>
                
                <div class="mt-6 pt-6 border-t border-secondary-700">
                    <ul class="space-y-2">
                        <li>
                            <a href="${pageContext.request.contextPath}/profile" class="flex items-center space-x-3 p-3 rounded-lg hover:bg-secondary-700/30 transition-colors text-secondary-100 hover:text-white">
                                <i class="fas fa-user-circle w-5"></i>
                                <span class="font-medium">Mon Profil</span>
                            </a>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/logout" class="flex items-center space-x-3 p-3 rounded-lg hover:bg-red-600/80 transition-colors text-secondary-100 hover:text-white">
                                <i class="fas fa-sign-out-alt w-5"></i>
                                <span class="font-medium">Déconnexion</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>
        </aside>
        
        <!-- Main Content -->
        <div class="flex-1 flex flex-col overflow-hidden">
            
            <!-- Top Bar -->
            <header class="bg-white shadow-sm border-b border-gray-200">
                <div class="flex items-center justify-between p-4">
                    <div class="flex items-center space-x-4">
                        <button id="menu-toggle" class="md:hidden text-gray-600 hover:text-gray-900">
                            <i class="fas fa-bars text-2xl"></i>
                        </button>
                        <div>
                            <h2 class="text-2xl font-bold text-gray-900">Bonjour, Dr. ${sessionScope.user.lastName} 👨‍⚕️</h2>
                            <p class="text-sm text-gray-500">Voici votre activité aujourd'hui</p>
                        </div>
                    </div>
                    
                    <div class="flex items-center space-x-4">
                        <div class="hidden sm:flex items-center space-x-2 bg-gray-100 rounded-lg px-4 py-2">
                            <i class="fas fa-calendar text-secondary-600"></i>
                            <span class="text-sm font-medium text-gray-700">Lundi 07 Oct 2024</span>
                        </div>
                        <div class="relative">
                            <button class="relative p-2 text-gray-600 hover:text-gray-900 hover:bg-gray-100 rounded-lg transition-colors">
                                <i class="fas fa-bell text-xl"></i>
                                <span class="absolute top-1 right-1 w-2 h-2 bg-red-500 rounded-full"></span>
                            </button>
                        </div>
                    </div>
                </div>
            </header>
            
            <!-- Main Content Area -->
            <main class="flex-1 overflow-x-hidden overflow-y-auto bg-gray-50 p-6">
                
                <!-- Stats Grid -->
                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6 mb-6">
                    <div class="bg-gradient-to-br from-secondary-500 to-secondary-600 rounded-2xl shadow-lg p-6 text-white transform hover:scale-105 transition-transform">
                        <div class="flex items-center justify-between mb-4">
                            <div class="bg-white/20 p-3 rounded-xl">
                                <i class="fas fa-calendar-day text-2xl"></i>
                            </div>
                            <span class="text-sm font-semibold bg-white/20 px-3 py-1 rounded-full">Aujourd'hui</span>
                        </div>
                        <h3 class="text-4xl font-bold mb-1">${stats.todayAppointments != null ? stats.todayAppointments : '8'}</h3>
                        <p class="text-secondary-100">Rendez-vous</p>
                    </div>
                    
                    <div class="bg-gradient-to-br from-primary-500 to-primary-600 rounded-2xl shadow-lg p-6 text-white transform hover:scale-105 transition-transform">
                        <div class="flex items-center justify-between mb-4">
                            <div class="bg-white/20 p-3 rounded-xl">
                                <i class="fas fa-users text-2xl"></i>
                            </div>
                            <span class="text-sm font-semibold bg-white/20 px-3 py-1 rounded-full">Total</span>
                        </div>
                        <h3 class="text-4xl font-bold mb-1">${stats.totalPatients != null ? stats.totalPatients : '156'}</h3>
                        <p class="text-primary-100">Patients</p>
                    </div>
                    
                    <div class="bg-gradient-to-br from-purple-500 to-purple-600 rounded-2xl shadow-lg p-6 text-white transform hover:scale-105 transition-transform">
                        <div class="flex items-center justify-between mb-4">
                            <div class="bg-white/20 p-3 rounded-xl">
                                <i class="fas fa-check-circle text-2xl"></i>
                            </div>
                            <span class="text-sm font-semibold bg-white/20 px-3 py-1 rounded-full">Ce mois</span>
                        </div>
                        <h3 class="text-4xl font-bold mb-1">${stats.monthlyConsultations != null ? stats.monthlyConsultations : '42'}</h3>
                        <p class="text-purple-100">Consultations</p>
                    </div>
                    
                    <div class="bg-gradient-to-br from-orange-500 to-orange-600 rounded-2xl shadow-lg p-6 text-white transform hover:scale-105 transition-transform">
                        <div class="flex items-center justify-between mb-4">
                            <div class="bg-white/20 p-3 rounded-xl">
                                <i class="fas fa-star text-2xl"></i>
                            </div>
                            <span class="text-sm font-semibold bg-white/20 px-3 py-1 rounded-full">Note</span>
                        </div>
                        <h3 class="text-4xl font-bold mb-1">4.8/5</h3>
                        <p class="text-orange-100">Satisfaction</p>
                    </div>
                </div>
                
                <!-- Today's Appointments & Calendar -->
                <div class="grid grid-cols-1 lg:grid-cols-3 gap-6 mb-6">
                    <!-- Today's Appointments -->
                    <div class="lg:col-span-2 bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
                        <div class="p-6 border-b border-gray-100 flex items-center justify-between">
                            <div>
                                <h3 class="text-lg font-bold text-gray-900">Rendez-vous d'Aujourd'hui</h3>
                                <p class="text-sm text-gray-500">8 patients prévus</p>
                            </div>
                            <a href="${pageContext.request.contextPath}/doctor/appointments" class="text-sm font-semibold text-primary-600 hover:text-primary-700">
                                Voir tout <i class="fas fa-arrow-right ml-1"></i>
                            </a>
                        </div>
                        <div class="p-6 space-y-4">
                            <div class="flex items-start space-x-4 p-4 bg-green-50 border border-green-200 rounded-xl hover:shadow-md transition-shadow">
                                <div class="w-12 h-12 bg-gradient-to-br from-green-500 to-green-600 rounded-full flex items-center justify-center text-white font-bold flex-shrink-0">
                                    SM
                                </div>
                                <div class="flex-1 min-w-0">
                                    <div class="flex items-center justify-between mb-1">
                                        <p class="font-bold text-gray-900">Sarah Martin</p>
                                        <span class="text-xs font-semibold bg-green-100 text-green-700 px-3 py-1 rounded-full">En cours</span>
                                    </div>
                                    <p class="text-sm text-gray-600 mb-2">Consultation de contrôle</p>
                                    <div class="flex items-center space-x-4 text-xs text-gray-500">
                                        <span><i class="far fa-clock mr-1"></i>09:00 - 09:30</span>
                                        <span><i class="fas fa-phone mr-1"></i>+212 6XX XX XX XX</span>
                                    </div>
                                </div>
                                <button class="px-4 py-2 bg-secondary-600 text-white rounded-lg hover:bg-secondary-700 transition-colors text-sm font-semibold">
                                    <i class="fas fa-notes-medical mr-1"></i>
                                    Consulter
                                </button>
                            </div>
                            
                            <div class="flex items-start space-x-4 p-4 bg-gray-50 border border-gray-200 rounded-xl hover:shadow-md transition-shadow">
                                <div class="w-12 h-12 bg-gradient-to-br from-primary-500 to-primary-600 rounded-full flex items-center justify-center text-white font-bold flex-shrink-0">
                                    AK
                                </div>
                                <div class="flex-1 min-w-0">
                                    <div class="flex items-center justify-between mb-1">
                                        <p class="font-bold text-gray-900">Ahmed Khalil</p>
                                        <span class="text-xs font-semibold bg-blue-100 text-blue-700 px-3 py-1 rounded-full">Prévu</span>
                                    </div>
                                    <p class="text-sm text-gray-600 mb-2">Première consultation</p>
                                    <div class="flex items-center space-x-4 text-xs text-gray-500">
                                        <span><i class="far fa-clock mr-1"></i>10:00 - 10:30</span>
                                        <span><i class="fas fa-phone mr-1"></i>+212 6XX XX XX XX</span>
                                    </div>
                                </div>
                                <button class="px-4 py-2 bg-gray-200 text-gray-700 rounded-lg hover:bg-gray-300 transition-colors text-sm font-semibold">
                                    <i class="fas fa-info-circle mr-1"></i>
                                    Détails
                                </button>
                            </div>
                            
                            <div class="flex items-start space-x-4 p-4 bg-gray-50 border border-gray-200 rounded-xl hover:shadow-md transition-shadow">
                                <div class="w-12 h-12 bg-gradient-to-br from-purple-500 to-purple-600 rounded-full flex items-center justify-center text-white font-bold flex-shrink-0">
                                    FZ
                                </div>
                                <div class="flex-1 min-w-0">
                                    <div class="flex items-center justify-between mb-1">
                                        <p class="font-bold text-gray-900">Fatima Zahra</p>
                                        <span class="text-xs font-semibold bg-blue-100 text-blue-700 px-3 py-1 rounded-full">Prévu</span>
                                    </div>
                                    <p class="text-sm text-gray-600 mb-2">Suivi post-opératoire</p>
                                    <div class="flex items-center space-x-4 text-xs text-gray-500">
                                        <span><i class="far fa-clock mr-1"></i>11:00 - 11:30</span>
                                        <span><i class="fas fa-phone mr-1"></i>+212 6XX XX XX XX</span>
                                    </div>
                                </div>
                                <button class="px-4 py-2 bg-gray-200 text-gray-700 rounded-lg hover:bg-gray-300 transition-colors text-sm font-semibold">
                                    <i class="fas fa-info-circle mr-1"></i>
                                    Détails
                                </button>
                            </div>
                            
                            <div class="text-center pt-2">
                                <a href="${pageContext.request.contextPath}/doctor/appointments" class="text-sm font-semibold text-primary-600 hover:text-primary-700">
                                    + 5 autres rendez-vous
                                </a>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Quick Actions -->
                    <div class="space-y-6">
                        <div class="bg-gradient-to-br from-primary-600 to-primary-700 rounded-2xl shadow-lg p-6 text-white">
                            <h3 class="text-lg font-bold mb-4">Actions Rapides</h3>
                            <div class="space-y-3">
                                <button class="w-full bg-white/20 hover:bg-white/30 backdrop-blur-sm rounded-xl p-3 text-left transition-all">
                                    <i class="fas fa-calendar-plus mr-3"></i>
                                    Nouvelle Consultation
                                </button>
                                <button class="w-full bg-white/20 hover:bg-white/30 backdrop-blur-sm rounded-xl p-3 text-left transition-all">
                                    <i class="fas fa-prescription mr-3"></i>
                                    Créer Ordonnance
                                </button>
                                <button class="w-full bg-white/20 hover:bg-white/30 backdrop-blur-sm rounded-xl p-3 text-left transition-all">
                                    <i class="fas fa-user-plus mr-3"></i>
                                    Nouveau Patient
                                </button>
                                <button class="w-full bg-white/20 hover:bg-white/30 backdrop-blur-sm rounded-xl p-3 text-left transition-all">
                                    <i class="fas fa-clock mr-3"></i>
                                    Gérer Disponibilités
                                </button>
                            </div>
                        </div>
                        
                        <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-6">
                            <h3 class="text-lg font-bold text-gray-900 mb-4">Statistiques du Mois</h3>
                            <div class="space-y-4">
                                <div>
                                    <div class="flex items-center justify-between mb-2">
                                        <span class="text-sm text-gray-600">Taux de présence</span>
                                        <span class="text-sm font-bold text-green-600">92%</span>
                                    </div>
                                    <div class="w-full bg-gray-200 rounded-full h-2">
                                        <div class="bg-green-500 h-2 rounded-full" style="width: 92%"></div>
                                    </div>
                                </div>
                                <div>
                                    <div class="flex items-center justify-between mb-2">
                                        <span class="text-sm text-gray-600">Nouveaux patients</span>
                                        <span class="text-sm font-bold text-primary-600">78%</span>
                                    </div>
                                    <div class="w-full bg-gray-200 rounded-full h-2">
                                        <div class="bg-primary-500 h-2 rounded-full" style="width: 78%"></div>
                                    </div>
                                </div>
                                <div>
                                    <div class="flex items-center justify-between mb-2">
                                        <span class="text-sm text-gray-600">Satisfaction</span>
                                        <span class="text-sm font-bold text-secondary-600">96%</span>
                                    </div>
                                    <div class="w-full bg-gray-200 rounded-full h-2">
                                        <div class="bg-secondary-500 h-2 rounded-full" style="width: 96%"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Recent Consultations -->
                <div class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
                    <div class="p-6 border-b border-gray-100">
                        <h3 class="text-lg font-bold text-gray-900">Consultations Récentes</h3>
                    </div>
                    <div class="overflow-x-auto">
                        <table class="w-full">
                            <thead class="bg-gray-50">
                                <tr>
                                    <th class="px-6 py-3 text-left text-xs font-semibold text-gray-600 uppercase">Patient</th>
                                    <th class="px-6 py-3 text-left text-xs font-semibold text-gray-600 uppercase">Type</th>
                                    <th class="px-6 py-3 text-left text-xs font-semibold text-gray-600 uppercase">Date</th>
                                    <th class="px-6 py-3 text-left text-xs font-semibold text-gray-600 uppercase">Diagnostic</th>
                                    <th class="px-6 py-3 text-left text-xs font-semibold text-gray-600 uppercase">Actions</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-gray-100">
                                <tr class="hover:bg-gray-50 transition-colors">
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <div class="flex items-center">
                                            <div class="w-10 h-10 bg-gradient-to-br from-primary-500 to-primary-600 rounded-full flex items-center justify-center text-white font-bold mr-3">MB</div>
                                            <div>
                                                <div class="font-medium text-gray-900">Mohamed Bennani</div>
                                                <div class="text-sm text-gray-500">45 ans</div>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <span class="px-3 py-1 text-xs font-semibold rounded-full bg-green-100 text-green-700">Contrôle</span>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">06 Oct 2024</td>
                                    <td class="px-6 py-4 text-sm text-gray-600">Hypertension stable</td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm">
                                        <button class="text-primary-600 hover:text-primary-700 font-semibold">
                                            <i class="fas fa-eye mr-1"></i>Voir
                                        </button>
                                    </td>
                                </tr>
                                <tr class="hover:bg-gray-50 transition-colors">
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <div class="flex items-center">
                                            <div class="w-10 h-10 bg-gradient-to-br from-purple-500 to-purple-600 rounded-full flex items-center justify-center text-white font-bold mr-3">LB</div>
                                            <div>
                                                <div class="font-medium text-gray-900">Laila Bouzid</div>
                                                <div class="text-sm text-gray-500">32 ans</div>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <span class="px-3 py-1 text-xs font-semibold rounded-full bg-blue-100 text-blue-700">Première</span>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">05 Oct 2024</td>
                                    <td class="px-6 py-4 text-sm text-gray-600">Douleurs thoraciques</td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm">
                                        <button class="text-primary-600 hover:text-primary-700 font-semibold">
                                            <i class="fas fa-eye mr-1"></i>Voir
                                        </button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                
            </main>
        </div>
    </div>
    
    <script>
        // Mobile menu toggle (if needed)
        const menuToggle = document.getElementById('menu-toggle');
        if (menuToggle) {
            menuToggle.addEventListener('click', () => {
                alert('Mobile menu functionality to be implemented');
            });
        }
    </script>
</body>
</html>
